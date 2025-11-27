import 'dart:async';
import 'dart:io';
import 'package:brewly/domain/entities/user_profile.dart';
import 'package:brewly/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._client);

  final SupabaseClient _client;
  static const String _profilesTable = 'profiles';
  static const String _avatarsBucket = 'avatars';

  @override
  Future<UserProfile?> signIn(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) return null;

      final profile = await _getProfile(user.id);
      if (profile != null) return profile;

      final metadata = user.userMetadata ?? <String, dynamic>{};
      return UserProfile(
        id: user.id,
        email: user.email ?? email,
        firstName: (metadata['first_name'] ?? metadata['given_name'] ?? '')
            .toString(),
        lastName: (metadata['last_name'] ?? metadata['family_name'] ?? '')
            .toString(),
        phoneNumber: metadata['phone_number']?.toString(),
        photoUrl: metadata['photo_url']?.toString(),
      );
    } on AuthException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception('Failed to sign in: $error');
    }
  }

  @override
  Future<UserProfile?> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    File? photoFile,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) return null;

      String? photoUrl;
      if (photoFile != null) {
        photoUrl = await _uploadProfileImage(user.id, photoFile);
      }

      final profilePayload = {
        'id': user.id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'photo_url': photoUrl,
      };

      await _client.from(_profilesTable).insert(profilePayload);
      return UserProfile.fromJson(profilePayload);
    } on AuthException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception('Failed to sign up: $error');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } on AuthException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception('Failed to sign out: $error');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } on AuthException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception('Unable to send reset email: $error');
    }
  }

  @override
  Future<UserProfile?> signInWithGoogle() async {
    try {
      await _client.auth.signInWithOAuth(OAuthProvider.google);
      final user = _client.auth.currentUser;
      if (user == null) return null;

      final existingProfile = await _getProfile(user.id);
      if (existingProfile != null) return existingProfile;

      final metadata = user.userMetadata ?? <String, dynamic>{};
      final profilePayload = {
        'id': user.id,
        'email': user.email,
        'first_name': (metadata['given_name'] ?? metadata['first_name'] ?? '')
            .toString(),
        'last_name': (metadata['family_name'] ?? metadata['last_name'] ?? '')
            .toString(),
        'phone_number': metadata['phone_number']?.toString(),
        'photo_url': (metadata['picture'] ?? metadata['photo_url'])?.toString(),
      };

      await _client.from(_profilesTable).upsert(profilePayload);
      return UserProfile.fromJson(profilePayload);
    } on AuthException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception('Google sign in failed: $error');
    }
  }

  @override
  Future<UserProfile?> getCurrentUser() async {
    final currentUser = _client.auth.currentUser;
    if (currentUser == null) return null;

    final profile = await _getProfile(currentUser.id);
    if (profile != null) return profile;

    final metadata = currentUser.userMetadata ?? <String, dynamic>{};
    return UserProfile(
      id: currentUser.id,
      email: currentUser.email ?? '',
      firstName: (metadata['first_name'] ?? metadata['given_name'] ?? '')
          .toString(),
      lastName: (metadata['last_name'] ?? metadata['family_name'] ?? '')
          .toString(),
      phoneNumber: metadata['phone_number']?.toString(),
      photoUrl: (metadata['photo_url'] ?? metadata['picture'])?.toString(),
    );
  }

  @override
  Future<UserProfile?> updateProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    File? photoFile,
  }) async {
    try {
      String? photoUrl;
      if (photoFile != null) {
        photoUrl = await _uploadProfileImage(userId, photoFile);
      }

      final payload = <String, dynamic>{
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
        if (phoneNumber != null) 'phone_number': phoneNumber,
        if (photoUrl != null) 'photo_url': photoUrl,
      };

      if (payload.isEmpty) {
        return await _getProfile(userId);
      }

      await _client.from(_profilesTable).update(payload).eq('id', userId);
      return await _getProfile(userId);
    } catch (error) {
      throw Exception('Failed to update profile: $error');
    }
  }

  Future<String> _uploadProfileImage(String userId, File file) async {
    final fileExt = file.path.split('.').last;
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
    final path = 'profiles/$userId/$fileName';

    await _client.storage
        .from(_avatarsBucket)
        .upload(path, file, fileOptions: const FileOptions(upsert: true));

    return _client.storage.from(_avatarsBucket).getPublicUrl(path);
  }

  @override
  Stream<User?> get authStateChanges =>
      _client.auth.onAuthStateChange.map((data) => data.session?.user);

  Future<UserProfile?> _getProfile(String userId) async {
    try {
      final response = await _client
          .from(_profilesTable)
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response == null) return null;
      return UserProfile.fromJson(response);
    } catch (error) {
      return null;
    }
  }
}
