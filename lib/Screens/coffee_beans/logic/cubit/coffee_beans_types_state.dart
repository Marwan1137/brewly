part of 'coffee_beans_types_cubit.dart';

sealed class CoffeeBeansTypesState {}

final class CoffeeBeansTypesInitial extends CoffeeBeansTypesState {}

final class CoffeeBeanTypesLoading extends CoffeeBeansTypesState {}

final class CoffeeBeansTypesLoaded extends CoffeeBeansTypesState {
  final List<CoffeeBean> coffeeBeansTypes;

  CoffeeBeansTypesLoaded({required this.coffeeBeansTypes});
}

final class CoffeeBeansTypesError extends CoffeeBeansTypesState {
  final String message;
  CoffeeBeansTypesError({required this.message});
}
