import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              // App Title
              Center(
                child: Text(
                  "Welcome to Vitality +",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Your personal health tracker",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 80),
              // Illustration Placeholder
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.health_and_safety,
                    size: 100,
                    color: Colors.red[700],
                  ),
                ),
              ),
              SizedBox(height: 80),
              // Sign In Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              // Sign Up Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.red[700]!, width: 2),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 18, color: Colors.red[700]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
