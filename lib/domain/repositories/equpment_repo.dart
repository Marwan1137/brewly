import 'package:brewly/domain/entities/equipment.dart';

abstract class EquipmentRepo {
  Future<List<Equipment>> getEquipments();
}
