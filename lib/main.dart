import 'package:brewly/Screens/coffee_beans_types/logic/cubit/coffee_beans_types_cubit.dart';
import 'package:brewly/data/DI/di.dart';
import 'package:brewly/domain/repositories/coffee_beans_types_repo.dart';
import 'package:brewly/navbar/logic/cubit/nav_bar_cubit.dart';
import 'package:brewly/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavBarCubit()),
        BlocProvider<CoffeeBeansTypesCubit>(
          create: (_) => CoffeeBeansTypesCubit(
            beansTypesRepo: getIt<CoffeeBeansTypesRepo>(),
          ),
        ),
      ],

      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
