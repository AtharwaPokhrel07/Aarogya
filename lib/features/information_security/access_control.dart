/// Who is allowed to see or change a patient's information (PS-06).
///
/// Rules (deny by default):
///  - A patient can access only their own record.
///  - A doctor can access only the records of patients assigned to them.
///  - Hospital admins manage accounts, not clinical data, so they get no
///    access to patient records.

library;

enum UserRole { patient, doctor, hospitalAdmin }

class AppUser {
  final String id;
  final String name;
  final UserRole role;

  /// Patient ids a doctor is responsible for. Ignored for other roles.
  final Set<String> assignedPatientIds;

  const AppUser({
    required this.id,
    required this.name,
    required this.role,
    this.assignedPatientIds = const {},
  });
}

class AccessPolicy {
  const AccessPolicy();

  bool canViewPatientRecord(AppUser user, String patientId) {
    return switch (user.role) {
      UserRole.patient => user.id == patientId,
      UserRole.doctor => user.assignedPatientIds.contains(patientId),
      UserRole.hospitalAdmin => false,
    };
  }

  bool canEditPatientRecord(AppUser user, String patientId) {
    return switch (user.role) {
      UserRole.patient => user.id == patientId,
      UserRole.doctor => user.assignedPatientIds.contains(patientId),
      UserRole.hospitalAdmin => false,
    };
  }
}