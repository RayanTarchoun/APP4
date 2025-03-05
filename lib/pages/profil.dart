import 'package:flutter/material.dart';
import 'package:myapp/pages/password.dart';
import 'package:myapp/pages/reservation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Dummy data for reservations - replace with actual data source
  final List<Map<String, String>> _reservations = [
    {'date': '2024-01-15', 'time': '14:30', 'purpose': 'Team Meeting'},
    {'date': '2024-01-20', 'time': '10:00', 'purpose': 'Client Presentation'}
  ];

  // Dummy user data - replace with actual user data
  final String _userName = "John Doe";
  String? _profileImagePath;

  void _deleteReservation(int index) {
    setState(() {
      _reservations.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reservation deleted'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _changePassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PasswordChangePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFF201c24),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF201c24),
              Color(0xFFa83c34),
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO: Implement image picker
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Image picker to be implemented'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: _profileImagePath != null
                            ? AssetImage(_profileImagePath!) as ImageProvider
                            : null,
                        child: _profileImagePath == null
                            ? const Icon(Icons.person,
                                size: 60, color: Colors.grey)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Hi, $_userName',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _changePassword,
                    icon: const Icon(Icons.lock_outline, color: Colors.white),
                    label: const Text('Change Password'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFa83c34),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                children: const [
                  Icon(Icons.calendar_today, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'My Reservations',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _reservations.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.event_busy,
                              size: 64, color: Colors.white70),
                          SizedBox(height: 16),
                          Text(
                            'No reservations found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _reservations.length,
                      itemBuilder: (context, index) {
                        final reservation = _reservations[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          color: Colors.white.withOpacity(0.9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xFFa83c34),
                              child: Icon(Icons.event, color: Colors.white),
                            ),
                            title: Text(
                              '${reservation['date']} at ${reservation['time']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              reservation['purpose'] ?? '',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  color: Color(0xFFa83c34)),
                              onPressed: () => _deleteReservation(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Reservation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 2,
        backgroundColor: const Color(0xFF201c24),
        selectedItemColor: const Color(0xFFa83c34),
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReservationPage()),
            );
          } else if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
