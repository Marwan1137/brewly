import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:brewly/Presentation/Screens/onboarding/on_boarding_screeen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: 250,
            child: LottieBuilder.asset("assets/animations/Coffee_love.json"),
          ),
          Text('Brewly', style: TextStyle(fontSize: 30, color: Colors.white70)),
          const SizedBox(height: 20),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(seconds: 2),
            builder: (context, value, child) {
              return Opacity(opacity: value, child: child);
            },
            child: Text(
              'Discover your own taste of coffee',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
      nextScreen: OnBoardingScreen(),
      splashIconSize: 400,
      backgroundColor: Color.fromARGB(68, 132, 68, 3),
    );
  }
}
