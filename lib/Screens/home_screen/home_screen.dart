// presentation/home/home_screen.dart
import 'package:brewly/Screens/home_screen/sections/appbar.dart';
import 'package:brewly/Screens/home_screen/sections/categories_section.dart';
import 'package:brewly/Screens/home_screen/sections/featured_section.dart';
import 'package:brewly/Screens/home_screen/sections/greeting_section.dart';
import 'package:brewly/Screens/home_screen/sections/quick_brew_section.dart';
import 'package:brewly/Screens/home_screen/sections/recommended_section.dart';
import 'package:brewly/data/DI/di.dart'; // getIt
import 'package:brewly/Screens/home_screen/logic/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..loadHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const Scaffold(
              backgroundColor: Colors.brown,
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is HomeError) {
            return Scaffold(
              body: SafeArea(
                child: Center(child: Text('Error: ${state.message}')),
              ),
            );
          }

          if (state is HomeLoaded) {
            final featured = state.featuredCoffees;
            final recommended = state.recommendedCoffees;
            final tips = state.quickBrewTips;
            final categories = state.categories;

            return Scaffold(
              appBar: const CustomAppBar(),
              backgroundColor: Colors.brown[50],
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: ListView(
                    children: [
                      const SizedBox(height: 10),

                      /* -------------------------------------------------------------------------- */
                      /*                              Greeting Section                              */
                      /* -------------------------------------------------------------------------- */
                      GreetingSection(),

                      const SizedBox(height: 10),

                      /* -------------------------------------------------------------------------- */
                      /*                              Featured Section                              */
                      /* -------------------------------------------------------------------------- */
                      Text(
                            'Featured Coffee of the Week',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 400.ms, duration: 500.ms)
                          .slideY(begin: 0.1, end: 0),

                      const SizedBox(height: 5),

                      FeaturedCoffeeCard(coffee: featured),

                      /* -------------------------------------------------------------------------- */
                      const SizedBox(height: 15),

                      /* -------------------------------------------------------------------------- */
                      /*                             Quick Brew Section                             */
                      /* -------------------------------------------------------------------------- */
                      Text(
                            'Quick Brew Tips',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 800.ms, duration: 600.ms)
                          .slideY(begin: 0.1, end: 0),
                      const SizedBox(height: 10),

                      ...tips.map((tip) => QuickBrewTipCard(tip: tip)),

                      /* -------------------------------------------------------------------------- */
                      const SizedBox(height: 10),

                      /* -------------------------------------------------------------------------- */
                      /*                             Categories Section                             */
                      /* -------------------------------------------------------------------------- */
                      Text(
                            'Explore Categories',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 1000.ms, duration: 600.ms)
                          .slideY(begin: 0.1, end: 0),
                      const SizedBox(height: 10),

                      SizedBox(
                        height: 100,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 20),
                          itemBuilder: (context, index) {
                            return CategoryCard(category: categories[index]);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      /* -------------------------------------------------------------------------- */
                      /* -------------------------------------------------------------------------- */
                      /*                         Recommended for You Section                        */
                      /* -------------------------------------------------------------------------- */
                      const Text(
                        'Recommended for You',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      ...recommended.map((rec) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: RecommendedCoffeeCard(recommended: rec),
                        );
                      }),
                      const SizedBox(height: 40),
                      /* -------------------------------------------------------------------------- */
                    ],
                  ),
                ),
              ),
            );
          }

          // fallback
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
