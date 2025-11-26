import 'package:brewly/Presentation/Screens/explore_tab/country_details_screen.dart';
import 'package:brewly/Presentation/Screens/explore_tab/logic/cubit/explore_tab_cubit.dart';
import 'package:brewly/Presentation/Screens/favourites/logic/cubit/favourites_cubit.dart';
import 'package:brewly/Presentation/Screens/widgets/coffee_item_card.dart';
import 'package:brewly/data/DI/di.dart';
import 'package:brewly/domain/entities/country_coffee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ExploreTabCubit>()..loadExploreData(),
        ),
        BlocProvider(create: (_) => getIt<FavoritesCubit>()),
      ],
      child: BlocBuilder<ExploreTabCubit, ExploreTabState>(
        builder: (context, state) {
          if (state is ExploreTabInitial || state is ExploreTabLoading) {
            return const Scaffold(
              backgroundColor: Colors.brown,
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is ExploreTabError) {
            return Scaffold(
              body: SafeArea(
                child: Center(child: Text('Error: ${state.message}')),
              ),
            );
          }
          if (state is ExploreTabLoaded) {
            return GenericListScreen<CountryCoffee>(
              title: 'Explore Coffees by Country',
              items: state.countryCoffee,
              itemType: 'country',
              getImage: (country) => country.flag,
              getName: (country) => country.name,
              getDescription: (country) => country.flavorProfile,
              onItemTap: (context, country) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CountryDetailsScreen(
                      selectedCountry: country,
                      allCountries: state.countryCoffee,
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
