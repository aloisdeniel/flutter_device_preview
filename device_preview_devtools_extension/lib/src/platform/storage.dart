/// Minimal key/value persistence abstraction.
///
/// The real implementation (web builds) is backed by `window.localStorage` so
/// that panel preferences and the "Keep across restarts" simulation stash
/// survive extension iframe reloads. On non-web platforms (unit tests) an
/// in-memory implementation is used instead.
abstract class KeyValueStorage {
  /// Reads the value stored under [key], or null when absent.
  String? read(String key);

  /// Stores [value] under [key].
  void write(String key, String value);

  /// Removes any value stored under [key].
  void remove(String key);
}

/// In-memory [KeyValueStorage], used on non-web platforms and in tests.
class InMemoryStorage implements KeyValueStorage {
  /// Creates an empty in-memory storage.
  InMemoryStorage();

  final Map<String, String> _values = <String, String>{};

  @override
  String? read(String key) => _values[key];

  @override
  void write(String key, String value) => _values[key] = value;

  @override
  void remove(String key) => _values.remove(key);
}
