class CoffeeCapsule {
  final String image;
  final String name;
  final int intensity; // 1-10
  final String flavorProfile;
  final List<String> machines;
  final List<String> flavorNotes; // NEW - for flavor chips
  final List<String> brewingSteps; // NEW - for brewing instructions
  final List<String> suggestedDrinks; // NEW - for suggested drinks

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
