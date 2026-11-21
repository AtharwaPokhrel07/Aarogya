import 'access_control.dart';
import 'secure_record_store.dart';

class AccessDeniedException implements Exception {
  final String message;
  const AccessDeniedException(this.message);

  @override
  String toString() => message;
}

enum RecordAction { view, edit }

/// One line of the access log. Records WHO tried to do WHAT and whether it
/// was allowed, never the patient data itself.
class AccessLogEntry {
  final String userId;
  final String patientId;
  final RecordAction action;
  final bool allowed;
  final DateTime at;

  const AccessLogEntry({
    required this.userId,
    required this.patientId,
    required this.action,
    required this.allowed,
    required this.at,
  });
}

/// The only way the app should read or write patient records.
/// Every call is checked against the [AccessPolicy] and logged.
class PatientRecordService {
  PatientRecordService({
    required this.store,
    this.policy = const AccessPolicy(),
  });

  final SecureRecordStore store;
  final AccessPolicy policy;
  final List<AccessLogEntry> _log = [];

  List<AccessLogEntry> get accessLog => List.unmodifiable(_log);

  String _key(String patientId) => 'patient_record_$patientId';

  Future<String?> readRecord(AppUser actor, String patientId) async {
    _check(actor, patientId, RecordAction.view,
        policy.canViewPatientRecord(actor, patientId));
    return store.read(_key(patientId));
  }

  Future<void> saveRecord(
      AppUser actor, String patientId, String record) async {
    _check(actor, patientId, RecordAction.edit,
        policy.canEditPatientRecord(actor, patientId));
    await store.write(_key(patientId), record);
  }

  void _check(
      AppUser actor, String patientId, RecordAction action, bool allowed) {
    _log.add(AccessLogEntry(
      userId: actor.id,
      patientId: patientId,
      action: action,
      allowed: allowed,
      at: DateTime.now(),
    ));
    if (!allowed) {
      throw const AccessDeniedException(
          'You are not authorised to access this patient record.');
    }
  }
}