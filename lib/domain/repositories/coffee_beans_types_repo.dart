import 'package:brewly/domain/entities/coffeebean_types.dart';

abstract class CoffeeBeansTypesRepo {
  Future<List<CoffeeBean>> getCoffeeBeans();
}
