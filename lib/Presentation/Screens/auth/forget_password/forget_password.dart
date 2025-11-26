// ignore_for_file: deprecated_member_use

import 'package:brewly/Presentation/Screens/auth/logic/cubit/auth_cubit.dart';
import 'package:brewly/Presentation/Screens/auth/logic/cubit/auth_state.dart';
import 'package:brewly/Presentation/Screens/auth/widgets/auth_container.dart';
import 'package:brewly/Presentation/Screens/auth/widgets/auth_header.dart';
import 'package:brewly/Presentation/Screens/auth/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String? _requestedEmail;

  @override
  void dispose() {
    _emailController.dispose();
    context.read<AuthCubit>().clearPasswordResetFlag();
    super.dispose();
  }

  void _handleResetPassword() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final email = _emailController.text.trim();
    _requestedEmail = email;
    FocusScope.of(context).unfocus();
    context.read<AuthCubit>().resetPassword(email);
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
          previous.errorMessage != current.errorMessage ||
          previous.passwordResetEmailSent != current.passwordResetEmailSent,
      listener: (context, state) {
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          _showError(state.errorMessage!);
        }
      },
      builder: (context, state) {
        final bool emailSent = state.passwordResetEmailSent;
        final bool isLoading =
            state.isProcessing && state.activeFlow == AuthFlow.resetPassword;

        return Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            backgroundColor: Colors.brown[50],
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AuthHeader(
                        title: 'Forgot Password?',
                        subtitle:
                            'No worries, we\'ll send you reset instructions.',
                        showLogo: false,
                      ),
                      const SizedBox(height: 40),
                      if (!emailSent) ...[
                        Form(
                          key: _formKey,
                          child: AuthContainer(
                            heightFactor: 0.35,
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
                                  onPressed: isLoading
                                      ? null
                                      : _handleResetPassword,
                                  child: isLoading
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
                                          'Send Reset Link',
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
                      ] else ...[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    156,
                                    88,
                                    6,
                                  ).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.mark_email_read_outlined,
                                  size: 60,
                                  color: Color.fromARGB(255, 156, 88, 6),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Check your email',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'We sent a password reset link to',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                _requestedEmail ?? _emailController.text,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
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
                                  onPressed: () {
                                    context
                                        .read<AuthCubit>()
                                        .clearPasswordResetFlag();
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Back to Sign In',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 30),
                      if (!emailSent)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Remember your password? ",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                'Sign In',
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
          ),
        );
      },
    );
  }
}
