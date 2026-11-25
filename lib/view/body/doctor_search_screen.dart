
import 'package:flutter/material.dart';

class FindDoctorPage extends StatefulWidget {
  const FindDoctorPage({super.key});

  @override
  State<FindDoctorPage> createState() => _FindDoctorPageState();
}

class _FindDoctorPageState extends State<FindDoctorPage> {
  static const Color background = Color(0xFFF5F7F9);
  static const Color blue = Color(0xFF2196D5);
  static const Color teal = Color(0xFF2DB7AB);
  static const Color dark = Color(0xFF141D30);
  static const Color grey = Color(0xFF687C98);
  static const Color border = Color(0xFFDCE4EE);

  String selectedSpecialty = 'All';
  String searchQuery = '';
  String selectedSort = 'Recommended';

  int selectedIndex = 0;

  final List<Map<String, dynamic>> specialties = [
    {'name': 'All', 'icon': Icons.grid_view_rounded},
    {'name': 'Cardiology', 'icon': Icons.favorite_border},
    {'name': 'Dermatology', 'icon': Icons.face_retouching_natural},
    {'name': 'Neurology', 'icon': Icons.psychology_outlined},
    {'name': 'General', 'icon': Icons.medical_services_outlined},
    {'name': 'Pediatrics', 'icon': Icons.child_care},
    {'name': 'Orthopedics', 'icon': Icons.accessibility_new},
  ];

  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Sandeep Kunwar',
      'specialty': 'Cardiologist',
      'category': 'Cardiology',
      'hospital': 'HAMS Hospital, Dhumbarahi',
      'rating': 4.9,
      'reviews': 128,
      'availability': 'Today · 10:30 AM',
      'fee': 1200,
      'price': '1,200',
    },
    {
      'name': 'Dr. Anisha Shrestha',
      'specialty': 'Dermatologist',
      'category': 'Dermatology',
      'hospital': 'Norvic Hospital, Thapathali',
      'rating': 4.8,
      'reviews': 96,
      'availability': 'Today · 2:00 PM',
      'fee': 1000,
      'price': '1,000',
    },
    {
      'name': 'Dr. Prakash Sharma',
      'specialty': 'General Physician',
      'category': 'General',
      'hospital': 'Grande Hospital, Dhapasi',
      'rating': 4.9,
      'reviews': 154,
      'availability': 'Tomorrow · 9:00 AM',
      'fee': 800,
      'price': '800',
    },
  ];

  List<Map<String, dynamic>> get filteredDoctors {
    final query = searchQuery.trim().toLowerCase();

    final result = doctors.where((doctor) {
      final matchesSpecialty =
          selectedSpecialty == 'All' ||
              doctor['category'] == selectedSpecialty;

      final matchesSearch =
          doctor['name'].toString().toLowerCase().contains(query) ||
              doctor['specialty'].toString().toLowerCase().contains(query) ||
              doctor['category'].toString().toLowerCase().contains(query) ||
              doctor['hospital'].toString().toLowerCase().contains(query);

      return matchesSpecialty && matchesSearch;
    }).toList();

    if (selectedSort == 'Highest Rated') {
      result.sort(
            (a, b) => (b['rating'] as double)
            .compareTo(a['rating'] as double),
      );
    } else if (selectedSort == 'Lowest Price') {
      result.sort(
            (a, b) => (a['fee'] as int)
            .compareTo(b['fee'] as int),
      );
    } else if (selectedSort == 'Highest Price') {
      result.sort(
            (a, b) => (b['fee'] as int)
            .compareTo(a['fee'] as int),
      );
    }

    return result;
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

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: dark,
        behavior: SnackBarBehavior.floating,
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
        return const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: dark,
                  ),
                ),
                SizedBox(height: 24),
                Icon(
                  Icons.notifications_none_rounded,
                  size: 48,
                  color: grey,
                ),
                SizedBox(height: 12),
                Text(
                  'No new notifications',
                  style: TextStyle(
                    color: grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void showFilters() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter Doctors',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: dark,
                  ),
                ),
                const SizedBox(height: 16),
                ...[
                  'Recommended',
                  'Highest Rated',
                  'Lowest Price',
                  'Highest Price',
                ].map(
                      (option) => ListTile(
                    title: Text(option),
                    trailing: selectedSort == option
                        ? const Icon(
                      Icons.check_circle,
                      color: blue,
                    )
                        : null,
                    onTap: () {
                      setState(() {
                        selectedSort = option;
                      });
                      Navigator.pop(sheetContext);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: dark,
            size: 26,
          ),
        ),
        const Expanded(
          child: Text(
            'Find a Doctor',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: dark,
            ),
          ),
        ),
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
                color: grey,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            style: const TextStyle(
              fontSize: 15,
              color: dark,
            ),
            decoration: InputDecoration(
              hintText: 'Search doctors or specialties',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: grey,
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
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: blue),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Material(
          color: const Color(0xFFEDF4FD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: blue),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: showFilters,
            child: const SizedBox(
              width: 52,
              height: 52,
              child: Icon(
                Icons.tune_rounded,
                color: blue,
                size: 26,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLocation() {
    return InkWell(
      onTap: () {},
      child: const Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            color: teal,
            size: 22,
          ),
          SizedBox(width: 6),
          Text(
            'Kathmandu, Nepal',
            style: TextStyle(
              color: grey,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.keyboard_arrow_down,
            color: grey,
          ),
        ],
      ),
    );
  }

  Widget buildSpecialties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Specialties',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: dark,
              ),
            ),
            Spacer(),
            Text(
              'Swipe to explore',
              style: TextStyle(
                color: grey,
                fontSize: 12,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.arrow_forward_rounded,
              color: grey,
              size: 17,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 74,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: specialties.length,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              final specialty = specialties[index];

              final bool isSelected =
                  selectedSpecialty == specialty['name'];

              return Material(
                color: isSelected ? blue : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: isSelected ? blue : border,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedSpecialty = specialty['name'];
                    });
                  },
                  child: SizedBox(
                    width: specialty['name'] == 'All'
                        ? 76
                        : 116,
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Icon(
                          specialty['icon'] as IconData,
                          color: isSelected
                              ? Colors.white
                              : blue,
                          size: 26,
                        ),
                        const SizedBox(height: 7),
                        Text(
                          specialty['name'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildDoctorsHeading() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Available Doctors',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: dark,
            ),
          ),
        ),
        PopupMenuButton<String>(
          color: Colors.white,
          onSelected: (value) {
            setState(() {
              selectedSort = value;
            });
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'Recommended',
              child: Text('Recommended'),
            ),
            PopupMenuItem(
              value: 'Highest Rated',
              child: Text('Highest Rated'),
            ),
            PopupMenuItem(
              value: 'Lowest Price',
              child: Text('Lowest Price'),
            ),
            PopupMenuItem(
              value: 'Highest Price',
              child: Text('Highest Price'),
            ),
          ],
          child: Row(
            children: [
              Text(
                selectedSort,
                style: const TextStyle(
                  color: blue,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 3),
              const Icon(
                Icons.keyboard_arrow_down,
                color: blue,
                size: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDoctorCard(Map<String, dynamic> doctor) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 65,
                height: 70,
                child: Center(
                  child: Image.asset(
                    'assets/images/profile.png',
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.account_circle_outlined,
                        size: 48,
                        color: dark,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: dark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor['specialty'],
                      style: const TextStyle(
                        fontSize: 15,
                        color: grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor['hospital'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFF5AB35),
                          size: 19,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${doctor['rating']}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: dark,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            "(${doctor['reviews']} reviews)",
                            style: const TextStyle(
                              fontSize: 13,
                              color: grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: teal,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            doctor['availability'],
                            style: const TextStyle(
                              color: Color(0xFF00877B),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "NPR ${doctor['price']}",
                            style: const TextStyle(
                              color: dark,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: ' / visit',
                            style: TextStyle(
                              color: grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      showMessage(
                        'Selected ${doctor['name']}',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Book Appointment',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
          if (index == 0) {
            Navigator.pop(context);
          } else {
            setState(() {
              selectedIndex = index;
            });
          }
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
    final availableDoctors = filteredDoctors;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16, 16, 16, 12,
              ),
              child: buildHeader(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16, 4, 16, 12,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    buildSearchBar(),
                    const SizedBox(height: 16),
                    buildLocation(),
                    const SizedBox(height: 10),
                    buildSpecialties(),
                    const SizedBox(height: 12),
                    buildDoctorsHeading(),
                    const SizedBox(height: 14),
                    if (availableDoctors.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 50,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                size: 48,
                                color: grey,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'No doctors found',
                                style: TextStyle(
                                  color: dark,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Try another name or specialty.',
                                style: TextStyle(
                                  color: grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ...availableDoctors.map(
                            (doctor) => buildDoctorCard(doctor),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }
}
