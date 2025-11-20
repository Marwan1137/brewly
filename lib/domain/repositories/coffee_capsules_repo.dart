import 'package:brewly/domain/entities/coffee_capsules.dart';

abstract class CoffeeCapsulesRepo {
  Future<List<CoffeeCapsule>> getCoffeeCapsules();
}
