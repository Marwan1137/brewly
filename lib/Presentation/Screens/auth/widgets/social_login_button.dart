import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final VoidCallback? onPressed;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.90,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.grey.shade300, width: 0.5),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, color: iconColor),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
