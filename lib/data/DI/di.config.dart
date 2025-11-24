// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../domain/repositories/coffee_beans_types_repo.dart' as _i785;
import '../../domain/repositories/coffee_capsules_repo.dart' as _i430;
import '../../domain/repositories/equpment_repo.dart' as _i714;
import '../../domain/repositories/explore_tab_repo.dart' as _i151;
import '../../domain/repositories/favourites_repo.dart' as _i626;
import '../../domain/repositories/home_repo.dart' as _i238;
import '../../Screens/coffee_beans/logic/cubit/coffee_beans_types_cubit.dart'
    as _i63;
import '../../Screens/coffee_capsules/logic/cubit/coffee_capsules_cubit.dart'
    as _i697;
import '../../Screens/equipment/logic/cubit/equipment_cubit.dart' as _i956;
import '../../Screens/explore_tab/logic/cubit/explore_tab_cubit.dart' as _i907;
import '../../Screens/favourites/logic/cubit/favourites_cubit.dart' as _i900;
import '../../Screens/home_screen/logic/cubit/home_cubit.dart' as _i14;
import '../repo_impl/coffee_beans_types.dart' as _i555;
import '../repo_impl/coffee_capsules_repo_impl.dart' as _i326;
import '../repo_impl/equipment_repo_impl.dart' as _i817;
import '../repo_impl/explore_tab_repo_impl.dart' as _i368;
import '../repo_impl/favourites_repo_impl.dart' as _i590;
import '../repo_impl/home_repo_impl.dart' as _i116;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i785.CoffeeBeansTypesRepo>(
      () => _i555.CoffeeDetailsRepoImpl(),
    );
    gh.factory<_i63.CoffeeBeansTypesCubit>(
      () => _i63.CoffeeBeansTypesCubit(
        beansTypesRepo: gh<_i785.CoffeeBeansTypesRepo>(),
      ),
    );
    gh.lazySingleton<_i151.ExploreTabRepo>(() => _i368.ExploreTabRepoImpl());
    gh.lazySingleton<_i714.EquipmentRepo>(() => _i817.EquipmentRepoImpl());
    gh.lazySingleton<_i238.HomeRepo>(() => _i116.HomeRepositoryImpl());
    gh.lazySingleton<_i626.FavoritesRepo>(
      () => _i590.FavoritesRepoImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i430.CoffeeCapsulesRepo>(
      () => _i326.CoffeeCapsulesRepoImpl(),
    );
    gh.factory<_i14.HomeCubit>(
      () => _i14.HomeCubit(hrepo: gh<_i238.HomeRepo>()),
    );
    gh.factory<_i900.FavoritesCubit>(
      () => _i900.FavoritesCubit(gh<_i626.FavoritesRepo>()),
    );
    gh.factory<_i907.ExploreTabCubit>(
      () => _i907.ExploreTabCubit(explore: gh<_i151.ExploreTabRepo>()),
    );
    gh.factory<_i956.EquipmentCubit>(
      () => _i956.EquipmentCubit(equipmentRepo: gh<_i714.EquipmentRepo>()),
    );
    gh.factory<_i697.CoffeeCapsulesCubit>(
      () => _i697.CoffeeCapsulesCubit(
        capsulesRepo: gh<_i430.CoffeeCapsulesRepo>(),
      ),
    );
    return this;
  }
}
