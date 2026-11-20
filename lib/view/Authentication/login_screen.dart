import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool hidePassword = true;

  // Demo credentials (remove when backend exists)
  String demoId = 'doctor@aarogya.com';
  String demoPassword = 'Aarogya@123';

  Color teal = const Color(0xFF2EB8AB);
  Color tealLight = const Color(0xFFBFEBE8);

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  void login() {
    if (emailController.text.trim() == demoId &&
        passController.text == demoPassword) {
      showMessage('Login successful');
    } else {
      showMessage('Incorrect email/phone or password');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Illustration
            Image.asset('lib/assets/image/loginpage.png', height: 260),
            const SizedBox(height: 10),

            const Text(
              'Login',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Email / phone
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'email/phone number',
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(width: 3, color: tealLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(width: 3, color: teal),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Password
            TextFormField(
              controller: passController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                hintText: 'password',
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(width: 3, color: tealLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(width: 3, color: teal),
                ),
              ),
            ),

            // Forgot password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => showMessage('Password recovery coming soon'),
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: teal),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Login button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text('New to Aarogya app?', style: TextStyle(fontSize: 18)),
            TextButton(
              onPressed: () => showMessage('Sign up coming soon'),
              child: const Text(
                'Sign up Now',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            ),

            const Text(
              'or Continue with',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/assets/image/googlelogo.png', height: 60),
                const SizedBox(width: 8),
                Image.asset('lib/assets/image/facebooklogo.png', height: 60),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}