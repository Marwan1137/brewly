import 'package:brewly/Presentation/Screens/auth/forget_password/forget_password.dart';
import 'package:brewly/Presentation/Screens/auth/logic/cubit/auth_cubit.dart';
import 'package:brewly/Presentation/Screens/auth/logic/cubit/auth_state.dart';
import 'package:brewly/Presentation/Screens/auth/signup_screen/sign_up.dart';
import 'package:brewly/Presentation/Screens/auth/widgets/auth_container.dart';
import 'package:brewly/Presentation/Screens/auth/widgets/auth_header.dart';
import 'package:brewly/Presentation/Screens/auth/widgets/social_login_button.dart';
import 'package:brewly/Presentation/Screens/auth/widgets/textfield.dart';
import 'package:brewly/Presentation/navbar/UI/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    context.read<AuthCubit>().signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  void _handleGoogleSignIn() {
    FocusScope.of(context).unfocus();
    context.read<AuthCubit>().signInWithGoogle();
  }

  void _navigateToHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => NavbarUi()),
      (route) => false,
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
    context.read<AuthCubit>().clearErrorMessage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          _navigateToHome();
        } else if (state.errorMessage != null &&
            state.errorMessage!.isNotEmpty) {
          _showError(state.errorMessage!);
        }
      },
      builder: (context, state) {
        final bool isSignInLoading =
            state.isProcessing && state.activeFlow == AuthFlow.signIn;
        final bool isGoogleLoading =
            state.isProcessing && state.activeFlow == AuthFlow.googleSignIn;

        return Scaffold(
          backgroundColor: Colors.brown[50],
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AuthHeader(
                      title: 'Welcome Back!',
                      subtitle: 'Your Next perfect brew Awaits.',
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: AuthContainer(
                        children: [
                          CustomInputField(
                            label: 'Email',
                            hint: 'Enter your email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(Icons.email_outlined),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          CustomInputField(
                            label: 'Password',
                            hint: 'Enter your password',
                            controller: _passwordController,
                            isPassword: true,
                            prefixIcon: const Icon(Icons.lock_outline),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const ForgotPasswordScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 156, 88, 6),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  156,
                                  88,
                                  6,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: isSignInLoading ? null : _handleSignIn,
                              child: isSignInLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 25,
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              "or",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SocialLoginButton(
                      icon: FontAwesomeIcons.google,
                      text: isGoogleLoading
                          ? 'Connecting...'
                          : 'Sign In with Google',
                      iconColor: Colors.red,
                      onPressed: isGoogleLoading ? null : _handleGoogleSignIn,
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      icon: FontAwesomeIcons.apple,
                      text: 'Sign In with Apple',
                      iconColor: Colors.black,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color.fromARGB(255, 156, 88, 6),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
            ),
          ),
        );
      },
    );
  }
}
