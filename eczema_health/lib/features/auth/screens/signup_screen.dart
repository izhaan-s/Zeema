import 'package:eczema_health/features/auth/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/repositories/cloud/auth_repository.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  bool passwordVisible = false;
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: !passwordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: togglePassword(),
              ),
            ),
            TextField(
              controller: firstName,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
            TextField(
              controller: lastName,
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            TextField(
              controller: dateOfBirth,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
              ),
            ),
            TextField(
              controller: phoneNumber,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                print("Sign up button pressed");
                final authRepository = AuthRepository();
                try {
                  print(
                      "Attempting to sign up user with email: ${emailController.text}");
                  final response = await authRepository.signUpUser(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  // Debug what we got back
                  print("Raw response data: ${response.toString()}");
                  print("User exists: ${response.user != null}");
                  print("Session exists: ${response.session != null}");

                  // For email confirmation flow, the session might be null until verified
                  // but we should still have a user object
                  if (response.user != null) {
                    // Navigate regardless of session status
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerificationScreen(
                          email: emailController.text, // Pass the email
                        ),
                      ),
                    );
                  } else {
                    // Something went wrong - no user
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Sign-up failed: No user returned")),
                    );
                  }
                } catch (e, stackTrace) {
                  // Print both error and stack trace for better debugging
                  print("Error during signup: $e");
                  print("Stack trace: $stackTrace");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Signup failed: $e")),
                  );
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Widget togglePassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            passwordVisible = !passwordVisible;
          });
        },
        icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off));
  }
}
