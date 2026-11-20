
import 'package:flutter/material.dart';
import 'registration_screen.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() =>
      _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  String selectedRole = '';

  final Color teal = const Color(0xFF30B8AD);
  final Color navy = const Color(0xFF141B2D);
  final Color grey = const Color(0xFF687B98);

  Widget roleCard(
      String role,
      String description,
      IconData icon,
      ) {
    bool selected = selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFEAF9F6)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? teal
                : const Color(0xFFDCE5EF),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFDDF4F0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: teal,
                size: 27,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "I'm a $role",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: navy,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: grey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? teal : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void continueToRegister() {
    if (selectedRole.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select Patient or Doctor'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(
          selectedRole: selectedRole,
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
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),

              const SizedBox(height: 65),

              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF9F6),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.people_outline,
                  color: teal,
                  size: 55,
                ),
              ),

              const SizedBox(height: 25),

              Text(
                'Join Aarogya',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'How would you like to use Aarogya?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: grey,
                ),
              ),

              const SizedBox(height: 38),

              roleCard(
                'Patient',
                'Find doctors, book appointments, and manage your health.',
                Icons.person_outline,
              ),

              const SizedBox(height: 16),

              roleCard(
                'Doctor',
                'Manage appointments and connect with patients.',
                Icons.medical_services_outlined,
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 53,
                child: ElevatedButton(
                  onPressed: continueToRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shield_outlined,
                    color: teal,
                    size: 18,
                  ),
                  const SizedBox(width: 7),
                  Flexible(
                    child: Text(
                      'Your information is safe with Aarogya.',
                      style: TextStyle(
                        fontSize: 12,
                        color: grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}