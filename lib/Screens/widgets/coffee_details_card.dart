// ignore_for_file: deprecated_member_use

import 'package:brewly/domain/entities/cafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class GenericDetailsScreen<T> extends StatelessWidget {
  final T selectedItem;
  final List<T>? allItems;
  final String title;
  final String Function(T) getImage;
  final String Function(T) getName;
  final List<String> Function(T) getFlavorNotes;
  final List<String> Function(T) getBrewingSteps;
  final List<String> Function(T) getSuggestedDrinks;
  final Color? backgroundColor;
  final Color? chipColor;
  final String? getOriginHeading;
  final String? getOrigin;
  final int? getIntensity;
  final List<String> Function(T)? getMachines;
  final int? getPopularity;
  final double? rating;
  final String? flavorNotesHeading;
  final String? brewingStepsHeading;
  final String? suggestedDrinksHeading;
  final void Function(T item, int index)? onSuggestedDrinkTap;
  final void Function(T item, int index)? onCafeTap;
  // New parameters for cafes
  final List<Cafe>? Function(T)? getCafes;
  final String? cafesHeading;

  const GenericDetailsScreen({
    super.key,
    required this.selectedItem,
    this.allItems,
    required this.title,
    required this.getImage,
    required this.getName,
    required this.getFlavorNotes,
    required this.getBrewingSteps,
    required this.getSuggestedDrinks,
    this.backgroundColor,
    this.chipColor,
    this.getOrigin,
    this.getIntensity,
    this.getMachines,
    this.getPopularity,
    this.rating,
    this.flavorNotesHeading,
    this.brewingStepsHeading,
    this.suggestedDrinksHeading,
    this.onSuggestedDrinkTap,
    this.onCafeTap,
    this.getOriginHeading,
    this.getCafes,
    this.cafesHeading,
  });

  Future<void> _launchURL(String url) async {
    if (url.isEmpty) return;

    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

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
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                flavorNotesHeading ?? 'Flavor Notes',
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
            const SizedBox(height: 5),

            if (getIntensity != null) ...[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Intensity',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: chipBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$getIntensity',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 5),

            if (getMachines != null) ...[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Machines Can be Used On',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    ...getMachines!(selectedItem).map((note) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: chipBgColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          note,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 5),
            if (getOrigin != null) ...[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  getOriginHeading ?? 'Origin',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: chipBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    getOrigin!,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 5),

            if (getPopularity != null) ...[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Popularity',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: chipBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$getPopularity',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 5),
            if (rating != null) ...[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Rating',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: chipBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.white, size: 18),
                      const SizedBox(width: 4),
                      Text('$rating', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],

            // NEW: Cafes Section
            if (getCafes != null &&
                getCafes!(selectedItem) != null &&
                getCafes!(selectedItem)!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  cafesHeading ?? 'Popular Cafes',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: getCafes!(selectedItem)!.map((cafe) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: cafe.link.isNotEmpty
                            ? () => _launchURL(cafe.link)
                            : null,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: chipBgColor ?? Colors.brown.shade300,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      chipBgColor?.withOpacity(0.2) ??
                                      Colors.brown.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.local_cafe,
                                  color: chipBgColor ?? Colors.brown.shade600,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cafe.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    if (cafe.link.isNotEmpty) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        'Tap to visit website',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              if (cafe.link.isNotEmpty)
                                Icon(
                                  Icons.open_in_new,
                                  color: chipBgColor ?? Colors.brown.shade600,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],

            const SizedBox(height: 5),
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
                          brewingStepsHeading ?? 'Brewing Suggestions',
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
                            const SizedBox(height: 5),
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
                            const SizedBox(height: 10),
                            Text(
                              suggestedDrinksHeading ?? 'Suggested Drinks',
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
            if (allItems != null && allItems!.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'You Might Also Like',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: allItems!.length > 5 ? 5 : allItems!.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final mightLikeItem = allItems![index];
                          if (getName(selectedItem) == getName(mightLikeItem)) {
                            return const SizedBox.shrink();
                          }
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
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
                                    getIntensity: getIntensity,
                                    getMachines: getMachines,
                                    getOrigin: getOrigin,
                                    getPopularity: getPopularity,
                                    rating: rating,
                                    getCafes: getCafes,
                                    cafesHeading: cafesHeading,
                                    flavorNotesHeading: flavorNotesHeading,
                                    brewingStepsHeading: brewingStepsHeading,
                                    suggestedDrinksHeading:
                                        suggestedDrinksHeading,
                                    getOriginHeading: getOriginHeading,
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
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      getName(mightLikeItem),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ).animate().scaleXY(delay: 200.ms, duration: 1000.ms),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
          ],
        ).animate().scale(delay: 200.ms, duration: 900.ms),
      ),
    );
  }
}
