import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';
import '../../../data/repositories/auth_repository.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  
  const VerificationScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isVerified = false;
  bool isCheckingVerification = false;
  String? errorMessage;
  final supabase = Supabase.instance.client;
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    // Start checking after a brief delay to allow user to read instructions first
    Future.delayed(const Duration(seconds: 1), () {
      startVerificationCheck();
    });
  }
  
  void startVerificationCheck() {
    // Cancel any existing timer
    _timer?.cancel();
    
    // Check every 5 seconds (increased from 3s to avoid rate limits)
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      checkVerification();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> checkVerification() async {
    // Don't check again if already checking or verified
    if (isCheckingVerification || isVerified) return;
    
    try {
      setState(() {
        isCheckingVerification = true;
        errorMessage = null;
      });
      
      // Just check if the user exists and is verified
      final user = supabase.auth.currentUser;
      
      // If we have a current user, check if they're verified
      if (user != null) {
        if (user.emailConfirmedAt != null) {
          setState(() {
            isVerified = true;
          });
          _timer?.cancel(); // Stop checking once verified
          
          // Navigate to main app after verification confirmed
          await Future.delayed(const Duration(seconds: 2));
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        // Try to sign in with OTP (less frequent to avoid rate limits)
        // Only do this once every 3 checks
        if (_timer!.tick % 3 == 0) {
          await supabase.auth.signInWithOtp(
            email: widget.email,
            shouldCreateUser: false,
          );
        }
      }
    } catch (e) {
      // Handle rate limiting specifically
      if (e.toString().contains('rate limit')) {
        _timer?.cancel();
        setState(() {
          errorMessage = "Email sending rate limited. Please click the link in your email or try again later.";
        });
      } else {
        // Other errors, log but don't display to user
        print('Verification check error: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          isCheckingVerification = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.email,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 24),
              Text(
                'Verify your email',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'We\'ve sent a verification link to:',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                widget.email,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              if (isVerified)
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
              if (!isVerified && isCheckingVerification)
                const CircularProgressIndicator(),
              const SizedBox(height: 16),
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 24),
              Text(
                'Please check your inbox and click the verification link to continue',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}