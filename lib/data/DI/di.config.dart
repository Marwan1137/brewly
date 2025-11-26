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
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/repositories/coffee_beans_types_repo.dart' as _i785;
import '../../domain/repositories/coffee_capsules_repo.dart' as _i430;
import '../../domain/repositories/equpment_repo.dart' as _i714;
import '../../domain/repositories/explore_tab_repo.dart' as _i151;
import '../../domain/repositories/favourites_repo.dart' as _i626;
import '../../domain/repositories/home_repo.dart' as _i238;
import '../../domain/repositories/quiz_repo.dart' as _i12;
import '../../Presentation/Screens/auth/logic/cubit/auth_cubit.dart' as _i664;
import '../../Presentation/Screens/coffee_beans/logic/cubit/coffee_beans_types_cubit.dart'
    as _i213;
import '../../Presentation/Screens/coffee_capsules/logic/cubit/coffee_capsules_cubit.dart'
    as _i956;
import '../../Presentation/Screens/equipment/logic/cubit/equipment_cubit.dart'
    as _i184;
import '../../Presentation/Screens/explore_tab/logic/cubit/explore_tab_cubit.dart'
    as _i145;
import '../../Presentation/Screens/favourites/logic/cubit/favourites_cubit.dart'
    as _i477;
import '../../Presentation/Screens/home_screen/logic/cubit/home_cubit.dart'
    as _i239;
import '../../Presentation/Screens/quiz/logic/quiz_cubit.dart' as _i561;
import '../repo_impl/auth_repository_impl.dart' as _i184;
import '../repo_impl/coffee_beans_types.dart' as _i555;
import '../repo_impl/coffee_capsules_repo_impl.dart' as _i326;
import '../repo_impl/equipment_repo_impl.dart' as _i817;
import '../repo_impl/explore_tab_repo_impl.dart' as _i368;
import '../repo_impl/favourites_repo_impl.dart' as _i590;
import '../repo_impl/home_repo_impl.dart' as _i116;
import '../repo_impl/quiz_repo_impl.dart' as _i643;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.lazySingleton<_i785.CoffeeBeansTypesRepo>(
      () => _i555.CoffeeDetailsRepoImpl(),
    );
    gh.lazySingleton<_i151.ExploreTabRepo>(() => _i368.ExploreTabRepoImpl());
    gh.lazySingleton<_i714.EquipmentRepo>(() => _i817.EquipmentRepoImpl());
    gh.lazySingleton<_i238.HomeRepo>(() => _i116.HomeRepositoryImpl());
    gh.lazySingleton<_i430.CoffeeCapsulesRepo>(
      () => _i326.CoffeeCapsulesRepoImpl(),
    );
    gh.lazySingleton<_i626.FavoritesRepo>(
      () => _i590.FavoritesRepoImpl(
        gh<_i460.SharedPreferences>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.factory<_i239.HomeCubit>(
      () => _i239.HomeCubit(hrepo: gh<_i238.HomeRepo>()),
    );
    gh.lazySingleton<_i12.QuizRepo>(
      () => _i643.QuizRepoImpl(
        gh<_i460.SharedPreferences>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.factory<_i477.FavoritesCubit>(
      () => _i477.FavoritesCubit(gh<_i626.FavoritesRepo>()),
    );
    gh.lazySingleton<_i1073.AuthRepository>(
      () => _i184.AuthRepositoryImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i145.ExploreTabCubit>(
      () => _i145.ExploreTabCubit(explore: gh<_i151.ExploreTabRepo>()),
    );
    gh.factory<_i184.EquipmentCubit>(
      () => _i184.EquipmentCubit(equipmentRepo: gh<_i714.EquipmentRepo>()),
    );
    gh.factory<_i956.CoffeeCapsulesCubit>(
      () => _i956.CoffeeCapsulesCubit(
        capsulesRepo: gh<_i430.CoffeeCapsulesRepo>(),
      ),
    );
    gh.factory<_i664.AuthCubit>(
      () => _i664.AuthCubit(gh<_i1073.AuthRepository>()),
    );
    gh.factory<_i213.CoffeeBeansTypesCubit>(
      () => _i213.CoffeeBeansTypesCubit(
        beansTypesRepo: gh<_i785.CoffeeBeansTypesRepo>(),
        quizRepo: gh<_i12.QuizRepo>(),
      ),
    );
    gh.factory<_i561.QuizCubit>(() => _i561.QuizCubit(gh<_i12.QuizRepo>()));
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
