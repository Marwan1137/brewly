part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final Coffee featuredCoffees;
  final List<Recommended> recommendedCoffees;
  final List<BrewTip> quickBrewTips;
  final List<Category> categories;

  HomeLoaded({
    required this.featuredCoffees,
    required this.recommendedCoffees,
    required this.quickBrewTips,
    required this.categories,
  });
}

final class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}
