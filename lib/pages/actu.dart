import 'package:flutter/material.dart';
import 'package:myapp/pages/reservation.dart';
import 'package:myapp/pages/profil.dart';

class ActualitesPage extends StatelessWidget {
  const ActualitesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Actualités',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF201c24),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF201c24),
              Color(0xFFa83c34).withOpacity(0.8),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildNewsCard(
              'Nouveaux équipements de fitness',
              'Nous avons ajouté de nouveaux équipements dans notre salle de fitness pour améliorer votre expérience d\'entraînement.',
              '',
              '2 heures',
            ),
            const SizedBox(height: 16),
            _buildNewsCard(
              'Cours de yoga en plein air',
              'Rejoignez-nous pour des sessions de yoga en plein air tous les samedis matin à partir de la semaine prochaine.',
              '',
              '1 jour',
            ),
            const SizedBox(height: 16),
            _buildNewsCard(
              'Promotion d\'été',
              'Profitez de notre offre spéciale : -20% sur tous les abonnements annuels pendant le mois de juillet.',
              '',
              '3 jours',
            ),
          ],
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
        backgroundColor: Color(0xFF201c24),
        selectedItemColor: Color(0xFFa83c34),
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

  Widget _buildNewsCard(
      String title, String description, String imagePath, String timeAgo) {
    return Card(
      elevation: 8,
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Color(0xFFa83c34).withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: Color(0xFF201c24),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Color(0xFFa83c34),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Il y a $timeAgo',
                      style: TextStyle(
                        color: Color(0xFFa83c34),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
