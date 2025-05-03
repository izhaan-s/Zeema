import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository({SupabaseClient? supabase})
      : _supabase = supabase ?? Supabase.instance.client;

  Future<AuthResponse> verifyUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session == null) {
        throw Exception('Auth failed');
      }
      // This point means auth was successful
      
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      
      // Debug information
      print("Sign up response received: ${response.toString()}");
      print("User: ${response.user?.toJson()}");
      
      // Don't throw an exception if session is null - for email confirmation,
      // session will be null until email is verified, but user should exist
      if (response.user == null) {
        throw Exception("Sign up failed - no user returned");
      }
      
      return response;
    } catch (e) {
      print("Error in AuthRepository.signUpUser: $e");
      // Re-throw with more context
      throw Exception("Sign up failed: ${e.toString()}");
    }
  }
}
