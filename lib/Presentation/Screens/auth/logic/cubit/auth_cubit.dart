import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brewly/Presentation/Screens/auth/logic/cubit/auth_state.dart';
import 'package:brewly/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'dart:io';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthState.initial()) {
    _authSubscription = _authRepository.authStateChanges.listen(
      _handleAuthChange,
    );
  }

  final AuthRepository _authRepository;
  StreamSubscription<User?>? _authSubscription;

  Future<void> initialize() async {
    emit(
      state.copyWith(
        activeFlow: AuthFlow.initializing,
        isProcessing: true,
        clearErrorMessage: true,
      ),
    );
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            user: user,
            activeFlow: AuthFlow.none,
            isProcessing: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AuthStatus.unauthenticated,
            activeFlow: AuthFlow.none,
            isProcessing: false,
            clearUser: true,
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          activeFlow: AuthFlow.none,
          isProcessing: false,
          errorMessage: _extractMessage(error),
          clearUser: true,
        ),
      );
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(
      state.copyWith(
        activeFlow: AuthFlow.signIn,
        isProcessing: true,
        clearErrorMessage: true,
        passwordResetEmailSent: false,
      ),
    );
    try {
      final profile = await _authRepository.signIn(email, password);
      emit(
        state.copyWith(
          status: profile != null
              ? AuthStatus.authenticated
              : AuthStatus.unauthenticated,
          user: profile,
          activeFlow: AuthFlow.none,
          isProcessing: false,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          activeFlow: AuthFlow.none,
          isProcessing: false,
          errorMessage: _extractMessage(error),
        ),
      );
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    File? photoFile,
  }) async {
    emit(
      state.copyWith(
        activeFlow: AuthFlow.signUp,
        isProcessing: true,
        clearErrorMessage: true,
      ),
    );
    try {
      final profile = await _authRepository.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        photoFile: photoFile,
      );

      emit(
        state.copyWith(
          status: profile != null
              ? AuthStatus.authenticated
              : AuthStatus.unauthenticated,
          user: profile,
          activeFlow: AuthFlow.none,
          isProcessing: false,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          activeFlow: AuthFlow.none,
          isProcessing: false,
          errorMessage: _extractMessage(error),
        ),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    emit(
      state.copyWith(
        activeFlow: AuthFlow.googleSignIn,
        isProcessing: true,
        clearErrorMessage: true,
      ),
    );
    try {
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(activeFlow: AuthFlow.none, isProcessing: false));
    } catch (error) {
      emit(
        state.copyWith(
          activeFlow: AuthFlow.none,
          isProcessing: false,
          errorMessage: _extractMessage(error),
        ),
      );
    }
  }

  Future<void> resetPassword(String email) async {
    emit(
      state.copyWith(
        activeFlow: AuthFlow.resetPassword,
        isProcessing: true,
        clearErrorMessage: true,
        passwordResetEmailSent: false,
      ),
    );
    try {
      await _authRepository.resetPassword(email);
      emit(
        state.copyWith(
          activeFlow: AuthFlow.none,
          isProcessing: false,
          passwordResetEmailSent: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          activeFlow: AuthFlow.none,
          isProcessing: false,
          errorMessage: _extractMessage(error),
        ),
      );
    }
  }

  Future<void> updateProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) async {
    emit(
      state.copyWith(
        activeFlow: AuthFlow.updateProfile,
        isProcessing: true,
        profileUpdateSuccess: false,
        clearErrorMessage: true,
      ),
    );
    try {
      final updatedProfile = await _authRepository.updateProfile(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      );
      emit(
        state.copyWith(
          user: updatedProfile ?? state.user,
          activeFlow: AuthFlow.none,
          isProcessing: false,
          profileUpdateSuccess: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          activeFlow: AuthFlow.none,
          isProcessing: false,
          errorMessage: _extractMessage(error),
          profileUpdateSuccess: false,
        ),
      );
    }
  }

  Future<void> signOut() async {
    emit(
      state.copyWith(
        activeFlow: AuthFlow.signOut,
        isProcessing: true,
        clearErrorMessage: true,
      ),
    );
    try {
      await _authRepository.signOut();
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          activeFlow: AuthFlow.none,
          isProcessing: false,
          clearUser: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          activeFlow: AuthFlow.none,
          isProcessing: false,
          errorMessage: _extractMessage(error),
        ),
      );
    }
  }

  void clearPasswordResetFlag() {
    emit(state.copyWith(passwordResetEmailSent: false));
  }

  void clearProfileUpdateFlag() {
    emit(state.copyWith(profileUpdateSuccess: false));
  }

  void clearErrorMessage() {
    emit(state.copyWith(clearErrorMessage: true));
  }

  void _handleAuthChange(User? user) {
    if (user == null) {
      emit(state.copyWith(status: AuthStatus.unauthenticated, clearUser: true));
      return;
    }
    unawaited(_refreshCurrentUser());
  }

  Future<void> _refreshCurrentUser() async {
    final profile = await _authRepository.getCurrentUser();
    if (profile != null) {
      emit(state.copyWith(status: AuthStatus.authenticated, user: profile));
    }
  }

  String _extractMessage(Object error) {
    final errorMessage = error.toString();
    return errorMessage.replaceFirst('Exception: ', '');
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
