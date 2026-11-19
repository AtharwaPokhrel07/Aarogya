import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountVerificationPage extends StatefulWidget {
  const AccountVerificationPage({super.key});

  @override
  State<AccountVerificationPage> createState() =>
      _AccountVerificationPageState();
}

class _AccountVerificationPageState extends State<AccountVerificationPage> {
  // Theme colours
  final Color primaryBlue = const Color(0xFF2455A4);
  final Color secondaryTurquoise = const Color(0xFF27B7B5);

  String selectedMethod = 'Email';

  int countdown = 30;
  Timer? timer;

  final List<TextEditingController> otpControllers =
  List.generate(6, (index) => TextEditingController());

  final List<FocusNode> focusNodes =
  List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    timer?.cancel();

    setState(() {
      countdown = 30;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void resendCode() {
    for (var controller in otpControllers) {
      controller.clear();
    }

    startCountdown();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('A new verification code was requested.')),
    );
  }

  void verifyAccount() {
    String otp = otpControllers.map((e) => e.text).join();

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all 6 digits.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP entered! Backend verification is not connected yet.'),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();

    for (var controller in otpControllers) {
      controller.dispose();
    }

    for (var node in focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  Widget buildOtpBox(int index) {
    return SizedBox(
      width: 43,
      height: 52,
      child: TextField(
        controller: otpControllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(color: Color(0xFFD6DCE5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
              color: Color(0xFF2455A4),
              width: 2,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  Widget buildVerificationOption(String method, IconData icon) {
    bool isSelected = selectedMethod == method;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedMethod = method;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFF0F5FC)
                : Colors.white,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: isSelected
                  ? primaryBlue
                  : const Color(0xFFD6DCE5),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 19,
                color: isSelected ? primaryBlue : Colors.grey,
              ),
              const SizedBox(width: 7),
              Text(
                method,
                style: TextStyle(
                  color: isSelected ? primaryBlue : Colors.grey[700],
                  fontWeight:
                  isSelected ? FontWeight.w600 : FontWeight.normal,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 28),

              // Aarogya logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    color: primaryBlue,
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Aarogya',
                    style: TextStyle(
                      color: primaryBlue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 55),

              // Verification icon
              Container(
                height: 85,
                width: 85,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2FC),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  Icons.verified_user_outlined,
                  size: 49,
                  color: primaryBlue,
                ),
              ),

              const SizedBox(height: 25),

              // Heading
              Text(
                'Verify Your Account',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'We have sent a verification code to your registered\n'
                    'email address or phone number.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF777777),
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 32),

              // Verification method
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose Verification Method',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF26374D),
                  ),
                ),
              ),

              const SizedBox(height: 13),

              Row(
                children: [
                  buildVerificationOption(
                    'Email',
                    Icons.email_outlined,
                  ),
                  const SizedBox(width: 12),
                  buildVerificationOption(
                    'Phone',
                    Icons.phone_outlined,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // OTP heading
              const Text(
                'Enter Verification Code',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF26374D),
                ),
              ),

              const SizedBox(height: 17),

              // OTP boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return buildOtpBox(index);
                }),
              ),

              const SizedBox(height: 25),

              // Resend code
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: countdown == 0 ? resendCode : null,
                    child: Text(
                      countdown == 0
                          ? 'Resend Code'
                          : 'Resend in ${countdown}s',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: countdown == 0
                            ? primaryBlue
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              // Verify button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: verifyAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryTurquoise,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Verify Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Change contact details
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Contact details editing will be added later.'),
                    ),
                  );
                },
                child: Text(
                  'Change Email or Phone Number',
                  style: TextStyle(
                    color: primaryBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Footer
              const Icon(
                Icons.lock_outline,
                color: Color(0xFF8795A8),
                size: 20,
              ),

              const SizedBox(height: 8),

              const Text(
                'Your account security is important to us.',
                style: TextStyle(
                  color: Color(0xFF8795A8),
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}