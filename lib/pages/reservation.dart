import 'package:flutter/material.dart';
import 'package:myapp/pages/profil.dart';
import 'package:myapp/main.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _durationController = TextEditingController(text: '1');
  String? _selectedRoomType;

  final Color darkColor = const Color(0xFF201c24);
  final Color accentColor = const Color(0xFFa83c34);

  final List<String> _roomTypes = ['Fitness', 'Yoga', 'Cardio', 'Musculation'];

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: accentColor,
              onPrimary: Colors.white,
              surface: darkColor,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: accentColor,
              onPrimary: Colors.white,
              surface: darkColor,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _timeController.text =
            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Réserver une salle',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              darkColor,
              darkColor.withOpacity(0.8),
              accentColor.withOpacity(0.6),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.event_available,
                              color: accentColor,
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Détails de la réservation',
                              style: TextStyle(
                                color: darkColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        DropdownButtonFormField<String>(
                          value: _selectedRoomType,
                          decoration: InputDecoration(
                            labelText: 'Type de salle',
                            labelStyle:
                                TextStyle(color: darkColor, fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: accentColor, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: accentColor.withOpacity(0.5),
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: accentColor, width: 2),
                            ),
                            prefixIcon:
                                Icon(Icons.fitness_center, color: accentColor),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: _roomTypes.map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type,
                                  style: TextStyle(color: darkColor)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedRoomType = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez sélectionner un type de salle';
                            }
                            return null;
                          },
                          icon: Icon(Icons.arrow_drop_down, color: accentColor),
                          dropdownColor: Colors.white,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            labelText: 'Date',
                            labelStyle:
                                TextStyle(color: darkColor, fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: accentColor, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: accentColor.withOpacity(0.5),
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: accentColor, width: 2),
                            ),
                            prefixIcon:
                                Icon(Icons.calendar_today, color: accentColor),
                            suffixIcon: IconButton(
                              icon:
                                  Icon(Icons.edit_calendar, color: accentColor),
                              onPressed: () => _selectDate(context),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez sélectionner une date';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _timeController,
                          decoration: InputDecoration(
                            labelText: 'Heure',
                            labelStyle:
                                TextStyle(color: darkColor, fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: accentColor, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: accentColor.withOpacity(0.5),
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: accentColor, width: 2),
                            ),
                            prefixIcon:
                                Icon(Icons.access_time, color: accentColor),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.more_time, color: accentColor),
                              onPressed: () => _selectTime(context),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez sélectionner une heure';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _durationController,
                          decoration: InputDecoration(
                            labelText: 'Durée (Heure)',
                            labelStyle:
                                TextStyle(color: darkColor, fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: accentColor, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: accentColor.withOpacity(0.5),
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: accentColor, width: 2),
                            ),
                            prefixIcon: Icon(Icons.timer, color: accentColor),
                            suffixIcon: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    int currentValue =
                                        int.parse(_durationController.text);
                                    if (currentValue < 10) {
                                      setState(() {
                                        _durationController.text =
                                            (currentValue + 1).toString();
                                      });
                                    }
                                  },
                                  child: Icon(Icons.arrow_drop_up,
                                      color: accentColor),
                                ),
                                InkWell(
                                  onTap: () {
                                    int currentValue =
                                        int.parse(_durationController.text);
                                    if (currentValue > 1) {
                                      setState(() {
                                        _durationController.text =
                                            (currentValue - 1).toString();
                                      });
                                    }
                                  },
                                  child: Icon(Icons.arrow_drop_down,
                                      color: accentColor),
                                ),
                              ],
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer une durée';
                            }
                            int? duration = int.tryParse(value);
                            if (duration == null ||
                                duration < 1 ||
                                duration > 10) {
                              return 'La durée doit être entre 1 et 10 heures';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(Icons.check_circle,
                                      color: Colors.white),
                                  const SizedBox(width: 10),
                                  const Text(
                                      'Traitement de la réservation en cours...'),
                                ],
                              ),
                              backgroundColor: accentColor,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.check_circle_outline,
                              color: Colors.white, size: 24),
                          SizedBox(width: 10),
                          Text(
                            'Confirmer la réservation',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Réservation',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
          currentIndex: 1,
          backgroundColor: darkColor,
          selectedItemColor: accentColor,
          unselectedItemColor: Colors.white70,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            } else if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            }
          },
        ),
      ),
    );
  }
}
