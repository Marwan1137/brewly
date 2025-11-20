import 'package:brewly/Screens/coffee_capsules_details_screen.dart/coffee_capsules_details_screen.dart';
import 'package:brewly/Screens/coffee_capsules_screen/logic/cubit/coffee_capsules_cubit.dart';
import 'package:brewly/Screens/widgets/coffee_item_card.dart';
import 'package:brewly/data/DI/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeCapsulesScreen extends StatelessWidget {
  const CoffeeCapsulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CoffeeCapsulesCubit>()..loadCoffeeCapsules(),
      child: BlocBuilder<CoffeeCapsulesCubit, CoffeeCapsulesState>(
        builder: (context, state) {
          if (state is CoffeeCapsulesLoading ||
              state is CoffeeCapsulesInitial) {
            return const Scaffold(
              backgroundColor: Colors.brown,
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is CoffeeCapsulesError) {
            return Scaffold(
              body: SafeArea(
                child: Center(child: Text('Error: ${state.message}')),
              ),
            );
          }

          if (state is CoffeeCapsulesLoaded) {
            return GenericListScreen(
              title: 'Capsules Types',
              items: state.coffeeCapsulesNames,
              getImage: (capsule) => capsule.image,
              getName: (capsule) => capsule.name,
              getDescription: (capsule) => capsule.flavorProfile,
              onItemTap: (context, capsuleType) {
                context.read<CoffeeCapsulesCubit>().selectCapsule(capsuleType);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CoffeeCapsulesDetailsScreen(
                      allCapsules: state.coffeeCapsulesNames,
                      selectedCapsule: capsuleType,
                    ),
                  ),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
