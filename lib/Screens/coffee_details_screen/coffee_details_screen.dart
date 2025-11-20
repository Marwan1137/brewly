import 'package:brewly/Screens/widgets/coffee_details_card.dart';
import 'package:brewly/domain/entities/coffeebean_types.dart';
import 'package:flutter/material.dart';

class CoffeeDetailsScreen extends StatelessWidget {
  final CoffeeBean selectedCoffee;
  final List<CoffeeBean> allCoffees;

  const CoffeeDetailsScreen({
    required this.allCoffees,
    required this.selectedCoffee,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDetailsScreen<CoffeeBean>(
      selectedItem: selectedCoffee,
      allItems: allCoffees,
      title: selectedCoffee.name,
      getImage: (coffee) => coffee.image,
      getName: (coffee) => coffee.name,
      getFlavorNotes: (coffee) => coffee.flavorNotes,
      getBrewingSteps: (coffee) => coffee.brewingSteps,
      getSuggestedDrinks: (coffee) => coffee.suggestedDrinks,
      backgroundColor: Colors.brown[50],
      chipColor: Colors.brown[300],
    );
  }
}
