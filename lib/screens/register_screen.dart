// lib/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:taskmaster/screens/login_screen.dart'; // Import LoginScreen
import 'package:taskmaster/screens/my_tasks_screen.dart'; // We'll create this later
import 'package:taskmaster/widgets/text_link.dart'; // Assuming TextLink is in widgets/

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordVisible = false; // State variable for password visibility
  bool _confirmPasswordVisible =
      false; // State variable for confirm password visibility

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    // For now, just print the credentials and navigate.
    // In a real app, you'd integrate with Firebase Auth, your backend, or local storage.
    if (_passwordController.text == _confirmPasswordController.text) {
      print(
        'Registration Attempt: Email - ${_emailController.text}, Password - ${_passwordController.text}',
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyTasksScreen(),
        ), // Navigate to MyTasksScreen after successful registration
      );
    } else {
      // Show an error message if passwords don't match
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Spacer to push content down slightly
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText:
                    !_passwordVisible, // Use state variable for visibility
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible =
                            !_passwordVisible; // Toggle visibility
                      });
                    },
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                obscureText:
                    !_confirmPasswordVisible, // Use state variable for visibility
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible =
                            !_confirmPasswordVisible; // Toggle visibility
                      });
                    },
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _register,
                  child: const Text('Register'),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextLink(
                    text: "Already have an account?",
                    linkText: "Login",
                    onTap: (BuildContext context) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Placeholder for keyboard
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
