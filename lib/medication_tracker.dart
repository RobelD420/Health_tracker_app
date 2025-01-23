import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // Importing the calendar package

class MedicationTrackerPage extends StatefulWidget {
  @override
  _MedicationTrackerPageState createState() => _MedicationTrackerPageState();
}

class _MedicationTrackerPageState extends State<MedicationTrackerPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Map<String, String>>> _medicationSchedules =
      {}; // Stores schedules per day

  void _addSchedule(String time, String medicine) {
    setState(() {
      if (_selectedDay != null) {
        if (_medicationSchedules[_selectedDay!] == null) {
          _medicationSchedules[_selectedDay!] = [];
        }
        _medicationSchedules[_selectedDay!]!.add({
          'time': time,
          'medicine': medicine,
        });
      }
    });
  }

  void _removeSchedule(String time, String medicine) {
    setState(() {
      if (_selectedDay != null && _medicationSchedules[_selectedDay!] != null) {
        _medicationSchedules[_selectedDay!]?.removeWhere((schedule) =>
            schedule['time'] == time && schedule['medicine'] == medicine);
        if (_medicationSchedules[_selectedDay!]!.isEmpty) {
          _medicationSchedules.remove(_selectedDay!);
        }
      }
    });
  }

  Future<void> _showAddScheduleDialog() async {
    String? timeInput;
    String? medicineInput;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Medication Schedule"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Enter time (HH:MM)"),
                onChanged: (value) {
                  timeInput = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Enter medicine name"),
                onChanged: (value) {
                  medicineInput = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (timeInput != null &&
                    RegExp(r'^\d{2}:\d{2}$').hasMatch(timeInput!) &&
                    medicineInput != null &&
                    medicineInput!.isNotEmpty) {
                  _addSchedule(timeInput!, medicineInput!);
                }
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showRemoveScheduleDialog() async {
    if (_selectedDay == null || _medicationSchedules[_selectedDay!] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No schedules available to remove.")),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Remove Medication Schedule"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _medicationSchedules[_selectedDay!]!
                .map((schedule) => ListTile(
                      title:
                          Text('${schedule['time']} - ${schedule['medicine']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _removeSchedule(
                              schedule['time']!, schedule['medicine']!);
                          Navigator.pop(context);
                        },
                      ),
                    ))
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medication Tracker', style: TextStyle(fontSize: 22)),
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.red,
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
                Navigator.pushReplacementNamed(context, '/');
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
                    Navigator.pushNamed(context, '/input');
                  },
                ),
              ],
            ),
            ListTile(
              title: const Text('Medication Tracker'),
              leading: const Icon(Icons.medical_services, color: Colors.red),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              leading: const Icon(Icons.settings, color: Colors.red),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
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
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Schedules for ${_selectedDay != null ? _selectedDay!.toIso8601String().split('T')[0] : 'None'}:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              if (_selectedDay != null &&
                  _medicationSchedules[_selectedDay!] != null)
                ..._medicationSchedules[_selectedDay!]!
                    .map((schedule) => ListTile(
                          title: Text(
                              '${schedule['time']} - ${schedule['medicine']}'),
                          leading: Icon(Icons.schedule, color: Colors.red),
                        ))
                    .toList()
              else
                Text("No schedules for this day."),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _showAddScheduleDialog,
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            heroTag: 'add',
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _showRemoveScheduleDialog,
            child: Icon(Icons.remove),
            backgroundColor: Colors.red,
            heroTag: 'remove',
          ),
        ],
      ),
    );
  }
}
