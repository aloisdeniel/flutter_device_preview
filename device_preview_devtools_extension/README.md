# device_preview_devtools_extension

The DevTools extension web app for the `device_preview` package.
**Never published** (`publish_to: none`) — its compiled output is committed
into `device_preview/extension/devtools/build/` and served by the DevTools
server.

The extension does not import `device_preview` and there is no shared protocol
package: it fetches the preset catalog and all state from the running app over
the VM service (`ext.device_preview.*` service extensions), treats JSON
loosely (unknown keys ignored), and pins compatibility via `protocolVersion`.

## Layout

- `lib/main.dart` — `DevToolsExtension` root + shell wiring the real gateway.
- `lib/src/gateway.dart` — the **only** file touching `serviceManager` /
  `extensionManager`.
- `lib/src/gateway_api.dart` — pure-Dart gateway contract (VM-testable).
- `lib/src/panel_controller.dart` — `ChangeNotifier` mirroring app state
  (status, restart re-push, requestId echo suppression, raw-JSON view models).
- `lib/src/panel.dart` — the single-screen UI, sections as private widgets.
- `lib/src/platform/` — conditional `package:web` helpers (localStorage,
  screenshot download) with VM stubs so tests run on the Dart VM.

## Local development

Run against the simulated DevTools environment (fake DevTools chrome with a
VM-service URI field and event log):

```console
flutter run -d chrome --dart-define=use_simulated_environment=true
```

Start `device_preview/example` separately and paste its VM service URI into
the simulator's connect field. A tiny fallback preset list is used **only**
in the simulated environment when no app catalog is reachable.

## Build & ship into the parent package

```console
flutter pub get
dart run devtools_extensions build_and_copy \
  --source=. \
  --dest=../device_preview/extension/devtools
dart run devtools_extensions validate --package=../device_preview
```

## Tests

```console
flutter test
```
