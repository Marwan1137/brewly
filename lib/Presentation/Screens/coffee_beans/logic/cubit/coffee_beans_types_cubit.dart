import 'package:brewly/domain/entities/coffeebean_types.dart';
import 'package:brewly/domain/repositories/coffee_beans_types_repo.dart';
import 'package:brewly/domain/repositories/quiz_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'coffee_beans_types_state.dart';

@injectable
class CoffeeBeansTypesCubit extends Cubit<CoffeeBeansTypesState> {
  final CoffeeBeansTypesRepo beansTypesRepo;
  final QuizRepo quizRepo;

  CoffeeBeansTypesCubit({required this.beansTypesRepo, required this.quizRepo})
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

  Future<List<CoffeeBean>> getFilteredByTaste() async {
    final history = await quizRepo.getQuizHistory();
    if (history.latestAnswer == null) {
      // Return all if no quiz completed
      return await beansTypesRepo.getCoffeeBeans();
    }

    final answer = history.latestAnswer!;
    final allBeans = await beansTypesRepo.getCoffeeBeans();

    // Filter based on preferences
    return allBeans.where((bean) {
      // Match roast level
      final roastMatch = bean.roastLevel.toLowerCase().contains(
        answer.roastPreference.toLowerCase(),
      );

      // Match flavor notes
      final flavorMatch = bean.flavorNotes.any(
        (note) =>
            answer.flavorProfile.toLowerCase().contains(note.toLowerCase()),
      );

      return roastMatch || flavorMatch;
    }).toList();
  }
}
