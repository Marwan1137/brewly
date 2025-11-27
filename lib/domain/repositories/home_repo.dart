import 'package:brewly/domain/entities/brew_tip.dart';
import 'package:brewly/domain/entities/category.dart';
import 'package:brewly/domain/entities/coffee.dart';
import 'package:brewly/domain/entities/recommended.dart';

abstract class HomeRepo {
  Future<List<Coffee>> getFeaturedCoffees();
  Future<List<Recommended>> getRecommendedCoffees();
  Future<List<BrewTip>> getQuickBrewTips();
  Future<List<Category>> getCategories();
}
