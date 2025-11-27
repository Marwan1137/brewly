part of 'equipment_cubit.dart';

sealed class EquipmentCubitState {}

final class EquipmentCubitInitial extends EquipmentCubitState {}

final class EquipmentCubitLoading extends EquipmentCubitState {}

final class EquipmentCubitError extends EquipmentCubitState {
  final String message;
  EquipmentCubitError({required this.message});
}

final class EquipmentCubitLoaded extends EquipmentCubitState {
  final List<Equipment> equipmentNames;
  EquipmentCubitLoaded({required this.equipmentNames});
}
