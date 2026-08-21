# device_preview_devtools_extension

The DevTools extension web app for the `device_preview` package.
**Never published** (`publish_to: none`) — its compiled output is committed
into `device_preview/extension/devtools/build/` and served by the DevTools
server.

The extension does not import `device_preview` and there is no shared protocol
package: it talks to the running app over the VM service
(`ext.device_preview.*` service extensions), treats JSON loosely (unknown keys
ignored), and pins compatibility via `protocolVersion`.

The device catalog is **local** — generated from `device_specs/*.json` at the
root of the repository into `lib/src/devices/device_catalog.g.dart` — so the
panel lists every device, with artwork, before an app is even attached, and
regardless of the package version it is talking to. (The package generates the
same specs into its own `DevicePresets`, but an app only compiles in the ones
it names.) Presets the app registers itself (`listPresets`) are appended to
the catalog, minus the ids it already covers.

```console
dart run tool/generate_device_catalog.dart          # after editing a spec
dart run tool/generate_device_catalog.dart --check  # what the test guard runs
```

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
- `lib/src/devices/device_catalog.g.dart` — generated device catalog (never
  edited by hand; see `tool/generate_device_catalog.dart` and
  `device_specs/README.md`).

## Local development

Run against the simulated DevTools environment (fake DevTools chrome with a
VM-service URI field and event log):

```console
flutter run -d chrome --dart-define=use_simulated_environment=true
```

Start `device_preview/example` separately and paste its VM service URI into
the simulator's connect field. The device list works without an app attached —
it comes from the generated catalog.

## Build & ship into the parent package

DevTools serves the **built copy** in `device_preview/extension/devtools/build/`,
never this source tree: any panel or catalog change is invisible until you
rebuild it (and reload DevTools — the bundle is cached by the browser).

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
