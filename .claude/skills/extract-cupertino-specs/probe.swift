// Metrics probe run inside a booted simulator by extract_specs.py.
//
// Prints one `SPECPROBE {json}` line with the device's screen metrics, the
// safe areas UIKit actually applies — portrait first, then after a
// requestGeometryUpdate to landscapeRight — and the height the stock
// software keyboard covers in each orientation, then exits. Built with a
// bare `swiftc -target arm64-apple-ios16.0-simulator`; no Xcode project.
//
// The keyboard is measured, not modelled: a text field takes first responder
// and the covered height is read off `keyboardFrameEnd` (intersected with the
// window, which is exactly what an app must lay out around, and what Flutter
// reports as `viewInsets.bottom`). It is best-effort: a runtime that refuses
// to raise a software keyboard reports null rather than failing the run.

import UIKit

final class ProbeDelegate: NSObject, UIApplicationDelegate {
  var window: UIWindow?
  var field: UITextField?
  var portrait: [String: Any]?
  var portraitKeyboard: Double?
  var keyboardHeight: Double = 0
  var polls = 0
  var keyboardPolls = 0

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let controller = UIViewController()
    let field = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
    controller.view.addSubview(field)
    window.rootViewController = controller
    window.makeKeyAndVisible()
    self.window = window
    self.field = field
    for name in [UIResponder.keyboardDidShowNotification,
                 UIResponder.keyboardDidChangeFrameNotification] {
      NotificationCenter.default.addObserver(
        self, selector: #selector(keyboardChanged(_:)), name: name, object: nil)
    }
    field.becomeFirstResponder()
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { self.awaitKeyboard() }
    return true
  }

  @objc func keyboardChanged(_ note: Notification) {
    guard let window = window,
          let end = note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? NSValue else { return }
    let frame = window.convert(end.cgRectValue, from: nil)
    keyboardHeight = window.bounds.intersection(frame).height
  }

  func insets(_ window: UIWindow) -> [String: Double] {
    let i = window.safeAreaInsets
    return ["left": i.left, "top": i.top, "right": i.right, "bottom": i.bottom]
  }

  /// Waits (up to ~5 s) for the software keyboard to settle, then continues.
  ///
  /// A run that never raises one is not an error: the keyboard height is the
  /// only optional part of this probe.
  func awaitKeyboard(_ next: (() -> Void)? = nil) {
    keyboardPolls += 1
    if keyboardHeight > 0 || keyboardPolls > 50 {
      keyboardPolls = 0
      (next ?? capturePortrait)()
      return
    }
    // Re-assert focus: a keyboard dismissed by the rotation comes back.
    if keyboardPolls % 10 == 0 { field?.becomeFirstResponder() }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      self.awaitKeyboard(next)
    }
  }

  func capturePortrait() {
    guard let window = window, let scene = window.windowScene else { exit(2) }
    let screen = UIScreen.main
    let radius = (screen.value(forKey: "_displayCornerRadius") as? Double) ?? 0
    portraitKeyboard = keyboardHeight > 0 ? keyboardHeight : nil
    portrait = [
      "width": screen.bounds.width,
      "height": screen.bounds.height,
      "scale": screen.scale,
      "cornerRadius": radius,
      "statusBar": scene.statusBarManager?.statusBarFrame.height ?? 0,
      "padding": insets(window),
    ]
    keyboardHeight = 0
    scene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscapeRight))
    pollLandscape()
  }

  func pollLandscape() {
    polls += 1
    guard let window = window, let scene = window.windowScene else { exit(2) }
    if scene.interfaceOrientation.isLandscape,
       window.bounds.width > window.bounds.height {
      // One extra runloop turn so the insets settle after rotation, then the
      // keyboard again — it is re-laid-out for the new orientation.
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.awaitKeyboard(self.report)
      }
      return
    }
    if polls > 50 {  // iPads may refuse; report portrait-only.
      report()
      return
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { self.pollLandscape() }
  }

  func report() {
    guard let window = window, var result = portrait else { exit(2) }
    result["landscapePadding"] = insets(window)
    result["landscapeIsLandscape"] = window.bounds.width > window.bounds.height
    // JSONSerialization rejects a boxed Optional: absent means NSNull.
    result["portraitKeyboard"] = portraitKeyboard.map { $0 as Any } ?? NSNull()
    result["landscapeKeyboard"] =
      keyboardHeight > 0 ? (keyboardHeight as Any) : NSNull()
    let data = try! JSONSerialization.data(withJSONObject: result)
    print("SPECPROBE " + String(data: data, encoding: .utf8)!)
    fflush(stdout)
    exit(0)
  }
}

UIApplicationMain(
  CommandLine.argc,
  CommandLine.unsafeArgv,
  nil,
  NSStringFromClass(ProbeDelegate.self)
)
