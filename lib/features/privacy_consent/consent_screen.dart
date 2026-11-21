import 'package:flutter/material.dart';

import 'consent_repository.dart';
import 'privacy_policy_content.dart';
import 'privacy_policy_screen.dart';

/// Asks for informed consent BEFORE any personal information is collected.
///
/// Informed consent flow:
///  1. The user sees a plain-language summary.
///  2. The user can open the full privacy policy.
///  3. The consent checkbox stays disabled until the policy has been opened.
///  4. The checkbox starts unticked (no pre-ticked consent).
///  5. "I Agree" is only enabled when the box is ticked; "Decline" is always
///     available and nothing is stored when declined.
class ConsentScreen extends StatefulWidget {
  final ConsentRepository repository;

  /// Called after consent has been saved. Navigate to your next screen here.
  final VoidCallback onConsentGiven;

  /// Called when the user declines. If null, a short message is shown.
  final VoidCallback? onDeclined;

  const ConsentScreen({
    super.key,
    required this.repository,
    required this.onConsentGiven,
    this.onDeclined,
  });

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  bool _policyViewed = false;
  bool _agreed = false;
  bool _saving = false;

  Future<void> _openPolicy() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const PrivacyPolicyScreen()),
    );
    if (!mounted) return;
    setState(() => _policyViewed = true);
  }

  Future<void> _agree() async {
    setState(() => _saving = true);
    await widget.repository.saveConsent(
      ConsentRecord(
        policyVersion: kPolicyVersion,
        acceptedAt: DateTime.now(),
      ),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    widget.onConsentGiven();
  }

  void _decline() {
    if (widget.onDeclined != null) {
      widget.onDeclined!();
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'No personal information has been collected. '
              'You need to agree to use Aarogya.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & Consent')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text('Before we collect your information',
                      style: textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(
                    'Please read how Aarogya uses your personal information.',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  for (final point in kConsentHighlights)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2, right: 8),
                            child: Icon(Icons.check_circle_outline, size: 18),
                          ),
                          Expanded(
                              child: Text(point, style: textTheme.bodyMedium)),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _openPolicy,
                    icon: const Icon(Icons.description_outlined),
                    label: const Text('Read the full Privacy Policy'),
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _agreed,
                    onChanged: _policyViewed
                        ? (value) => setState(() => _agreed = value ?? false)
                        : null,
                    title: const Text(
                      'I have read and understood the Privacy Policy and '
                          'I consent to Aarogya collecting and using my '
                          'personal information as described.',
                    ),
                    subtitle: _policyViewed
                        ? null
                        : const Text('Open the full policy above to continue.'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _saving ? null : _decline,
                      child: const Text('Decline'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: (_agreed && !_saving) ? _agree : null,
                      child: const Text('I Agree'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}