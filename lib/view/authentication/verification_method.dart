import 'package:flutter/material.dart';
import 'otp_page.dart';

class VerificationMethodPage extends StatefulWidget {
  const VerificationMethodPage({super.key});

  @override
  State<VerificationMethodPage> createState() => _VerificationMethodPageState();
}

class _VerificationMethodPageState extends State<VerificationMethodPage> {
  // ---- Colours (replace with exact Figma hex codes if different) ----
  static const Color primaryBlue = Color(0xFF2D8FDD);
  static const Color turquoise = Color(0xFF2FB9A8);
  static const Color iconBoxBackground = Color(0xFFE8F7F4);
  static const Color titleColor = Color(0xFF0F1A2B);
  static const Color subtitleColor = Color(0xFF6B7A90);
  static const Color borderColor = Color(0xFFE2E6EC);

  // Which option the user picked: 'email', 'phone', or null (nothing yet)
  String? _selectedMethod;

  void _onSendCodePressed() {
    if (_selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose a verification method')),
      );
      return;
    }

    // Go to the OTP page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OtpPage()),
    );
  }

  // One selectable card (used for both Email and Phone Number)
  Widget _buildOptionCard({
    required String label,
    required IconData icon,
    required String value,
  }) {
    final bool isSelected = _selectedMethod == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedMethod = value;
          });
        },
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? iconBoxBackground : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? turquoise : borderColor,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, size: 20, color: subtitleColor),
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    size: 22,
                    color: isSelected ? turquoise : const Color(0xFFC5CCD6),
                  ),
                ],
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Main content (scrolls if the screen is small)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 90),

                    // Shield icon in a light box
                    Container(
                      width: 120,
                      height: 110,
                      decoration: BoxDecoration(
                        color: iconBoxBackground,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.verified_user_outlined,
                        size: 60,
                        color: primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    const Text(
                      'Verify Your Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    const Text(
                      "Choose how you'd like to receive your verification code.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: subtitleColor,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Small heading, aligned left
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Choose Verification Method',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Email and Phone cards side by side
                    Row(
                      children: [
                        _buildOptionCard(
                          label: 'Email',
                          icon: Icons.mail_outline,
                          value: 'email',
                        ),
                        const SizedBox(width: 12),
                        _buildOptionCard(
                          label: 'Phone Number',
                          icon: Icons.smartphone_outlined,
                          value: 'phone',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Send Verification Code button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _onSendCodePressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: turquoise,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Send Verification Code',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer (always at the bottom)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Container(width: 20, height: 2, color: primaryBlue),
                  const SizedBox(height: 8),
                  const Text(
                    'Your account security is important to us.',
                    style: TextStyle(fontSize: 11, color: subtitleColor),
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