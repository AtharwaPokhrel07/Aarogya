
import 'package:flutter/material.dart';
import 'doctor_search_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color background = Color(0xFFF5F7F9);
  static const Color blue = Color(0xFF2196E5);
  static const Color teal = Color(0xFF2DB7AB);
  static const Color dark = Color(0xFF141D30);
  static const Color grey = Color(0xFF687C98);
  static const Color border = Color(0xFFDCE4EE);
  static const Color lightBlue = Color(0xFFEDF4FD);
  static const Color lightTeal = Color(0xFFEAFBF7);

  int selectedIndex = 0;

  void openFindDoctor() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FindDoctorPage(),
      ),
    );
  }

  void showNotifications() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: border,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: dark,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: cardDecoration(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: lightBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.calendar_today_outlined,
                          color: blue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Appointment Reminder',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: dark,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'You have an upcoming appointment with Dr. Sandeep Kunwar at 10:30 AM.',
                              style: TextStyle(
                                fontSize: 13,
                                color: grey,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Sample notification',
                              style: TextStyle(
                                fontSize: 12,
                                color: teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  BoxDecoration cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: border),
      boxShadow: const [
        BoxShadow(
          color: Color(0x08000000),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 45,
          height: 45,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox(
              width: 45,
              height: 45,
              child: Icon(
                Icons.health_and_safety_outlined,
                color: teal,
                size: 35,
              ),
            );
          },
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Image.asset(
            'assets/images/aarogya.png',
            height: 28,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Text(
                'Aarogya',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: blue,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Material(
          color: Colors.white,
          shape: const CircleBorder(
            side: BorderSide(color: border),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: showNotifications,
            customBorder: const CircleBorder(),
            child: const SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                Icons.notifications_none_rounded,
                color: Color(0xFF43536A),
                size: 24,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Material(
          color: Colors.white,
          shape: const CircleBorder(
            side: BorderSide(color: border),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {},
            customBorder: const CircleBorder(),
            splashColor: teal.withAlpha(40),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.person_outline,
                      size: 24,
                      color: Color(0xFF43536A),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGreeting() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, User',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: dark,
          ),
        ),
        SizedBox(height: 3),
        Text(
          'How are you feeling today?',
          style: TextStyle(
            fontSize: 17,
            color: grey,
          ),
        ),
      ],
    );
  }

  Widget buildSearchBar() {
    return TextField(
      readOnly: true,
      showCursor: false,
      onTap: openFindDoctor,
      style: const TextStyle(
        fontSize: 16,
        color: dark,
      ),
      decoration: InputDecoration(
        hintText: 'Search doctors, hospitals...',
        hintStyle: const TextStyle(
          color: grey,
          fontSize: 16,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Color(0xFF94A5BD),
          size: 25,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 17,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: blue),
        ),
      ),
    );
  }

  Widget buildQuickAction({
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color iconBackground,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 120,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 12,
          ),
          decoration: cardDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: dark,
                  fontSize: 13,
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuickActions() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildQuickAction(
            icon: Icons.calendar_today_outlined,
            title: 'Book\nAppointment',
            iconColor: blue,
            iconBackground: lightBlue,
            onTap: openFindDoctor,
          ),
          const SizedBox(width: 12),
          buildQuickAction(
            icon: Icons.description_outlined,
            title: 'Medical\nRecords',
            iconColor: teal,
            iconBackground: lightTeal,
            onTap: () {},
          ),
          const SizedBox(width: 12),
          buildQuickAction(
            icon: Icons.location_on_outlined,
            title: 'Find Hospitals',
            iconColor: blue,
            iconBackground: lightBlue,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget buildAppointmentCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Upcoming Appointment',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: dark,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: lightTeal,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Text(
                  'Tomorrow',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF00877B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 23),
          Row(
            children: [
              Image.asset(
                'assets/images/profile.png',
                width: 65,
                height: 65,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.account_circle_outlined,
                    size: 65,
                    color: grey,
                  );
                },
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Sandeep Kunwar',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: dark,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Cardiologist',
                      style: TextStyle(
                        fontSize: 15,
                        color: grey,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'HAMS Hospital',
                      style: TextStyle(
                        fontSize: 14,
                        color: grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(
            color: border,
            thickness: 1,
          ),
          const SizedBox(height: 3),
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        color: grey,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Oct 30, 2026',
                      style: TextStyle(
                        color: dark,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Time',
                      style: TextStyle(
                        color: grey,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '10:30 AM',
                      style: TextStyle(
                        color: dark,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: teal,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: const Text(
                'View Details',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHealthService({
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color iconBackground,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 108,
          ),
          padding: const EdgeInsets.all(16),
          decoration: cardDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 23,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                  color: dark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHealthServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Health Services',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: dark,
          ),
        ),
        const SizedBox(height: 13),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHealthService(
                icon: Icons.medication_outlined,
                title: 'My Prescriptions',
                iconColor: blue,
                iconBackground: lightBlue,
              ),
              const SizedBox(width: 13),
              buildHealthService(
                icon: Icons.monitor_heart_outlined,
                title: 'Lab Reports',
                iconColor: teal,
                iconBackground: lightTeal,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBottomNavigation() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: border),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: blue,
        unselectedItemColor: const Color(0xFF94A5BD),
        selectedFontSize: 11,
        unselectedFontSize: 11,
        iconSize: 26,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            label: 'Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16, 22, 16, 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(),
              const SizedBox(height: 26),
              buildGreeting(),
              const SizedBox(height: 24),
              buildSearchBar(),
              const SizedBox(height: 24),
              buildQuickActions(),
              const SizedBox(height: 24),
              buildAppointmentCard(),
              const SizedBox(height: 24),
              buildHealthServices(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }
}
