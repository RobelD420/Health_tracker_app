import 'package:flutter/material.dart';
import 'input_screen.dart'; // Importing the InputScreen
import 'settings.dart'; // Importing the Settings page
import 'medication_tracker.dart'; // Importing the Medication Tracker page
import 'package:intl/intl.dart'; // Importing for date formatting

class HomePage extends StatelessWidget {
  // List of medications with their scheduled times
  final List<Map<String, dynamic>> medications = [
    {'name': 'Omega 3', 'time': '08:00'},
    {'name': 'Comlivit', 'time': '08:00'},
    {'name': '5-HTP', 'time': '14:00'},
  ];

  // Function to check for upcoming medications within the next hour
  List<String> checkForUpcomingMedications() {
    List<String> upcomingMedications = [];
    DateTime now = DateTime.now();
    DateTime oneHourLater = now.add(Duration(hours: 1));

    for (var med in medications) {
      DateTime medTime = DateFormat.Hm().parse(med['time']);
      DateTime medDateTime =
          DateTime(now.year, now.month, now.day, medTime.hour, medTime.minute);

      if (medDateTime.isAfter(now) && medDateTime.isBefore(oneHourLater)) {
        upcomingMedications.add(med['name']);
      }
    }

    return upcomingMedications;
  }

  @override
  Widget build(BuildContext context) {
    List<String> upcomingMedications = checkForUpcomingMedications();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vitality +', style: TextStyle(fontSize: 22)),
        backgroundColor: Colors.red, // Red theme for the app bar
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.red, // Red background for the drawer header
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Welcome, User!',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  SizedBox(height: 10),
                  Text('Your Health Tracker',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              title: const Text('Home'),
              leading: const Icon(Icons.home, color: Colors.red),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ExpansionTile(
              title: const Text('Health Data'),
              leading: const Icon(Icons.favorite, color: Colors.red),
              children: [
                ListTile(
                  title: const Text('Input Health Data'),
                  leading: const Icon(Icons.edit, color: Colors.red),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InputScreen()),
                    );
                  },
                ),
              ],
            ),
            ListTile(
              title: const Text('Medication Tracker'),
              leading: const Icon(Icons.medical_services, color: Colors.red),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MedicationTrackerPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Settings'),
              leading: const Icon(Icons.settings, color: Colors.red),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (upcomingMedications.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Upcoming Medications',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      for (var med in upcomingMedications)
                        Text(
                          med,
                          style: const TextStyle(fontSize: 16),
                        ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              const Text(
                'Hey, USER!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Thursday',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your plan is almost done!',
                    style: TextStyle(fontSize: 18),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text('78%', style: TextStyle(fontSize: 22)),
                      Text('13% more than last week',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.red[100],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Get vaccinated',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    Text('Nearest vaccination center',
                        style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Health Data Overview',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Example health data card
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.red[50],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Normal BP Levels',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text('120/80', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Example medication card (similar to screenshot)
              const Text(
                '8:00',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        leading: Icon(Icons.medication, color: Colors.red),
                        title: const Text('Omega 3'),
                        subtitle: const Text('1 tablet after meals'),
                        trailing: const Text('7 days'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        leading: Icon(Icons.medication, color: Colors.red),
                        title: const Text('Comlivit'),
                        subtitle: const Text('1 tablet after meals'),
                        trailing: const Text('7 days'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                '14:00',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 3,
                child: ListTile(
                  leading: Icon(Icons.medical_services, color: Colors.red),
                  title: const Text('5-HTP'),
                  subtitle: const Text('1 ampule'),
                  trailing: const Text('+'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
