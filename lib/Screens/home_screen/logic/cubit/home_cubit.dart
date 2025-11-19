import 'package:brewly/domain/entities/brew_tip.dart';
import 'package:brewly/domain/entities/category.dart';
import 'package:brewly/domain/entities/coffee.dart';
import 'package:brewly/domain/entities/recommended.dart';
import 'package:brewly/domain/repositories/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeRepo hrepo;
  HomeCubit({required this.hrepo}) : super(HomeInitial());

  Future<void> loadHomeData() async {
    try {
      emit(HomeLoading());

      final featuredCoffees = await hrepo.getFeaturedCoffees();
      final recommendedCoffees = await hrepo.getRecommendedCoffees();
      final quickBrewTips = await hrepo.getQuickBrewTips();
      final categories = await hrepo.getCategories();

      emit(
        HomeLoaded(
          featuredCoffees: featuredCoffees.first,
          recommendedCoffees: recommendedCoffees,
          quickBrewTips: quickBrewTips,
          categories: categories,
        ),
      );
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
