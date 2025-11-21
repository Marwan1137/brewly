// Create file: widgets/generic_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GenericListScreen<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final String Function(T) getImage;
  final String Function(T) getName;
  final String Function(T) getDescription;
  final void Function(BuildContext context, T item)? onItemTap;
  final Color? backgroundColor;
  final String Function(T)? getLink;

  const GenericListScreen({
    super.key,
    required this.title,
    required this.items,
    required this.getImage,
    required this.getName,
    required this.getDescription,
    required this.onItemTap,
    this.backgroundColor,
    this.getLink,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Colors.brown[50];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        surfaceTintColor: bgColor,
        title: Text(
          title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
              onTap: () => onItemTap!(context, item),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white10,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        getImage(item),
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getName(item),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            getDescription(item),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),

                          if (getLink != null) ...[
                            Center(
                              child: Text(
                                getLink!(item),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ).animate().scaleXY(delay: 1000.ms, duration: 600.ms),
                    ),
                  ],
                ),
              ),
            );
          },
        ).animate().scale(delay: 800.ms, duration: 900.ms),
      ),
    );
  }
}
