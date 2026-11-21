/// Stores whether the user has given informed consent.
///
/// The app depends on [ConsentRepository], not on a storage package, so the
/// team can later swap in a persistent version (e.g. shared_preferences or
/// the backend) without changing any screen code.

library;

class ConsentRecord {
  final String policyVersion;
  final DateTime acceptedAt;

  const ConsentRecord({required this.policyVersion, required this.acceptedAt});
}

abstract class ConsentRepository {
  Future<ConsentRecord?> getConsent();
  Future<void> saveConsent(ConsentRecord record);
  Future<void> withdrawConsent();
}

/// Keeps consent in memory only (lost when the app restarts).
/// Good enough for this sprint; no extra packages needed.
class InMemoryConsentRepository implements ConsentRepository {
  ConsentRecord? _record;

  @override
  Future<ConsentRecord?> getConsent() async => _record;

  @override
  Future<void> saveConsent(ConsentRecord record) async => _record = record;

  @override
  Future<void> withdrawConsent() async => _record = null;
}