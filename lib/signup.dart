import 'package:flutter/material.dart';
import 'home.dart'; // Import the HomePage/Dashboard page
import 'login.dart'; // Import the Sign-In page

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showPassword = false; // Variable to track password visibility

  String? validateName(String value) {
    if (value.isEmpty) return "Name cannot be empty.";
    if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
      return "Name should only contain letters.";
    }
    if (value.length > 75) return "Name is too long.";
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) return "Email cannot be empty.";
    if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]+$").hasMatch(value)) {
      return "Enter a valid email address.";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 8) return "Password is too short.";
    if (value.length > 30) return "Password is too long.";
    // Updated regex to include `_` as a valid special character
    if (!RegExp(
            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_]).{8,}$")
        .hasMatch(value)) {
      return "Password must include at least 1 uppercase, 1 lowercase, 1 digit, and 1 special character.";
    }
    return null;
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      // Perform sign-up logic here, such as sending data to a server

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // First Name Field
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: "First Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => validateName(value!),
                ),
                const SizedBox(height: 16),
                // Last Name Field
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: "Last Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => validateName(value!),
                ),
                const SizedBox(height: 16),
                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => validateEmail(value!),
                ),
                const SizedBox(height: 16),
                // Password Field
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword; // Toggle visibility
                        });
                      },
                    ),
                  ),
                  obscureText: !_showPassword, // Conditionally obscure text
                  validator: (value) => validatePassword(value!),
                ),
                const SizedBox(height: 16),
                // Confirm Password Field
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return "Passwords do not match.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Sign-Up Button
                ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                  ),
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 20),
                // Navigate to Sign-In Page
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Already have an account? Sign In",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
