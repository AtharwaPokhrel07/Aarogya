
import 'package:flutter/material.dart';
import 'verification_method.dart';

class RegisterPage extends StatefulWidget {
  final String selectedRole;

  const RegisterPage({
    super.key,
    required this.selectedRole,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  static const Color teal = Color(0xFF30B8AD);
  static const Color tealLight = Color(0xFFBFE9E7);

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget buildInputField(
      String hint,
      TextEditingController controller, {
        bool obscureText = false,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return SizedBox(
      height: 49,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(23),
            borderSide: const BorderSide(
              color: tealLight,
              width: 3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(23),
            borderSide: const BorderSide(
              color: teal,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }

  void goToVerificationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const VerificationMethodPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
            ),
            child: Column(
              children: [
                const SizedBox(height: 35),

                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Image.asset(
                  'assets/images/register_illustration.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 53),

                const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      child: buildInputField(
                        'First name',
                        firstNameController,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Expanded(
                      child: buildInputField(
                        'Last name',
                        lastNameController,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 9),

                buildInputField(
                  'Email',
                  emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 9),

                buildInputField(
                  'Phone Number',
                  phoneController,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 9),

                buildInputField(
                  'Create Password',
                  passwordController,
                  obscureText: true,
                ),

                const SizedBox(height: 9),

                buildInputField(
                  'Confirm Password',
                  confirmPasswordController,
                  obscureText: true,
                ),

                const SizedBox(height: 7),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: goToVerificationPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: teal,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'or sign up with',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/images/google.png',
                        height: 30,
                        width: 30,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(width: 20),

                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/images/facebook.png',
                        height: 30,
                        width: 30,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
