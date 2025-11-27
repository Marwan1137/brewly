import 'package:brewly/domain/entities/country_coffee.dart';

abstract class ExploreTabRepo {
  Future<List<CountryCoffee>> allCountriesCoffees();
}
