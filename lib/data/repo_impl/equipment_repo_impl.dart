import 'package:brewly/domain/entities/equipment.dart';
import 'package:brewly/domain/repositories/equpment_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EquipmentRepo)
class EquipmentRepoImpl implements EquipmentRepo {
  final List<Equipment> allEquipments = [
    Equipment(
      name: 'V60',
      image: 'assets/images/methodsimages/v60.jpg',
      link: 'https://global.hario.com/v60/v60series.html',
    ),
    Equipment(
      name: 'Chemex',
      image: 'assets/images/methodsimages/Chemex.jpg',
      link: 'https://chemexcoffeemaker.com/',
    ),
    Equipment(
      name: 'Aeropress',
      image: 'assets/images/methodsimages/Aeropress.jpg',
      link: 'https://aeropress.com/',
    ),
    Equipment(
      name: 'Dolce Gusto',
      image: 'assets/images/methodsimages/dolcegusto.jpg',
      link: 'https://www.dolce-gusto.com/',
    ),
    Equipment(
      name: 'Nespresso',
      image: 'assets/images/methodsimages/nespresso.jpg',
      link: 'https://www.nespresso.com/',
    ),
    Equipment(
      name: 'Drip Coffee Maker',
      image: 'assets/images/methodsimages/driblecoffee.jpg',
      link: 'https://www.breville.com/en-us/shop/coffee',
    ),
    Equipment(
      name: 'Espresso Machines',
      image: 'assets/images/methodsimages/espressomachine.jpg',
      link: 'https://www.breville.com/en-us/shop/espresso',
    ),
    Equipment(
      name: 'French Bress',
      image: 'assets/images/methodsimages/frenchpress.jpg',
      link:
          'https://www.bodum.com/us/en/1928-16us4-chambord?utm_source=chatgpt.com',
    ),
    Equipment(
      name: 'Cold Brew',
      image: 'assets/images/methodsimages/coldbrew.jpg',
      link:
          'https://www.bodum.com/gb/en/k11683-913-bean-set?utm_source=chatgpt.com',
    ),
  ];

  @override
  Future<List<Equipment>> getEquipments() {
    return Future.value(allEquipments);
  }
}
