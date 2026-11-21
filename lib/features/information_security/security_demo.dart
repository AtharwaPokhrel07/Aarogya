import 'package:flutter/material.dart';

import 'access_control.dart';
import 'authorized_only.dart';
import 'patient_record_service.dart';
import 'secure_record_store.dart';

/// Test harness for PS-06. Run this file directly; it does not touch main.dart.
/// All data here is dummy test data.
void main() => runApp(const SecurityDemoApp());

class SecurityDemoApp extends StatelessWidget {
  const SecurityDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Information security demo',
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: const SecurityDemoScreen(),
    );
  }
}

class SecurityDemoScreen extends StatefulWidget {
  const SecurityDemoScreen({super.key});

  @override
  State<SecurityDemoScreen> createState() => _SecurityDemoScreenState();
}

class _SecurityDemoScreenState extends State<SecurityDemoScreen> {
  static const _drAnjan = AppUser(
    id: 'd1',
    name: 'Dr. Anjan Shrestha (assigned to p1)',
    role: UserRole.doctor,
    assignedPatientIds: {'p1'},
  );
  static const _users = <AppUser>[
    AppUser(id: 'p1', name: 'Patient One', role: UserRole.patient),
    AppUser(id: 'p2', name: 'Patient Two', role: UserRole.patient),
    _drAnjan,
    AppUser(
      id: 'd2',
      name: 'Dr. Other (assigned to p2)',
      role: UserRole.doctor,
      assignedPatientIds: {'p2'},
    ),
    AppUser(id: 'a1', name: 'Hospital Admin', role: UserRole.hospitalAdmin),
  ];
  static const _patientIds = ['p1', 'p2'];

  final _service = PatientRecordService(store: InMemorySecureRecordStore());
  AppUser _user = _drAnjan;
  String _patientId = 'p1';
  String _result = 'Pick a user and a patient, then try an action.';

  @override
  void initState() {
    super.initState();
    _service.saveRecord(_drAnjan, 'p1', 'Dummy record for Patient One.');
  }

  Future<void> _view() async {
    try {
      final record = await _service.readRecord(_user, _patientId);
      if (!mounted) return;
      setState(() => _result = 'ALLOWED: ${record ?? 'No record saved yet.'}');
    } on AccessDeniedException catch (e) {
      if (!mounted) return;
      setState(() => _result = 'DENIED: ${e.message}');
    }
  }

  Future<void> _save() async {
    try {
      await _service.saveRecord(
          _user, _patientId, 'Updated by ${_user.name} at ${DateTime.now()}');
      if (!mounted) return;
      setState(() => _result = 'ALLOWED: record saved.');
    } on AccessDeniedException catch (e) {
      if (!mounted) return;
      setState(() => _result = 'DENIED: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final log = _service.accessLog.reversed.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Patient data access demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Signed in as'),
          DropdownButton<AppUser>(
            isExpanded: true,
            value: _user,
            items: [
              for (final u in _users)
                DropdownMenuItem(value: u, child: Text(u.name)),
            ],
            onChanged: (u) => setState(() => _user = u ?? _user),
          ),
          const SizedBox(height: 8),
          const Text('Patient record to open'),
          DropdownButton<String>(
            isExpanded: true,
            value: _patientId,
            items: [
              for (final id in _patientIds)
                DropdownMenuItem(value: id, child: Text(id)),
            ],
            onChanged: (id) => setState(() => _patientId = id ?? _patientId),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: _view,
                  child: const Text('View record'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: _save,
                  child: const Text('Edit record'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(_result),
          const Divider(height: 32),
          const Text('Screen gated by AuthorizedOnly'),
          const SizedBox(height: 8),
          AuthorizedOnly(
            user: _user,
            patientId: _patientId,
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Patient details are visible to you.'),
              ),
            ),
          ),
          const Divider(height: 32),
          const Text('Access log (who tried what, never the data)'),
          const SizedBox(height: 8),
          if (log.isEmpty) const Text('No access attempts yet.'),
          for (final e in log)
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                e.allowed ? Icons.check_circle_outline : Icons.block,
              ),
              title: Text(
                '${e.userId} tried to ${e.action.name} ${e.patientId}',
              ),
              subtitle: Text(e.allowed ? 'allowed' : 'denied'),
            ),
        ],
      ),
    );
  }
}