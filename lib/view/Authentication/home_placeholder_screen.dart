import 'package:flutter/material.dart';

import 'login_screen.dart';

/// Temporary screen shown after a successful login so you can test logout.
/// Replace with the real dashboard later.
class HomePlaceholderPage extends StatelessWidget {
  const HomePlaceholderPage({super.key});

  static const Color _teal = Color(0xFF2EB8AB);

  Future<void> _confirmLogout(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('You will need to log in again to access Aarogya.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Log out', style: TextStyle(color: _teal)),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      // Clears the whole navigation stack so Back can't return to this screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aarogya'),
        backgroundColor: _teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
            onPressed: () => _confirmLogout(context),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Logged in successfully',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}