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
        title: const Text('Sign Up'),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              autofillHints: const [
                AutofillHints.username,
                AutofillHints.email
              ],
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: !passwordVisible,
              autofillHints: const [AutofillHints.newPassword],
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: togglePassword(),
              ),
            ),
            TextField(
              controller: firstName,
              autofillHints: const [AutofillHints.givenName],
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
            TextField(
              controller: lastName,
              autofillHints: const [AutofillHints.familyName],
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            TextField(
              controller: dateOfBirth,
              autofillHints: const [AutofillHints.birthday],
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
              ),
            ),
            TextField(
              controller: phoneNumber,
              autofillHints: const [AutofillHints.telephoneNumber],
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final authRepository = AuthRepository();
                try {
                  final response = await authRepository.signUpUser(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  // Debug what we got back

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
