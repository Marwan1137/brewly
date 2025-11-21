import 'package:brewly/Screens/equipment/logic/cubit/equipment_cubit.dart';
import 'package:brewly/Screens/widgets/coffee_item_card.dart';
import 'package:brewly/data/DI/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EquipmentCubit>()..loadEquipments(),
      child: BlocBuilder<EquipmentCubit, EquipmentCubitState>(
        builder: (context, state) {
          if (state is EquipmentCubitLoading ||
              state is EquipmentCubitInitial) {
            return const Scaffold(
              backgroundColor: Colors.brown,
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is EquipmentCubitError) {
            return Scaffold(
              body: SafeArea(
                child: Center(child: Text('Error: ${state.message}')),
              ),
            );
          }
          if (state is EquipmentCubitLoaded) {
            return GenericListScreen(
              title: 'Equipments',
              items: state.equipmentNames,
              getImage: (equipment) => equipment.image,
              getName: (equipment) => equipment.name,
              getDescription: (equipment) => '',
              getLink: (equipment) => equipment.link,
              onItemTap: (context, equipment) {
                launchUrl(Uri.parse(equipment.link));
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
