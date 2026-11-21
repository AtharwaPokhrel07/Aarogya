import 'package:flutter/material.dart';

import 'privacy_policy_content.dart';

/// Full privacy policy. Needs no login or personal data, so it can be
/// opened before anything is collected.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Aarogya Privacy Policy', style: textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(
              'Version $kPolicyVersion · Last updated $kPolicyLastUpdated',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            for (final section in kPrivacyPolicySections) ...[
              Text(section.title, style: textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(section.body, style: textTheme.bodyMedium),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}