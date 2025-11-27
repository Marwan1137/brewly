// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showLogo;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showLogo) ...[
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/homescreenimages/coffeeoutlined.svg',
                      width: 40,
                      height: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Brewly',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
        Text(
          title,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: TextStyle(fontSize: 17, color: Colors.grey[700]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
