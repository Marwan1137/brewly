import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.brown[50],
      surfaceTintColor: Colors.brown[50],
      title:
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/homescreenimages/coffeeoutlined.svg',
                      width: 30,
                      height: 30,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      fit: BoxFit.scaleDown,
                    ),
                  ),

                  const Icon(
                    Icons.notifications_none,
                    size: 30,
                    color: Colors.black,
                  ),
                ],
              )
              .animate()
              .fadeIn(delay: 0.ms, duration: 400.ms)
              .slideY(begin: -0.2, end: 0),
    );
  }

  @override
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
