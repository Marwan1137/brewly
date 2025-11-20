// Create file: widgets/generic_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GenericDetailsScreen<T> extends StatelessWidget {
  final T selectedItem;
  final List<T> allItems;
  final String title;
  final String Function(T) getImage;
  final String Function(T) getName;
  final List<String> Function(T) getFlavorNotes;
  final List<String> Function(T) getBrewingSteps;
  final List<String> Function(T) getSuggestedDrinks;
  final Color? backgroundColor;
  final Color? chipColor;

  const GenericDetailsScreen({
    super.key,
    required this.selectedItem,
    required this.allItems,
    required this.title,
    required this.getImage,
    required this.getName,
    required this.getFlavorNotes,
    required this.getBrewingSteps,
    required this.getSuggestedDrinks,
    this.backgroundColor,
    this.chipColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Colors.brown[50];
    final chipBgColor = chipColor ?? Colors.brown[300];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        surfaceTintColor: bgColor,
        title: Text(
          title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.asset(getImage(selectedItem), fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Flavor Notes',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  ...getFlavorNotes(selectedItem).map((note) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: chipBgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(note, style: TextStyle(color: Colors.white)),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black12, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Brewing Suggestions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey.shade300,
                            margin: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getBrewingSteps(selectedItem).first,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            ...getBrewingSteps(selectedItem)
                                .skip(1)
                                .map(
                                  (step) => Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('• '),
                                        Expanded(
                                          child: Text(
                                            step,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            SizedBox(height: 10),
                            Text(
                              'Suggested Drinks',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey.shade300,
                                margin: EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                            ...getSuggestedDrinks(selectedItem).map(
                              (drink) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('• '),
                                    Expanded(
                                      child: Text(
                                        drink,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'You Might Also Like',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 5,
                      separatorBuilder: (_, _) => SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final mightLikeItem = allItems[index];
                        if (getName(selectedItem) == getName(mightLikeItem)) {
                          return SizedBox.shrink();
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => GenericDetailsScreen<T>(
                                  selectedItem: mightLikeItem,
                                  allItems: allItems,
                                  title: getName(mightLikeItem),
                                  getImage: getImage,
                                  getName: getName,
                                  getFlavorNotes: getFlavorNotes,
                                  getBrewingSteps: getBrewingSteps,
                                  getSuggestedDrinks: getSuggestedDrinks,
                                  backgroundColor: backgroundColor,
                                  chipColor: chipColor,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    getImage(mightLikeItem),
                                    height: 110,
                                    width: 140,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  getName(mightLikeItem),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ).animate().flip(delay: 1200.ms, duration: 1000.ms),
                ],
              ),
            ),
          ],
        ).animate().flip(delay: 500.ms, duration: 900.ms),
      ),
    );
  }
}
