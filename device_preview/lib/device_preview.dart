/// Simulate the characteristics of another device — screen metrics, safe
/// areas, locale, brightness, text scale, accessibility flags, target
/// platform — at the engine-abstraction level, with no in-app UI.
///
/// Device presets live in the separate, tree-shakable
/// `package:device_preview/presets.dart` library.
library;

export 'src/model/fit_transform.dart';
export 'src/model/real_device_info.dart';
export 'src/model/simulation.dart';

export 'src/binding/binding.dart'
    show DevicePreviewBinding, DevicePreviewBindingMixin;
export 'src/controller/controller.dart' show DevicePreviewController;
