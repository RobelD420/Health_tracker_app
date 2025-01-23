import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  double weight = 70;
  double height = 170;
  double sugar = 100;
  double systolicPressure = 120;
  double diastolicPressure = 80;
  int age = 25;
  String suggestion = '';

  double calculateBMI() {
    return weight / ((height / 100) * (height / 100));
  }

  void updateSuggestion() {
    double bmi = calculateBMI();
    suggestion = '';
    if (bmi < 18.5) {
      suggestion = 'Underweight - consider a balanced diet.';
    } else if (bmi < 24.9) {
      suggestion = 'Normal weight - keep up the good work!';
    } else {
      suggestion = 'Overweight - consider regular exercise.';
    }
    if (sugar > 140) {
      suggestion += '\n-High sugar levels: Monitor closely.';
    }
    if (systolicPressure > 130 || diastolicPressure > 90) {
      suggestion += '\n-High blood pressure: Consult a doctor.';
    }
  }

  Color determineColor(bool warningCondition) {
    return warningCondition ? Colors.red : Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vitality +'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSliderWithWarning(
                title: 'Weight (kg)',
                value: weight,
                min: 2,
                max: 200,
                unit: 'kg',
                onChanged: (value) {
                  setState(() {
                    weight = value;
                    updateSuggestion();
                  });
                },
                warningCondition: weight < 50 || weight > 150,
              ),
              buildSliderWithWarning(
                title: 'Height (cm)',
                value: height,
                min: 100,
                max: 220,
                unit: 'cm',
                onChanged: (value) {
                  setState(() {
                    height = value;
                    updateSuggestion();
                  });
                },
              ),
              buildSliderWithWarning(
                title: 'Sugar Level (mg/dL)',
                value: sugar,
                min: 70,
                max: 200,
                unit: 'mg/dL',
                onChanged: (value) {
                  setState(() {
                    sugar = value;
                    updateSuggestion();
                  });
                },
                warningCondition: sugar > 140,
              ),
              buildSliderWithWarning(
                title: 'Systolic Pressure (mmHg)',
                value: systolicPressure,
                min: 70,
                max: 220,
                unit: 'mmHg',
                onChanged: (value) {
                  setState(() {
                    systolicPressure = value;
                    updateSuggestion();
                  });
                },
                warningCondition:
                    systolicPressure > 130 || systolicPressure < 90,
              ),
              buildSliderWithWarning(
                title: 'Diastolic Pressure (mmHg)',
                value: diastolicPressure,
                min: 40,
                max: 150,
                unit: 'mmHg',
                onChanged: (value) {
                  setState(() {
                    diastolicPressure = value;
                    updateSuggestion();
                  });
                },
                warningCondition:
                    diastolicPressure > 90 || diastolicPressure < 60,
              ),
              buildSliderWithWarning(
                title: 'Age',
                value: age.toDouble(),
                min: 10,
                max: 100,
                unit: 'years',
                onChanged: (value) {
                  setState(() {
                    age = value.toInt();
                    updateSuggestion();
                  });
                },
              ),
              Text(
                'BMI: ${calculateBMI().toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  color: determineColor(
                      calculateBMI() < 18.5 || calculateBMI() > 24.9),
                ),
              ),
              if (calculateBMI() < 18.5 || calculateBMI() > 24.9)
                const Text(
                  'Warning: BMI is outside the normal range.',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              const SizedBox(height: 20),
              const Text(
                'Suggestions:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                suggestion,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSliderWithWarning({
    required String title,
    required double value,
    required double min,
    required double max,
    required String unit,
    required ValueChanged<double> onChanged,
    bool warningCondition = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '$title: ${value.toStringAsFixed(1)} $unit',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: determineColor(warningCondition),
                ),
              ),
            ),
            if (warningCondition) const Icon(Icons.warning, color: Colors.red),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: (value) {
            if (value >= min && value <= max) {
              onChanged(value);
            }
          },
          activeColor: determineColor(warningCondition),
        ),
        if (warningCondition)
          const Text(
            'Warning: Value is outside the normal range.',
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
      ],
    );
  }
}
