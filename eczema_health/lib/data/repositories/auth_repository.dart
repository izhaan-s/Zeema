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

      if (response.session == null) {
        throw Exception("Sign up failed");
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
