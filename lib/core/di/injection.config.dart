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
import 'package:mobile_table_hopping/core/auth/token_storage.dart' as _i717;
import 'package:mobile_table_hopping/core/di/register_module.dart' as _i704;
import 'package:mobile_table_hopping/core/network/dio_client.dart' as _i737;
import 'package:mobile_table_hopping/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i930;
import 'package:mobile_table_hopping/features/auth/data/repositories/auth_repository_impl.dart'
    as _i187;
import 'package:mobile_table_hopping/features/auth/domain/repositories/auth_repository.dart'
    as _i198;
import 'package:mobile_table_hopping/features/auth/domain/usecases/get_auth_status.dart'
    as _i257;
import 'package:mobile_table_hopping/features/auth/domain/usecases/login.dart'
    as _i304;
import 'package:mobile_table_hopping/features/auth/domain/usecases/logout.dart'
    as _i252;
import 'package:mobile_table_hopping/features/auth/domain/usecases/refresh_token.dart'
    as _i1028;
import 'package:mobile_table_hopping/features/auth/domain/usecases/register.dart'
    as _i918;
import 'package:mobile_table_hopping/features/auth/presentation/bloc/auth_bloc.dart'
    as _i701;
import 'package:mobile_table_hopping/features/catalog/data/datasources/category_remote_datasource.dart'
    as _i460;
import 'package:mobile_table_hopping/features/catalog/data/datasources/game_remote_datasource.dart'
    as _i349;
import 'package:mobile_table_hopping/features/catalog/data/datasources/publication_remote_datasource.dart'
    as _i887;
import 'package:mobile_table_hopping/features/catalog/data/repositories/game_repository_impl.dart'
    as _i61;
import 'package:mobile_table_hopping/features/catalog/data/repositories/publication_repository_impl.dart'
    as _i413;
import 'package:mobile_table_hopping/features/catalog/domain/repositories/game_repository.dart'
    as _i305;
import 'package:mobile_table_hopping/features/catalog/domain/repositories/publication_repository.dart'
    as _i977;
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_categories.dart'
    as _i249;
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart'
    as _i499;
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_publications.dart'
    as _i829;
import 'package:mobile_table_hopping/features/catalog/domain/usecases/search_games.dart'
    as _i144;
import 'package:mobile_table_hopping/features/catalog/presentation/bloc/catalog_bloc.dart'
    as _i896;
import 'package:mobile_table_hopping/features/publication_details/presentation/bloc/game_reviews_bloc.dart'
    as _i643;
import 'package:mobile_table_hopping/features/publication_details/presentation/bloc/game_rules_bloc.dart'
    as _i372;
import 'package:mobile_table_hopping/features/publication_details/presentation/bloc/publication_details_bloc.dart'
    as _i828;
import 'package:mobile_table_hopping/features/publish/data/datasources/publish_remote_datasource.dart'
    as _i599;
import 'package:mobile_table_hopping/features/publish/data/repositories/publish_repository_impl.dart'
    as _i327;
import 'package:mobile_table_hopping/features/publish/domain/repositories/publish_repository.dart'
    as _i374;
import 'package:mobile_table_hopping/features/publish/domain/usecases/create_publication.dart'
    as _i692;
import 'package:mobile_table_hopping/features/publish/presentation/bloc/publish_bloc.dart'
    as _i530;
import 'package:mobile_table_hopping/features/rental/data/datasources/rental_remote_datasource.dart'
    as _i579;
import 'package:mobile_table_hopping/features/rental/data/repositories/rental_repository_impl.dart'
    as _i472;
import 'package:mobile_table_hopping/features/rental/domain/repositories/rental_repository.dart'
    as _i996;
import 'package:mobile_table_hopping/features/rental/domain/usecases/confirm_rental.dart'
    as _i649;
import 'package:mobile_table_hopping/features/rental/presentation/bloc/rental_bloc.dart'
    as _i675;
import 'package:mobile_table_hopping/features/user_profile/presentation/bloc/user_profile_bloc.dart'
    as _i809;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i717.TokenStorage>(
        () => registerModule.tokenStorage(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i737.DioClient>(
        () => _i737.DioClient(gh<_i717.TokenStorage>()));
    gh.lazySingleton<_i599.PublishRemoteDatasource>(
        () => _i599.PublishRemoteDatasourceImpl(gh<_i737.DioClient>()));
    gh.lazySingleton<_i887.PublicationRemoteDatasource>(
        () => _i887.PublicationRemoteDatasourceImpl(gh<_i737.DioClient>()));
    gh.lazySingleton<_i579.RentalRemoteDatasource>(
        () => _i579.RentalRemoteDatasourceImpl(gh<_i737.DioClient>()));
    gh.lazySingleton<_i930.AuthRemoteDatasource>(
        () => _i930.AuthRemoteDatasourceImpl(gh<_i737.DioClient>()));
    gh.lazySingleton<_i374.PublishRepository>(
        () => _i327.PublishRepositoryImpl(gh<_i599.PublishRemoteDatasource>()));
    gh.lazySingleton<_i977.PublicationRepository>(() =>
        _i413.PublicationRepositoryImpl(
            gh<_i887.PublicationRemoteDatasource>()));
    gh.lazySingleton<_i460.CategoryRemoteDatasource>(
        () => _i460.CategoryRemoteDatasourceImpl(gh<_i737.DioClient>()));
    gh.lazySingleton<_i349.GameRemoteDatasource>(
        () => _i349.GameRemoteDatasourceImpl(gh<_i737.DioClient>()));
    gh.lazySingleton<_i305.GameRepository>(() => _i61.GameRepositoryImpl(
          gh<_i349.GameRemoteDatasource>(),
          gh<_i460.CategoryRemoteDatasource>(),
        ));
    gh.lazySingleton<_i996.RentalRepository>(
        () => _i472.RentalRepositoryImpl(gh<_i579.RentalRemoteDatasource>()));
    gh.lazySingleton<_i198.AuthRepository>(() => _i187.AuthRepositoryImpl(
          gh<_i930.AuthRemoteDatasource>(),
          gh<_i717.TokenStorage>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.factory<_i692.CreatePublication>(
        () => _i692.CreatePublication(gh<_i374.PublishRepository>()));
    gh.factory<_i257.GetAuthStatus>(
        () => _i257.GetAuthStatus(gh<_i198.AuthRepository>()));
    gh.factory<_i304.Login>(() => _i304.Login(gh<_i198.AuthRepository>()));
    gh.factory<_i252.Logout>(() => _i252.Logout(gh<_i198.AuthRepository>()));
    gh.factory<_i1028.RefreshToken>(
        () => _i1028.RefreshToken(gh<_i198.AuthRepository>()));
    gh.factory<_i918.Register>(
        () => _i918.Register(gh<_i198.AuthRepository>()));
    gh.lazySingleton<_i701.AuthBloc>(() => _i701.AuthBloc(
          getAuthStatus: gh<_i257.GetAuthStatus>(),
          login: gh<_i304.Login>(),
          register: gh<_i918.Register>(),
          logout: gh<_i252.Logout>(),
          refreshToken: gh<_i1028.RefreshToken>(),
        ));
    gh.factory<_i829.GetPublications>(
        () => _i829.GetPublications(gh<_i977.PublicationRepository>()));
    gh.factory<_i249.GetCategories>(
        () => _i249.GetCategories(gh<_i305.GameRepository>()));
    gh.factory<_i249.GetFilterShortcuts>(
        () => _i249.GetFilterShortcuts(gh<_i305.GameRepository>()));
    gh.factory<_i499.GetGames>(
        () => _i499.GetGames(gh<_i305.GameRepository>()));
    gh.factory<_i144.SearchGames>(
        () => _i144.SearchGames(gh<_i305.GameRepository>()));
    gh.factory<_i828.PublicationDetailsBloc>(() => _i828.PublicationDetailsBloc(
          getPublications: gh<_i829.GetPublications>(),
          getGames: gh<_i499.GetGames>(),
        ));
    gh.factory<_i530.PublishBloc>(() => _i530.PublishBloc(
          createPublication: gh<_i692.CreatePublication>(),
          authBloc: gh<_i701.AuthBloc>(),
        ));
    gh.factory<_i649.ConfirmRental>(
        () => _i649.ConfirmRental(gh<_i996.RentalRepository>()));
    gh.factory<_i896.CatalogBloc>(() => _i896.CatalogBloc(
          getGames: gh<_i499.GetGames>(),
          getPublications: gh<_i829.GetPublications>(),
        ));
    gh.factory<_i643.GameReviewsBloc>(
        () => _i643.GameReviewsBloc(getGames: gh<_i499.GetGames>()));
    gh.factory<_i372.GameRulesBloc>(
        () => _i372.GameRulesBloc(getGames: gh<_i499.GetGames>()));
    gh.factory<_i809.UserProfileBloc>(
        () => _i809.UserProfileBloc(getGames: gh<_i499.GetGames>()));
    gh.factory<_i675.RentalBloc>(() => _i675.RentalBloc(
          getPublications: gh<_i829.GetPublications>(),
          confirmRental: gh<_i649.ConfirmRental>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i704.RegisterModule {}
