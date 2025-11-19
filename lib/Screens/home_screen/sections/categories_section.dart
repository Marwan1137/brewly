import 'package:brewly/domain/entities/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              category.iconPath.isNotEmpty
                  ? SvgPicture.asset(
                      category.iconPath,
                      width: 40,
                      height: 40,
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.category, size: 40),
              const SizedBox(height: 10),
              Text(category.name, style: const TextStyle(fontSize: 12)),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 1500.ms, duration: 600.ms)
        .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
  }
}
