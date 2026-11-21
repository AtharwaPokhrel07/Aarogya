import 'package:flutter/material.dart';

import 'access_control.dart';

/// Shows [child] only if [user] may view [patientId]'s record; otherwise
/// shows a short "no permission" message. The patient data is never built
/// for unauthorised users.
///
/// Usage:
///   AuthorizedOnly(
///     user: currentUser,
///     patientId: patient.id,
///     child: PatientDetailsCard(patient),
///   )
class AuthorizedOnly extends StatelessWidget {
  final AppUser user;
  final String patientId;
  final Widget child;
  final AccessPolicy policy;

  const AuthorizedOnly({
    super.key,
    required this.user,
    required this.patientId,
    required this.child,
    this.policy = const AccessPolicy(),
  });

  @override
  Widget build(BuildContext context) {
    if (policy.canViewPatientRecord(user, patientId)) return child;

    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.lock_outline),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'You do not have permission to view this patient\'s '
                    'information.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}