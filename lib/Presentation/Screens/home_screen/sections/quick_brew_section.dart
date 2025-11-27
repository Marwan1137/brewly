import 'package:brewly/domain/entities/brew_tip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuickBrewTipCard extends StatelessWidget {
  final BrewTip tip;
  const QuickBrewTipCard({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black26, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    tip.iconPath.isNotEmpty
                        ? SvgPicture.asset(
                            tip.iconPath,
                            colorFilter: const ColorFilter.mode(
                              Color.fromARGB(255, 156, 88, 6),
                              BlendMode.srcIn,
                            ),
                          )
                        : const Icon(Icons.lightbulb_outline),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        tip.text,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .animate()
            .fadeIn(delay: 1200.ms, duration: 600.ms)
            .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
      ],
    );
  }
}
