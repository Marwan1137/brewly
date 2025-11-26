part of 'explore_tab_cubit.dart';

sealed class ExploreTabState {}

final class ExploreTabInitial extends ExploreTabState {}

final class ExploreTabLoading extends ExploreTabState {}

final class ExploreTabError extends ExploreTabState {
  final String message;

  ExploreTabError({required this.message});
}

final class ExploreTabLoaded extends ExploreTabState {
  final List<CountryCoffee> countryCoffee;

  ExploreTabLoaded({required this.countryCoffee});
}
