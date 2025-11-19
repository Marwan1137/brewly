import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Text(
                  'Welcome Back ',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              WidgetSpan(
                child: Text(
                  'Marwan ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: const Icon(Icons.coffee, color: Colors.brown),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Text(
                  ' your Brew awaits!',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 500.ms)
        .slideX(begin: -0.1, end: 0);
  }
}
