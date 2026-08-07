/// The broad category of a simulated device.
///
/// Lives in the model layer rather than beside [DevicePreset] because
/// [DeviceSimulation] carries it too: it is what an unset
/// `DeviceSimulation.touchInput` follows.
enum DeviceKind {
  /// A phone-sized device.
  phone,

  /// A tablet-sized device.
  tablet,

  /// A foldable device.
  foldable,

  /// A desktop window.
  desktop,
}
