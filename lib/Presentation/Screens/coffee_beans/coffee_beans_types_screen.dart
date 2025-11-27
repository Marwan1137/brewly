import 'package:brewly/Presentation/Screens/coffee_beans/logic/cubit/coffee_beans_types_cubit.dart';
import 'package:brewly/Presentation/Screens/coffee_beans/coffee_details_screen.dart';
import 'package:brewly/Presentation/Screens/favourites/logic/cubit/favourites_cubit.dart';
import 'package:brewly/Presentation/Screens/widgets/coffee_item_card.dart';
import 'package:brewly/data/DI/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeBeansTypesScreen extends StatelessWidget {
  const CoffeeBeansTypesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<CoffeeBeansTypesCubit>()..loadCoffeeTypes(),
        ),
        BlocProvider(create: (_) => getIt<FavoritesCubit>()),
      ],
      child: BlocBuilder<CoffeeBeansTypesCubit, CoffeeBeansTypesState>(
        builder: (context, state) {
          if (state is CoffeeBeanTypesLoading ||
              state is CoffeeBeansTypesInitial) {
            return const Scaffold(
              backgroundColor: Colors.brown,
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is CoffeeBeansTypesError) {
            return Scaffold(
              body: SafeArea(
                child: Center(child: Text('Error: ${state.message}')),
              ),
            );
          }

          if (state is CoffeeBeansTypesLoaded) {
            return GenericListScreen(
              title: 'Coffee Beans Types',
              items: state.coffeeBeansTypes,
              itemType: 'bean',
              getImage: (bean) => bean.image,
              getName: (bean) => bean.name,
              getDescription: (bean) => bean.description,
              onItemTap: (context, beanType) {
                context.read<CoffeeBeansTypesCubit>().selectCoffee(beanType);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CoffeeDetailsScreen(
                      selectedCoffee: beanType,
                      allCoffees: state.coffeeBeansTypes,
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
