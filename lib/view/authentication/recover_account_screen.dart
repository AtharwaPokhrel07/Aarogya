
import 'package:flutter/material.dart';
import 'recovery_code_screen.dart';

class RecoverAccountScreen extends StatefulWidget {
  const RecoverAccountScreen({super.key});

  @override
  State<RecoverAccountScreen> createState() =>
      _RecoverAccountScreenState();
}

class _RecoverAccountScreenState
    extends State<RecoverAccountScreen> {
  String selectedMethod = '';

  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final Color teal = const Color(0xFF30B8AD);
  final Color navy = const Color(0xFF141B2D);
  final Color grey = const Color(0xFF687B98);

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Widget methodBox(String title, IconData icon) {
    bool selected = selectedMethod == title;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedMethod = title;
          });
        },
        child: Container(
          height: 95,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFEAF9F6)
                : Colors.white,
            border: Border.all(
              color: selected
                  ? teal
                  : const Color(0xFFDCE5EF),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    color: selected ? teal : Colors.grey,
                  ),
                  Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: selected
                        ? teal
                        : Colors.blueGrey,
                  ),
                ],
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: selected ? navy : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendCode() {
    if (selectedMethod.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select Email or Phone Number',
          ),
        ),
      );
      return;
    }

    if (selectedMethod == 'Email') {
      String email = emailController.text.trim();

      if (!RegExp(
        r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
      ).hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please enter a valid email address',
            ),
          ),
        );
        return;
      }
    }

    if (selectedMethod == 'Phone Number') {
      String phone = phoneController.text.trim();

      if (!RegExp(r'^\d{10}$').hasMatch(phone)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please enter a valid 10-digit phone number',
            ),
          ),
        );
        return;
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RecoveryCodeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.12,
                      ),

                      Image.asset(
                        'assets/images/recovery_lock.png',
                        width: 140,
                        height: 148,
                      ),

                      const SizedBox(height: 16),

                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Recover Your Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: navy,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Choose where you'd like to receive your Recovery code.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: grey,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 28),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Choose Verification Method',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: navy,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          methodBox(
                            'Email',
                            Icons.mail_outline,
                          ),
                          const SizedBox(width: 12),
                          methodBox(
                            'Phone Number',
                            Icons.phone_android,
                          ),
                        ],
                      ),

                      if (selectedMethod.isNotEmpty) ...[
                        const SizedBox(height: 22),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            selectedMethod == 'Email'
                                ? 'Email Address'
                                : 'Phone Number',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: navy,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        TextField(
                          controller: selectedMethod == 'Email'
                              ? emailController
                              : phoneController,
                          keyboardType: selectedMethod == 'Email'
                              ? TextInputType.emailAddress
                              : TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: selectedMethod == 'Email'
                                ? 'Enter your email address'
                                : 'Enter your phone number',
                            prefixIcon: Icon(
                              selectedMethod == 'Email'
                                  ? Icons.mail_outline
                                  : Icons.phone_android,
                              color: grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFFDCE5EF),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: teal,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 53,
                        child: ElevatedButton(
                          onPressed: sendCode,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: teal,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(11),
                            ),
                          ),
                          child: const FittedBox(
                            child: Text(
                              'Send Verification Code',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: constraints.maxHeight * 0.10,
                      ),

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
            );
          },
        ),
      ),
    );
  }
}
