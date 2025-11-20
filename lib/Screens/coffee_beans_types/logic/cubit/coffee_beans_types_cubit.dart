import 'package:brewly/domain/entities/coffeebean_types.dart';
import 'package:brewly/domain/repositories/coffee_beans_types_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'coffee_beans_types_state.dart';

@injectable
class CoffeeBeansTypesCubit extends Cubit<CoffeeBeansTypesState> {
  final CoffeeBeansTypesRepo beansTypesRepo;
  CoffeeBeansTypesCubit({required this.beansTypesRepo})
    : super(CoffeeBeansTypesInitial());

  CoffeeBean? selectedCoffee;

  Future<void> loadCoffeeTypes() async {
    try {
      emit(CoffeeBeanTypesLoading());

      final beansTypes = await beansTypesRepo.getCoffeeBeans();

      emit(CoffeeBeansTypesLoaded(coffeeBeansTypes: beansTypes));
    } catch (e) {
      emit(CoffeeBeansTypesError(message: e.toString()));
    }
  }

  void selectCoffee(CoffeeBean coffee) {
    selectedCoffee = coffee;
  }
}
