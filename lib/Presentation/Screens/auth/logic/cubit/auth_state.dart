import 'package:brewly/domain/entities/user_profile.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

enum AuthFlow {
  none,
  initializing,
  signIn,
  signUp,
  googleSignIn,
  resetPassword,
  updateProfile,
  signOut,
}

class AuthState {
  const AuthState({
    required this.status,
    required this.activeFlow,
    required this.isProcessing,
    this.user,
    this.errorMessage,
    this.passwordResetEmailSent = false,
    this.profileUpdateSuccess = false,
  });

  factory AuthState.initial() => const AuthState(
    status: AuthStatus.unknown,
    activeFlow: AuthFlow.none,
    isProcessing: false,
  );

  final AuthStatus status;
  final AuthFlow activeFlow;
  final bool isProcessing;
  final UserProfile? user;
  final String? errorMessage;
  final bool passwordResetEmailSent;
  final bool profileUpdateSuccess;

  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthState copyWith({
    AuthStatus? status,
    AuthFlow? activeFlow,
    bool? isProcessing,
    UserProfile? user,
    bool clearUser = false,
    String? errorMessage,
    bool clearErrorMessage = false,
    bool? passwordResetEmailSent,
    bool? profileUpdateSuccess,
  }) {
    return AuthState(
      status: status ?? this.status,
      activeFlow: activeFlow ?? this.activeFlow,
      isProcessing: isProcessing ?? this.isProcessing,
      user: clearUser ? null : (user ?? this.user),
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
      passwordResetEmailSent:
          passwordResetEmailSent ?? this.passwordResetEmailSent,
      profileUpdateSuccess: profileUpdateSuccess ?? this.profileUpdateSuccess,
    );
  }
}
