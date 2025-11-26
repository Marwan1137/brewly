import 'package:brewly/Presentation/Screens/auth/logic/cubit/auth_cubit.dart';
import 'package:brewly/Presentation/Screens/coffee_beans/logic/cubit/coffee_beans_types_cubit.dart';
import 'package:brewly/Presentation/Screens/coffee_capsules/logic/cubit/coffee_capsules_cubit.dart';
import 'package:brewly/Presentation/Screens/equipment/logic/cubit/equipment_cubit.dart';
import 'package:brewly/data/DI/di.dart';
import 'package:brewly/domain/repositories/coffee_beans_types_repo.dart';
import 'package:brewly/domain/repositories/coffee_capsules_repo.dart';
import 'package:brewly/domain/repositories/equpment_repo.dart';
import 'package:brewly/Presentation/navbar/logic/cubit/nav_bar_cubit.dart';
import 'package:brewly/Presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://faylxvnejlfgonujerfn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZheWx4dm5lamxmZ29udWplcmZuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQwOTQyMDUsImV4cCI6MjA3OTY3MDIwNX0.wX3HTuSLHPcPhbIJUqzSmAcaD2QnhuE2Txr9sou8IPg',
  );
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
        BlocProvider(create: (_) => getIt<AuthCubit>()..initialize()),
        BlocProvider(create: (_) => NavBarCubit()),
        BlocProvider<CoffeeBeansTypesCubit>(
          create: (_) => CoffeeBeansTypesCubit(
            beansTypesRepo: getIt<CoffeeBeansTypesRepo>(),
            quizRepo: getIt(),
          ),
        ),
        BlocProvider<CoffeeCapsulesCubit>(
          create: (_) =>
              CoffeeCapsulesCubit(capsulesRepo: getIt<CoffeeCapsulesRepo>()),
        ),
        BlocProvider<EquipmentCubit>(
          create: (context) =>
              EquipmentCubit(equipmentRepo: getIt<EquipmentRepo>()),
        ),
      ],

      child: MaterialApp(
        title: 'Brewly',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
