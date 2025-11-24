class FavoriteItem {
  final String name;
  final String type; // 'capsule', 'bean', 'country', 'equipment'
  final String image;
  final String description;
  final DateTime addedAt;

  FavoriteItem({
    required this.name,
    required this.type,
    required this.image,
    required this.description,
    required this.addedAt,
  });
}
