class CoffeeBean {
  final String name;
  final String origin;
  final String roastLevel; // Light, Medium, Dark
  final List<String> flavorNotes;
  final double rating; // Optional: for sorting
  final int popularity; // Optional: for sorting

  CoffeeBean({
    required this.name,
    required this.origin,
    required this.roastLevel,
    required this.flavorNotes,
    this.rating = 0.0,
    this.popularity = 0,
  });
}
