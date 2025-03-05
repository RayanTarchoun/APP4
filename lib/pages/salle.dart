import 'package:flutter/material.dart';
import 'package:myapp/pages/reservation.dart';
import 'package:myapp/pages/profil.dart';

class SallePage extends StatelessWidget {
  const SallePage({super.key});

  final Color darkColor = const Color(0xFF201C24);
  final Color accentColor = const Color(0xFFA83C34);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Our Rooms', style: TextStyle(color: Colors.white)),
        backgroundColor: darkColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [darkColor, darkColor.withOpacity(0.9)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRoomCard(
                  'Yoga Room',
                  'A peaceful and serene space designed for yoga practice. Features include:',
                  [
                    'Yoga mats and props available',
                    'Mirror walls',
                    'Ambient lighting',
                    'Sound system for relaxing music',
                    'Capacity: 20 people'
                  ],
                  Icons.self_improvement,
                ),
                const SizedBox(height: 16),
                _buildRoomCard(
                  'Cardio Room',
                  'A dynamic space equipped for cardiovascular exercises. Features include:',
                  [
                    'Treadmills',
                    'Elliptical machines',
                    'Stationary bikes',
                    'Rowing machines',
                    'Heart rate monitoring stations',
                    'Capacity: 25 people'
                  ],
                  Icons.directions_run,
                ),
                const SizedBox(height: 16),
                _buildRoomCard(
                  'Fitness Room',
                  'A versatile space for various fitness activities. Features include:',
                  [
                    'Open floor space',
                    'Exercise balls',
                    'Resistance bands',
                    'Training mats',
                    'Basic workout equipment',
                    'Capacity: 30 people'
                  ],
                  Icons.fitness_center,
                ),
                const SizedBox(height: 16),
                _buildRoomCard(
                  'Musculation Room',
                  'A fully equipped weight training area. Features include:',
                  [
                    'Free weights section',
                    'Weight machines',
                    'Bench press stations',
                    'Squat racks',
                    'Cable machines',
                    'Capacity: 20 people'
                  ],
                  Icons.sports_gymnastics,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Reservation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        backgroundColor: darkColor,
        selectedItemColor: accentColor,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReservationPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
      ),
    );
  }

  Widget _buildRoomCard(
      String title, String description, List<String> features, IconData icon) {
    return Card(
      elevation: 8,
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: accentColor.withOpacity(0.5), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 30, color: accentColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: darkColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: darkColor.withOpacity(0.8)),
            ),
            const SizedBox(height: 8),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, size: 16, color: accentColor),
                      const SizedBox(width: 8),
                      Text(feature, style: TextStyle(color: darkColor)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
