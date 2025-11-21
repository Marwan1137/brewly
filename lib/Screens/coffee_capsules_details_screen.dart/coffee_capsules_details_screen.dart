import 'package:brewly/Screens/widgets/coffee_details_card.dart';
import 'package:brewly/domain/entities/coffee_capsules.dart';
import 'package:flutter/material.dart';

class CoffeeCapsulesDetailsScreen extends StatelessWidget {
  final CoffeeCapsule selectedCapsule;
  final List<CoffeeCapsule> allCapsules;
  const CoffeeCapsulesDetailsScreen({
    required this.allCapsules,
    required this.selectedCapsule,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDetailsScreen<CoffeeCapsule>(
      selectedItem: selectedCapsule,
      allItems: allCapsules,
      title: selectedCapsule.name,
      getImage: (capsule) => capsule.image,
      getName: (capsule) => capsule.name,
      getFlavorNotes: (capsule) => capsule.flavorNotes,
      getBrewingSteps: (capsule) => capsule.brewingSteps,
      getSuggestedDrinks: (capsule) => capsule.suggestedDrinks,
      backgroundColor: Colors.brown[50],
      chipColor: Colors.brown[300],
      getMachines: (capsule) => capsule.machines,
      getIntensity: selectedCapsule.intensity,
    );
  }
}
