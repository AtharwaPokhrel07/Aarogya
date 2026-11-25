
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aarogya/view/body/home_screen.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  static const Color primaryBlue = Color(0xFF2D8FDD);
  static const Color turquoise = Color(0xFF2FB9A8);
  static const Color iconBoxBackground = Color(0xFFE8F7F4);
  static const Color titleColor = Color(0xFF0F1A2B);
  static const Color subtitleColor = Color(0xFF6B7A90);
  static const Color borderColor = Color(0xFFC5CCD6);

  static const int otpLength = 6;

  final List<TextEditingController> _controllers =
  List.generate(otpLength, (_) => TextEditingController());

  final List<FocusNode> _focusNodes =
  List.generate(otpLength, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }

    for (final f in _focusNodes) {
      f.dispose();
    }

    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _onResendPressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A new code has been sent'),
      ),
    );
  }

  void _onVerifyPressed() {
    final String code =
    _controllers.map((c) => c.text).join();

    if (code.length < otpLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the full 6-digit code'),
        ),
      );
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
          (route) => false,
    );
  }

  Widget _buildOtpBox(int index) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          right: index == otpLength - 1 ? 0 : 8,
        ),
        child: SizedBox(
          height: 48,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) =>
                _onOtpChanged(value, index),
            decoration: InputDecoration(
              counterText: '',
              hintText: '-',
              hintStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
              contentPadding: EdgeInsets.zero,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: turquoise,
                  width: 1.5,
                ),
              ),
            ),
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 90),

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

                    const Text(
                      'Enter Verification Code',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Enter the 6-digit verification code sent to your selected email or phone.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: subtitleColor,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 28),

                    Row(
                      children: List.generate(
                        otpLength,
                            (index) => _buildOtpBox(index),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive the code? ",
                          style: TextStyle(
                            fontSize: 13,
                            color: subtitleColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: _onResendPressed,
                          child: const Text(
                            'Resend Code',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: turquoise,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _onVerifyPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: turquoise,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Verify Code',
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

            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Container(
                    width: 20,
                    height: 2,
                    color: primaryBlue,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your account security is important to us.',
                    style: TextStyle(
                      fontSize: 11,
                      color: subtitleColor,
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
