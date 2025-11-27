import 'package:brewly/domain/entities/coffee_capsules.dart';
import 'package:brewly/domain/repositories/coffee_capsules_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'coffee_capsules_state.dart';

@injectable
class CoffeeCapsulesCubit extends Cubit<CoffeeCapsulesState> {
  final CoffeeCapsulesRepo capsulesRepo;
  CoffeeCapsulesCubit({required this.capsulesRepo})
    : super(CoffeeCapsulesInitial());

  CoffeeCapsule? selectedCapsule;

  Future<void> loadCoffeeCapsules() async {
    try {
      emit(CoffeeCapsulesLoading());
      final capsulesNames = await capsulesRepo.getCoffeeCapsules();
      emit(CoffeeCapsulesLoaded(coffeeCapsulesNames: capsulesNames));
    } catch (e) {
      emit(CoffeeCapsulesError(message: e.toString()));
    }
  }

  void selectCapsule(CoffeeCapsule capsule) {
    selectedCapsule = capsule;
  }
}
