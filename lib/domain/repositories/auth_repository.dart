import 'package:brewly/domain/entities/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

abstract class AuthRepository {
  Future<UserProfile?> signIn(String email, String password);
  Future<UserProfile?> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    File? photoFile,
  });
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<UserProfile?> signInWithGoogle();
  Future<UserProfile?> getCurrentUser();
  Future<UserProfile?> updateProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    File? photoFile,
  });
  Stream<User?> get authStateChanges;
}
