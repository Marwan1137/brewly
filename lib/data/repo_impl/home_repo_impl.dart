// data/repositories/home_repository_impl.dart
import 'dart:math';
import 'package:brewly/domain/entities/brew_tip.dart';
import 'package:brewly/domain/entities/category.dart';
import 'package:brewly/domain/entities/coffee.dart';
import 'package:brewly/domain/entities/recommended.dart';
import 'package:brewly/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepo)
class HomeRepositoryImpl implements HomeRepo {
  final random = Random();

  final List<Coffee> allCoffees = [
    Coffee(
      name: 'Ethiopian Yirgacheffe',
      description: 'Floral, citrusy',
      imagePath: 'assets/images/homescreenimages/featuredcoffee.png',
    ),
    Coffee(
      name: 'Colombian Supremo',
      description: 'Chocolatey, smooth',
      imagePath: 'assets/images/homescreenimages/featuredcoffee.png',
    ),
    Coffee(
      name: 'Kenya AA',
      description: 'Bright and fruity',
      imagePath: 'assets/images/homescreenimages/featuredcoffee.png',
    ),
    Coffee(
      name: 'Brazil Santos',
      description: 'Nutty and balanced',
      imagePath: 'assets/images/homescreenimages/featuredcoffee.png',
    ),
  ];

  final List<Recommended> allRecommended = [
    Recommended(
      name: 'Brazilian Bourbon',
      description:
          'Sweet and smooth with notes of chocolate and caramel, perfect for a cozy morning cup.',
      imagePath: 'assets/images/homescreenimages/recommended1.png',
    ),
    Recommended(
      name: 'Costa Rican Tarrazu',
      description:
          'Bright acidity with a clean finish, offering citrus and floral notes in every sip.',
      imagePath: 'assets/images/homescreenimages/recommended2.png',
    ),
    Recommended(
      name: 'Sumatra Mandheling',
      description:
          'Full-bodied and earthy with low acidity, a rich cup with chocolatey undertones.',
      imagePath: 'assets/images/homescreenimages/recommended3.png',
    ),
    Recommended(
      name: 'Honduran Marcala',
      description:
          'Balanced and sweet, featuring nutty and chocolate hints for an easy-drinking coffee.',
      imagePath: 'assets/images/homescreenimages/recommended4.png',
    ),
    Recommended(
      name: 'Rwandan Bourbon',
      description:
          'Fruity and aromatic with a delicate sweetness, perfect for exploring unique flavors.',
      imagePath: 'assets/images/homescreenimages/recommended5.png',
    ),
  ];

  final List<BrewTip> allTips = [
    BrewTip(
      text: 'Grind fresh before brewing',
      iconPath: 'assets/images/homescreenimages/quickbrew1.svg',
    ),
    BrewTip(
      text: 'Pre-heat your equipment',
      iconPath: 'assets/images/homescreenimages/quickbrew2.svg',
    ),
    BrewTip(
      text: 'Measure coffee-to-water ratio',
      iconPath: 'assets/images/homescreenimages/quickbrew3.svg',
    ),
  ];

  final List<Category> allCategories = [
    Category(
      name: 'Beans',
      iconPath: 'assets/images/homescreenimages/coffeeoutlined.svg',
    ),
    Category(
      name: 'Capsules',
      iconPath: 'assets/images/homescreenimages/explore2.svg',
    ),
    Category(
      name: 'Equipment',
      iconPath: 'assets/images/homescreenimages/explore3.svg',
    ),
    // Category(
    //   name: 'Methods',
    //   iconPath: 'assets/images/homescreenimages/coffeeoutlined.svg',
    // ),
  ];

  @override
  Future<List<Coffee>> getFeaturedCoffees() async {
    final shuffled = List<Coffee>.from(allCoffees)..shuffle(random);
    return shuffled.take(1).toList();
  }

  @override
  Future<List<Recommended>> getRecommendedCoffees() async {
    final shuffled = List<Recommended>.from(allRecommended)..shuffle(random);
    return shuffled.take(3).toList();
  }

  @override
  Future<List<BrewTip>> getQuickBrewTips() async {
    final shuffled = List<BrewTip>.from(allTips)..shuffle(random);
    return shuffled.take(3).toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    return allCategories;
  }
}
