abstract class PreviewPreference<T> {
  const PreviewPreference();

  const factory PreviewPreference.system() = _System<T>;
  const factory PreviewPreference.overriden(T value) = _Overriden<T>;

  K map<K>({
    required K Function() system,
    required K Function(T value) value,
  }) {
    final result = this;
    if (result is _System<T>) return system();
    if (result is _Overriden<T>) return value(result.value);
    throw Exception();
  }

  T? asNullable() => map(
        system: () => null,
        value: (v) => v,
      );
}

class _System<T> extends PreviewPreference<T> {
  const _System();
}

class _Overriden<T> extends PreviewPreference<T> {
  const _Overriden(this.value);
  final T value;
}
