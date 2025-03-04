import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/repositories/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: () async{

                final authRepository = AuthRepository();
                try {
                  final response = await authRepository.verifyUser(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  if (response.user != null) {
                    // Navigate to home screen
                    print('Logged in user: ${response.user?.email}');
                    print('User ID: ${response.user?.id}');
                  }
                } catch (e){
                  // Handle login error here

                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}