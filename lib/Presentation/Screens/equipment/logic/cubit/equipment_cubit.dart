import 'package:brewly/domain/entities/equipment.dart';
import 'package:brewly/domain/repositories/equpment_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'equipment_cubit_state.dart';

@injectable
class EquipmentCubit extends Cubit<EquipmentCubitState> {
  final EquipmentRepo equipmentRepo;
  EquipmentCubit({required this.equipmentRepo})
    : super(EquipmentCubitInitial());
  Equipment? selectedEquipment;
  Future<void> loadEquipments() async {
    try {
      emit(EquipmentCubitLoading());
      final equipmentNames = await equipmentRepo.getEquipments();
      emit(EquipmentCubitLoaded(equipmentNames: equipmentNames));
    } catch (e) {
      emit(EquipmentCubitError(message: e.toString()));
    }
  }
}
