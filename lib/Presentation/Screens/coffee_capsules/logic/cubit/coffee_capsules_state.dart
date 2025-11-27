part of 'coffee_capsules_cubit.dart';

@immutable
sealed class CoffeeCapsulesState {}

final class CoffeeCapsulesInitial extends CoffeeCapsulesState {}

final class CoffeeCapsulesLoading extends CoffeeCapsulesState {}

final class CoffeeCapsulesError extends CoffeeCapsulesState {
  final String message;
  CoffeeCapsulesError({required this.message});
}

final class CoffeeCapsulesLoaded extends CoffeeCapsulesState {
  final List<CoffeeCapsule> coffeeCapsulesNames;
  CoffeeCapsulesLoaded({required this.coffeeCapsulesNames});
}
