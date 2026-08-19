/// Simulate the characteristics of another device — screen metrics, safe
/// areas, locale, brightness, text scale, accessibility flags, target
/// platform — at the engine-abstraction level, with no in-app UI.
///
/// Device presets live in the separate, tree-shakable
/// `package:device_preview/presets.dart` library, and the embedded SVG subset
/// renderer used to draw device bodies in
/// `package:device_preview/svg.dart`.
library;

export 'src/model/device_frame.dart';
export 'src/model/device_kind.dart';
export 'src/model/fit_transform.dart';
export 'src/model/real_device_info.dart';
export 'src/model/simulation.dart';
export 'src/model/system_ui.dart';

export 'src/binding/binding.dart' show DevicePreview, DevicePreviewBindingMixin;
export 'src/controller/controller.dart' show DevicePreviewController;
export 'src/widgets/device_preview_frame.dart'
    show DevicePreviewFrame, RenderDevicePreviewFrame;
export 'src/widgets/dot_grid_decoration.dart';
