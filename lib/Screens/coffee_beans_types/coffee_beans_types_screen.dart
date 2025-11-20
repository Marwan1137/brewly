import 'package:brewly/Screens/coffee_beans_types/logic/cubit/coffee_beans_types_cubit.dart';
import 'package:brewly/Screens/coffee_details_screen/coffee_details_screen.dart';
import 'package:brewly/data/DI/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeBeansTypesScreen extends StatelessWidget {
  const CoffeeBeansTypesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CoffeeBeansTypesCubit>()..loadCoffeeTypes(),
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
            final coffeetypes = state.coffeeBeansTypes;
            return Scaffold(
              backgroundColor: Colors.brown[50],
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.brown[50],
                surfaceTintColor: Colors.brown[50],
                title: Text(
                  'Coffee Beans Types',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              body: Padding(
                padding: EdgeInsetsGeometry.all(20),
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 15),
                  itemCount: state.coffeeBeansTypes.length,
                  itemBuilder: (context, index) {
                    final beanType = coffeetypes[index];
                    return GestureDetector(
                      onTap: () {
                        context.read<CoffeeBeansTypesCubit>().selectCoffee(
                          beanType,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CoffeeDetailsScreen(
                              selectedCoffee: beanType,
                              allCoffees: coffeetypes,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white10,
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                beanType.image,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        beanType.name,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        beanType.description,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ).animate().flip(
                                    delay: 1000.ms,
                                    duration: 600.ms,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).animate().flip(delay: 800.ms, duration: 900.ms),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
