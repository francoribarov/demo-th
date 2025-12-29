// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import 'package:mobile_table_hopping/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i161;
import 'package:mobile_table_hopping/features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import 'package:mobile_table_hopping/features/auth/domain/repositories/auth_repository.dart'
    as _i787;
import 'package:mobile_table_hopping/features/auth/domain/usecases/get_auth_status.dart'
    as _i103;
import 'package:mobile_table_hopping/features/auth/domain/usecases/login.dart'
    as _i428;
import 'package:mobile_table_hopping/features/auth/domain/usecases/logout.dart'
    as _i597;
import 'package:mobile_table_hopping/features/auth/domain/usecases/refresh_token.dart'
    as _i209;
import 'package:mobile_table_hopping/features/auth/domain/usecases/register.dart'
    as _i480;
import 'package:mobile_table_hopping/features/auth/presentation/bloc/auth_bloc.dart'
    as _i797;
import 'package:mobile_table_hopping/features/catalog/data/datasources/category_remote_datasource.dart'
    as _i126;
import 'package:mobile_table_hopping/features/catalog/data/datasources/game_local_datasource.dart'
    as _i76;
import 'package:mobile_table_hopping/features/catalog/data/datasources/game_remote_datasource.dart'
    as _i609;
import 'package:mobile_table_hopping/features/catalog/data/repositories/game_repository_impl.dart'
    as _i816;
import 'package:mobile_table_hopping/features/catalog/domain/repositories/game_repository.dart'
    as _i842;
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_categories.dart'
    as _i363;
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart'
    as _i276;
import 'package:mobile_table_hopping/features/catalog/domain/usecases/search_games.dart'
    as _i588;
import 'package:mobile_table_hopping/features/catalog/presentation/bloc/catalog_bloc.dart'
    as _i773;
import 'package:mobile_table_hopping/features/game_details/presentation/bloc/game_details_bloc.dart'
    as _i986;
import 'package:mobile_table_hopping/features/game_details/presentation/bloc/game_reviews_bloc.dart'
    as _i478;
import 'package:mobile_table_hopping/features/game_details/presentation/bloc/game_rules_bloc.dart'
    as _i18;
import 'package:mobile_table_hopping/features/publish/data/datasources/publish_remote_datasource.dart'
    as _i263;
import 'package:mobile_table_hopping/features/publish/data/repositories/publish_repository_impl.dart'
    as _i278;
import 'package:mobile_table_hopping/features/publish/domain/repositories/publish_repository.dart'
    as _i134;
import 'package:mobile_table_hopping/features/publish/domain/usecases/create_listing.dart'
    as _i103;
import 'package:mobile_table_hopping/features/publish/presentation/bloc/publish_bloc.dart'
    as _i391;
import 'package:mobile_table_hopping/features/rental/data/repositories/rental_repository_impl.dart'
    as _i303;
import 'package:mobile_table_hopping/features/rental/domain/repositories/rental_repository.dart'
    as _i301;
import 'package:mobile_table_hopping/features/rental/domain/usecases/confirm_rental.dart'
    as _i724;
import 'package:mobile_table_hopping/features/rental/presentation/bloc/rental_bloc.dart'
    as _i851;
import 'package:mobile_table_hopping/features/user_profile/presentation/bloc/user_profile_bloc.dart'
    as _i989;
import 'package:mobile_table_hopping/core/auth/token_storage.dart' as _i1002;
import 'package:mobile_table_hopping/core/network/dio_client.dart' as _i667;
import 'package:mobile_table_hopping/core/di/register_module.dart' as _i291;

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
    gh.lazySingleton<_i1002.TokenStorage>(
      () => registerModule.tokenStorage(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i667.DioClient>(
      () => _i667.DioClient(gh<_i1002.TokenStorage>()),
    );
    gh.lazySingleton<_i76.GameLocalDatasource>(
      () => _i76.GameLocalDatasourceImpl(),
    );
    gh.lazySingleton<_i301.RentalRepository>(
      () => _i303.RentalRepositoryImpl(),
    );
    gh.lazySingleton<_i263.PublishRemoteDatasource>(
      () => _i263.PublishRemoteDatasourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i161.AuthRemoteDatasource>(
      () => _i161.AuthRemoteDatasourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i134.PublishRepository>(
      () => _i278.PublishRepositoryImpl(gh<_i263.PublishRemoteDatasource>()),
    );
    gh.lazySingleton<_i126.CategoryRemoteDatasource>(
      () => _i126.CategoryRemoteDatasourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i609.GameRemoteDatasource>(
      () => _i609.GameRemoteDatasourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i842.GameRepository>(
      () => _i816.GameRepositoryImpl(
        gh<_i609.GameRemoteDatasource>(),
        gh<_i126.CategoryRemoteDatasource>(),
      ),
    );
    gh.factory<_i724.ConfirmRental>(
      () => _i724.ConfirmRental(gh<_i301.RentalRepository>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i161.AuthRemoteDatasource>(),
        gh<_i1002.TokenStorage>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i103.CreateListing>(
      () => _i103.CreateListing(gh<_i134.PublishRepository>()),
    );
    gh.factory<_i428.Login>(() => _i428.Login(gh<_i787.AuthRepository>()));
    gh.factory<_i480.Register>(
      () => _i480.Register(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i597.Logout>(() => _i597.Logout(gh<_i787.AuthRepository>()));
    gh.factory<_i103.GetAuthStatus>(
      () => _i103.GetAuthStatus(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i209.RefreshToken>(
      () => _i209.RefreshToken(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i797.AuthBloc>(
      () => _i797.AuthBloc(
        getAuthStatus: gh<_i103.GetAuthStatus>(),
        login: gh<_i428.Login>(),
        register: gh<_i480.Register>(),
        logout: gh<_i597.Logout>(),
        refreshToken: gh<_i209.RefreshToken>(),
      ),
    );
    gh.factory<_i391.PublishBloc>(
      () => _i391.PublishBloc(createListing: gh<_i103.CreateListing>()),
    );
    gh.factory<_i588.SearchGames>(
      () => _i588.SearchGames(gh<_i842.GameRepository>()),
    );
    gh.factory<_i276.GetGames>(
      () => _i276.GetGames(gh<_i842.GameRepository>()),
    );
    gh.factory<_i363.GetCategories>(
      () => _i363.GetCategories(gh<_i842.GameRepository>()),
    );
    gh.factory<_i363.GetFilterShortcuts>(
      () => _i363.GetFilterShortcuts(gh<_i842.GameRepository>()),
    );
    gh.factory<_i773.CatalogBloc>(
      () => _i773.CatalogBloc(
        getGames: gh<_i276.GetGames>(),
        searchGames: gh<_i588.SearchGames>(),
      ),
    );
    gh.factory<_i851.RentalBloc>(
      () => _i851.RentalBloc(
        getGames: gh<_i276.GetGames>(),
        confirmRental: gh<_i724.ConfirmRental>(),
      ),
    );
    gh.factory<_i986.GameDetailsBloc>(
      () => _i986.GameDetailsBloc(getGames: gh<_i276.GetGames>()),
    );
    gh.factory<_i18.GameRulesBloc>(
      () => _i18.GameRulesBloc(getGames: gh<_i276.GetGames>()),
    );
    gh.factory<_i478.GameReviewsBloc>(
      () => _i478.GameReviewsBloc(getGames: gh<_i276.GetGames>()),
    );
    gh.factory<_i989.UserProfileBloc>(
      () => _i989.UserProfileBloc(getGames: gh<_i276.GetGames>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
