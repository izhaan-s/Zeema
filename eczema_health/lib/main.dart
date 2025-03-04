import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/supabase_secrets.dart';
import 'features/auth/screens/login_screen.dart';

final supabase = Supabase.instance.client;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.supabaseKey,
  );
  runApp(const EczemaHealthApp());
}

class EczemaHealthApp extends StatelessWidget {
  const EczemaHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eczema Health',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AuthRedirect(),
    );
  }
}

class AuthRedirect extends StatefulWidget {
  const AuthRedirect({super.key});

  @override
  State<AuthRedirect> createState() => _AuthRedirectState();
}

class _AuthRedirectState extends State<AuthRedirect> {
  
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Always redirects to login for now adjust later
    return const LoginScreen();
  }
}