// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:brewly/data/repo_impl/coffee_beans_types.dart' as _i582;
import 'package:brewly/data/repo_impl/coffee_capsules_repo_impl.dart' as _i157;
import 'package:brewly/data/repo_impl/equipment_repo_impl.dart' as _i950;
import 'package:brewly/data/repo_impl/home_repo_impl.dart' as _i62;
import 'package:brewly/domain/repositories/coffee_beans_types_repo.dart'
    as _i339;
import 'package:brewly/domain/repositories/coffee_capsules_repo.dart' as _i1003;
import 'package:brewly/domain/repositories/equpment_repo.dart' as _i1014;
import 'package:brewly/domain/repositories/home_repo.dart' as _i292;
import 'package:brewly/Screens/coffee_beans/logic/cubit/coffee_beans_types_cubit.dart'
    as _i661;
import 'package:brewly/Screens/coffee_capsules/logic/cubit/coffee_capsules_cubit.dart'
    as _i891;
import 'package:brewly/Screens/equipment/logic/cubit/equipment_cubit.dart'
    as _i900;
import 'package:brewly/Screens/home_screen/logic/cubit/home_cubit.dart'
    as _i483;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i339.CoffeeBeansTypesRepo>(
      () => _i582.CoffeeDetailsRepoImpl(),
    );
    gh.factory<_i661.CoffeeBeansTypesCubit>(
      () => _i661.CoffeeBeansTypesCubit(
        beansTypesRepo: gh<_i339.CoffeeBeansTypesRepo>(),
      ),
    );
    gh.lazySingleton<_i1014.EquipmentRepo>(() => _i950.EquipmentRepoImpl());
    gh.lazySingleton<_i292.HomeRepo>(() => _i62.HomeRepositoryImpl());
    gh.lazySingleton<_i1003.CoffeeCapsulesRepo>(
      () => _i157.CoffeeCapsulesRepoImpl(),
    );
    gh.factory<_i483.HomeCubit>(
      () => _i483.HomeCubit(hrepo: gh<_i292.HomeRepo>()),
    );
    gh.factory<_i900.EquipmentCubit>(
      () => _i900.EquipmentCubit(equipmentRepo: gh<_i1014.EquipmentRepo>()),
    );
    gh.factory<_i891.CoffeeCapsulesCubit>(
      () => _i891.CoffeeCapsulesCubit(
        capsulesRepo: gh<_i1003.CoffeeCapsulesRepo>(),
      ),
    );
    return this;
  }
}
