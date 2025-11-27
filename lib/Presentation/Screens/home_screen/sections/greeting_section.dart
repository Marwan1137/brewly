import 'package:brewly/Presentation/Screens/auth/logic/cubit/auth_cubit.dart';
import 'package:brewly/Presentation/Screens/auth/logic/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final firstName = state.user?.firstName;
        final displayName = (firstName != null && firstName.isNotEmpty)
            ? firstName
            : 'Brewer';

        return RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  const TextSpan(text: 'Welcome Back '),
                  TextSpan(
                    text: '$displayName ',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 156, 88, 6),
                    ),
                  ),
                  const WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(Icons.coffee, color: Colors.brown),
                  ),
                  const TextSpan(text: ' your brew awaits!'),
                ],
              ),
            )
            .animate()
            .fadeIn(delay: 200.ms, duration: 500.ms)
            .slideX(begin: -0.1, end: 0);
      },
    );
  }
}
