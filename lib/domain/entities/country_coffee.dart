import 'package:brewly/domain/entities/cafe.dart';

class CountryCoffee {
  final String name;
  final String flag;
  final List<String> famousCoffees;
  final String intensity;
  final String flavorProfile;
  final List<Cafe> cafes;

  CountryCoffee({
    required this.name,
    required this.flag,
    required this.famousCoffees,
    required this.intensity,
    required this.flavorProfile,
    required this.cafes,
  });
}
