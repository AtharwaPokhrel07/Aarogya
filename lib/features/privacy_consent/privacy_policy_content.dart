/// Privacy policy text for Aarogya.
///
/// DRAFT: placeholder wording for the assignment. Replace with the
/// team-approved policy before any real release. Bump [kPolicyVersion]
/// whenever the text changes so consent can be re-requested.
library;

const String kPolicyVersion = '1.0';
const String kPolicyLastUpdated = 'November 2026';

class PolicySection {
  final String title;
  final String body;
  const PolicySection(this.title, this.body);
}

/// Short plain-language summary shown on the consent screen.
const List<String> kConsentHighlights = [
  'We collect your name, contact details, date of birth and health-related '
      'information you enter (for example appointment reasons).',
  'We use it to book appointments, process payments and connect you with '
      'hospitals and doctors.',
  'We only share it with the hospitals and payment providers needed to '
      'complete your request.',
  'You can review this policy at any time and withdraw consent later.',
];

const List<PolicySection> kPrivacyPolicySections = [
  PolicySection(
    '1. Who we are',
    'Aarogya is a healthcare app that helps patients book appointments, '
        'pay for services and find hospitals. This policy explains how your '
        'personal information is handled while you use the app.',
  ),
  PolicySection(
    '2. Information we collect',
    'Account details (name, email, phone number, date of birth), health '
        'information you provide (appointment reasons, relevant history), '
        'payment details processed by our payment partner, and basic usage '
        'data such as device type and app version.',
  ),
  PolicySection(
    '3. How we use your information',
    'To create and manage your account, schedule and manage appointments, '
        'process payments, send reminders and notifications, and improve '
        'the app. We do not sell your personal information.',
  ),
  PolicySection(
    '4. Who we share it with',
    'Hospitals and doctors you choose to book with, and payment providers '
        'needed to complete transactions. Sharing is limited to what is '
        'necessary for the service you requested.',
  ),
  PolicySection(
    '5. How long we keep it',
    'We keep your information while your account is active and for as long '
        'as required by law. You may ask us to delete your account and data.',
  ),
  PolicySection(
    '6. Your rights',
    'You can access, correct or delete your information, and you can '
        'withdraw your consent at any time. Withdrawing consent may limit '
        'the features available to you.',
  ),
  PolicySection(
    '7. Security',
    'We use reasonable technical and organisational measures to protect '
        'your information. No system is completely secure, so we cannot '
        'guarantee absolute security.',
  ),
  PolicySection(
    '8. Contact us',
    'Questions about this policy? Contact the Aarogya team at '
        'privacy@aarogya.example (placeholder address).',
  ),
];