class CoffeeCapsule {
  final String image;
  final String name;
  final int intensity;
  final String flavorProfile;
  final List<String> machines;
  final List<String> flavorNotes;
  final List<String> brewingSteps;
  final List<String> suggestedDrinks;

  CoffeeCapsule({
    required this.image,
    required this.name,
    required this.intensity,
    required this.flavorProfile,
    required this.machines,
    required this.flavorNotes,
    required this.brewingSteps,
    required this.suggestedDrinks,
  });
}
