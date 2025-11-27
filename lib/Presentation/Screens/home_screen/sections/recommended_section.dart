import 'package:brewly/domain/entities/recommended.dart';
import 'package:flutter/material.dart';

class RecommendedCoffeeCard extends StatelessWidget {
  final Recommended recommended;
  const RecommendedCoffeeCard({super.key, required this.recommended});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black38, width: 1),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: ListTile(
        leading: recommended.imagePath.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  recommended.imagePath,
                  width: 100,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            : const CircleAvatar(child: Icon(Icons.local_cafe)),
        title: Text(recommended.name),
        subtitle: Text(recommended.description),
        onTap: () {},
      ),
    );
  }
}
