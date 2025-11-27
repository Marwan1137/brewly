import 'dart:io';

import 'package:brewly/Presentation/Screens/auth/logic/cubit/auth_cubit.dart';
import 'package:brewly/Presentation/Screens/auth/logic/cubit/auth_state.dart';
import 'package:brewly/Presentation/Screens/auth/widgets/auth_container.dart';
import 'package:brewly/Presentation/Screens/auth/widgets/auth_header.dart';
import 'package:brewly/Presentation/Screens/auth/widgets/textfield.dart';
import 'package:brewly/Presentation/navbar/UI/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _photoFile;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      setState(() {
        _photoFile = File(picked.path);
      });
    }
  }

  void _handleSignUp() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    context.read<AuthCubit>().signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      photoFile: _photoFile,
    );
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
        final bool isLoading =
            state.isProcessing && state.activeFlow == AuthFlow.signUp;

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
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AuthHeader(
                        title: 'Create Account',
                        subtitle: 'Join us and discover your perfect brew!',
                        showLogo: false,
                      ),
                      const SizedBox(height: 20),

                      // Avatar picker
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.brown.shade100,
                          backgroundImage: _photoFile != null
                              ? FileImage(_photoFile!)
                              : null,
                          child: _photoFile == null
                              ? const Icon(
                                  Icons.camera_alt,
                                  color: Colors.brown,
                                  size: 32,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Add a profile photo',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      const SizedBox(height: 20),

                      Form(
                        key: _formKey,
                        child: AuthContainer(
                          heightFactor: 0.7,
                          children: [
                            CustomInputField(
                              label: 'First Name',
                              hint: 'Enter your first name',
                              controller: _firstNameController,
                              prefixIcon: const Icon(Icons.person_outline),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                            CustomInputField(
                              label: 'Last Name',
                              hint: 'Enter your last name',
                              controller: _lastNameController,
                              prefixIcon: const Icon(Icons.person_outline),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                            CustomInputField(
                              label: 'Phone Number',
                              hint: 'Enter your phone number',
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              prefixIcon: const Icon(Icons.phone_outlined),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                if (value.length < 7) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                            ),
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
                              hint: 'Create a password',
                              controller: _passwordController,
                              isPassword: true,
                              prefixIcon: const Icon(Icons.lock_outline),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            CustomInputField(
                              label: 'Confirm Password',
                              hint: 'Confirm your password',
                              controller: _confirmPasswordController,
                              isPassword: true,
                              prefixIcon: const Icon(Icons.lock_outline),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
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
                                onPressed: isLoading ? null : _handleSignUp,
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
                                        'Sign Up',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
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
