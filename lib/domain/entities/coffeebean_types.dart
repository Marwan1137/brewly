class CoffeeBean {
  final String name;
  final String origin;
  final String roastLevel;
  final List<String> flavorNotes;
  final double rating;
  final int popularity;
  final List<String> brewingSteps;
  final List<String> suggestedDrinks;
  final String image;
  final String description;

  CoffeeBean({
    required this.name,
    required this.origin,
    required this.roastLevel,
    required this.flavorNotes,
    this.rating = 0.0,
    this.popularity = 0,
    this.brewingSteps = const [],
    this.suggestedDrinks = const [],
    required this.image,
    required this.description,
  });
}
