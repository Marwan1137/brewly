// ignore_for_file: deprecated_member_use

import 'package:brewly/Presentation/Screens/auth/logic/cubit/auth_cubit.dart';
import 'package:brewly/Presentation/Screens/auth/logic/cubit/auth_state.dart';
import 'package:brewly/Presentation/Screens/auth/signin_screen/sign_in.dart';
import 'package:brewly/domain/entities/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthCubit>().state.user;
    _firstNameController = TextEditingController(text: user?.firstName ?? '');
    _lastNameController = TextEditingController(text: user?.lastName ?? '');
    _phoneController = TextEditingController(text: user?.phoneNumber ?? '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _syncControllers(UserProfile? user) {
    if (user == null) return;
    if (_firstNameController.text != user.firstName) {
      _firstNameController.text = user.firstName;
    }
    if (_lastNameController.text != user.lastName) {
      _lastNameController.text = user.lastName;
    }
    if (_phoneController.text != (user.phoneNumber ?? '')) {
      _phoneController.text = user.phoneNumber ?? '';
    }
  }

  void _handleSave() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final authCubit = context.read<AuthCubit>();
    final user = authCubit.state.user;
    if (user == null) return;

    authCubit.updateProfile(
      userId: user.id,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
    );
  }

  void _handleSignOut() async {
    await context.read<AuthCubit>().signOut();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SignInScreen()),
      (route) => false,
    );
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : null,
        ),
      );
    if (isError) {
      context.read<AuthCubit>().clearErrorMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.user != current.user ||
          previous.profileUpdateSuccess != current.profileUpdateSuccess ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.user != null) {
          _syncControllers(state.user);
        }

        if (state.profileUpdateSuccess) {
          _showMessage('Profile updated successfully');
          context.read<AuthCubit>().clearProfileUpdateFlag();
        }

        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          _showMessage(state.errorMessage!, isError: true);
        }
      },
      builder: (context, state) {
        final user = state.user;
        final isInitializing =
            state.isProcessing && state.activeFlow == AuthFlow.initializing;
        final isUpdating =
            state.isProcessing && state.activeFlow == AuthFlow.updateProfile;

        if (isInitializing) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status != AuthStatus.authenticated || user == null) {
          return Scaffold(
            backgroundColor: Colors.brown[50],
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_off, size: 64, color: Colors.brown),
                    const SizedBox(height: 20),
                    const Text(
                      'You are not signed in.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please sign in to manage your profile information.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 156, 88, 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const SignInScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text('Go to Sign In'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            backgroundColor: Colors.brown[50],
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body:
              SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _ProfileHeader(user: user),
                          const SizedBox(height: 30),
                          Form(
                            key: _formKey,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.brown.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  _ProfileTextField(
                                    controller: _firstNameController,
                                    label: 'First Name',
                                    icon: Icons.person_outline,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your first name';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  _ProfileTextField(
                                    controller: _lastNameController,
                                    label: 'Last Name',
                                    icon: Icons.person_outline,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your last name';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  _ProfileTextField(
                                    controller: _phoneController,
                                    label: 'Phone Number',
                                    icon: Icons.phone_outlined,
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your phone number';
                                      }
                                      if (value.length < 7) {
                                        return 'Enter a valid phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  _ReadOnlyField(
                                    label: 'Email',
                                    value: user.email,
                                    icon: Icons.email_outlined,
                                  ),
                                  const SizedBox(height: 30),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          156,
                                          88,
                                          6,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                      onPressed: isUpdating
                                          ? null
                                          : _handleSave,
                                      child: isUpdating
                                          ? const SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                      Colors.white,
                                                    ),
                                              ),
                                            )
                                          : const Text(
                                              'Save Changes',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextButton(
                                    onPressed: _handleSignOut,
                                    child: const Text(
                                      'Sign Out',
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .animate()
                  .shimmer(delay: 500.ms, duration: 1500.ms)
                  .fadeIn(delay: 200.ms, duration: 800.ms),
        );
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    final imageUrl = user.photoUrl;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.brown.shade100,
            backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : null,
            child: (imageUrl == null || imageUrl.isEmpty)
                ? const Icon(Icons.person, size: 36, color: Colors.brown)
                : null,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                if (user.phoneNumber != null &&
                    user.phoneNumber!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    user.phoneNumber!,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTextField extends StatelessWidget {
  const _ProfileTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.brown.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 156, 88, 6)),
        ),
      ),
    );
  }
}

class _ReadOnlyField extends StatelessWidget {
  const _ReadOnlyField({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
