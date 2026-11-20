
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecoveryCodeScreen extends StatefulWidget {
  const RecoveryCodeScreen({super.key});

  @override
  State<RecoveryCodeScreen> createState() => _RecoveryCodeScreenState();
}

class _RecoveryCodeScreenState extends State<RecoveryCodeScreen> {
  final Color teal = const Color(0xFF30B8AD);
  final Color navy = const Color(0xFF141B2D);
  final Color grey = const Color(0xFF687B98);

  // Stores the six OTP digits.
  final List<TextEditingController> controllers =
  List.generate(6, (index) => TextEditingController());

  // Controls which OTP box is selected.
  final List<FocusNode> focusNodes =
  List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }

    for (var node in focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  void verifyCode() {
    String code = '';

    for (var controller in controllers) {
      code += controller.text;
    }

    if (code.length == 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Code submitted successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter all 6 digits'),
        ),
      );
    }
  }

  // Creates one OTP input box.
  Widget otpBox(int index) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: index == 5 ? 0 : 8),
        child: SizedBox(
          height: 59,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              counterText: '',
              hintText: '-',
              hintStyle: const TextStyle(fontSize: 24),
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: teal, width: 2),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).requestFocus(
                  focusNodes[index + 1],
                );
              }

              if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(
                  focusNodes[index - 1],
                );
              }

              if (value.isNotEmpty && index == 5) {
                FocusScope.of(context).unfocus();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: keyboardOpen
                ? 650
                : MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Spacer(flex: 3),

                  Image.asset(
                    'assets/images/recovery_lock.png',
                    width: 140,
                    height: 148,
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'Recovery Code',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: navy,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Enter the 6-digit recovery code sent to your selected email or phone.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: grey,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    children: List.generate(
                      6,
                          (index) => otpBox(index),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 5,
                    children: [
                      Text(
                        "Didn't receive the code?",
                        style: TextStyle(
                          fontSize: 14,
                          color: grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Resend Code clicked'),
                            ),
                          );
                        },
                        child: Text(
                          'Resend Code',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: teal,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 53,
                    child: ElevatedButton(
                      onPressed: verifyCode,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: teal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                      child: const Text(
                        'Verify Code',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(flex: 4),

                  Container(
                    width: 28,
                    height: 3,
                    color: const Color(0xFF2196E8),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Your account security is important to us.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: grey,
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
