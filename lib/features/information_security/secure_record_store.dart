/// Where sensitive patient data is kept.
///
/// The rest of the app talks to [SecureRecordStore] only. For a real
/// release, replace [InMemorySecureRecordStore] with an implementation that
/// uses encrypted storage (for example the flutter_secure_storage package,
/// which uses the Android Keystore) and/or the backend. Adding a package
/// changes pubspec.yaml, so agree that with your team first.
library;

// Example of what the real version would look like (do NOT paste into the
// project until the package is added to pubspec.yaml, or the build breaks
// for everyone):
//
//   class EncryptedRecordStore implements SecureRecordStore {
//     final _storage = const FlutterSecureStorage();
//     Future<void> write(String key, String value) =>
//         _storage.write(key: key, value: value);
//     Future<String?> read(String key) => _storage.read(key: key);
//     Future<void> delete(String key) => _storage.delete(key: key);
//   }

abstract class SecureRecordStore {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
}

/// Memory-only store for development and testing. It is NOT encrypted and is
/// lost on restart. Never put real patient data in it.
class InMemorySecureRecordStore implements SecureRecordStore {
  final Map<String, String> _data = {};

  @override
  Future<void> write(String key, String value) async => _data[key] = value;

  @override
  Future<String?> read(String key) async => _data[key];

  @override
  Future<void> delete(String key) async => _data.remove(key);
}