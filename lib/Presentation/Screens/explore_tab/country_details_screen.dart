import 'package:brewly/Presentation/Screens/widgets/coffee_details_card.dart';
import 'package:brewly/domain/entities/country_coffee.dart';
import 'package:flutter/material.dart';

class CountryDetailsScreen extends StatelessWidget {
  final CountryCoffee selectedCountry;
  final List<CountryCoffee>? allCountries;

  const CountryDetailsScreen({
    super.key,
    required this.selectedCountry,
    this.allCountries,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDetailsScreen<CountryCoffee>(
      selectedItem: selectedCountry,
      allItems: allCountries,
      title: selectedCountry.name,
      getImage: (country) => country.flag,
      getName: (country) => country.name,
      getFlavorNotes: (country) => country.flavorProfile.split(', '),
      getBrewingSteps: (country) => [
        'Coffee Profile from ${country.name}',
        'Famous varieties: ${country.famousCoffees.join(", ")}',
        'Intensity: ${country.intensity}',
        'Best enjoyed using traditional brewing methods',
        'Explore local cafes for authentic experience',
      ],
      getSuggestedDrinks: (country) => country.famousCoffees,
      getOriginHeading: 'Intensity',
      getOrigin: selectedCountry.intensity,
      flavorNotesHeading: 'Flavor Profile',
      brewingStepsHeading: 'Coffee Information',
      suggestedDrinksHeading: 'Famous Coffee Varieties',
      // Add cafes section
      getCafes: (country) => country.cafes,
      cafesHeading: 'Popular Cafes in ${selectedCountry.name}',
      // Styling
      backgroundColor: Colors.brown[50],
      chipColor: Colors.brown[400],
    );
  }
}
