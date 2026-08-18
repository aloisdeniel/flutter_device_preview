// Metrics probe run inside a booted simulator by extract_specs.py.
//
// Prints one `SPECPROBE {json}` line with the device's screen metrics and
// the safe areas UIKit actually applies — portrait first, then after a
// requestGeometryUpdate to landscapeRight — and exits. Built with a bare
// `swiftc -target arm64-apple-ios16.0-simulator`; no Xcode project.

import UIKit

final class ProbeDelegate: NSObject, UIApplicationDelegate {
  var window: UIWindow?
  var portrait: [String: Any]?
  var polls = 0

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = UIViewController()
    window.makeKeyAndVisible()
    self.window = window
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { self.capturePortrait() }
    return true
  }

  func insets(_ window: UIWindow) -> [String: Double] {
    let i = window.safeAreaInsets
    return ["left": i.left, "top": i.top, "right": i.right, "bottom": i.bottom]
  }

  func capturePortrait() {
    guard let window = window, let scene = window.windowScene else { exit(2) }
    let screen = UIScreen.main
    let radius = (screen.value(forKey: "_displayCornerRadius") as? Double) ?? 0
    portrait = [
      "width": screen.bounds.width,
      "height": screen.bounds.height,
      "scale": screen.scale,
      "cornerRadius": radius,
      "statusBar": scene.statusBarManager?.statusBarFrame.height ?? 0,
      "padding": insets(window),
    ]
    scene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscapeRight))
    pollLandscape()
  }

  func pollLandscape() {
    polls += 1
    guard let window = window, let scene = window.windowScene else { exit(2) }
    if scene.interfaceOrientation.isLandscape,
       window.bounds.width > window.bounds.height {
      // One extra runloop turn so the insets settle after rotation.
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { self.report() }
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
