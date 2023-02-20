// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cinema/src/base/sqfite/favorite_table.dart' as _i6;
import 'package:cinema/src/base/sqfite/sqlfile_helper.dart' as _i29;
import 'package:cinema/src/data/datasources/local/DetailMovieLocalDataSource.dart'
    as _i17;
import 'package:cinema/src/data/datasources/remote/detail_movie_remote_data_source.dart'
    as _i4;
import 'package:cinema/src/data/datasources/remote/home_remote_data_source.dart'
    as _i7;
import 'package:cinema/src/data/datasources/remote/search_movie_remote_data_srource.dart'
    as _i10;
import 'package:cinema/src/data/datasources/remote/watch_movie_remote_data_source.dart'
    as _i14;
import 'package:cinema/src/data/repositories/detail_movie_repository.dart'
    as _i18;
import 'package:cinema/src/data/repositories/detail_movie_repository_impl.dart'
    as _i19;
import 'package:cinema/src/data/repositories/home_remote_repository.dart'
    as _i8;
import 'package:cinema/src/data/repositories/home_remote_repository_impl.dart'
    as _i9;
import 'package:cinema/src/data/repositories/search/search_movie_repository.dart'
    as _i11;
import 'package:cinema/src/data/repositories/search/search_movie_repository_impl.dart'
    as _i12;
import 'package:cinema/src/data/repositories/watching/watch_movie_repository.dart'
    as _i15;
import 'package:cinema/src/data/repositories/watching/watch_movie_repository_impl.dart'
    as _i16;
import 'package:cinema/src/domain/use_cases/add_favorite_movie_use_case.dart'
    as _i28;
import 'package:cinema/src/domain/use_cases/find_favorite_movie_use_case.dart'
    as _i20;
import 'package:cinema/src/domain/use_cases/get_all_movie_favorite_use_case.dart'
    as _i21;
import 'package:cinema/src/domain/use_cases/get_detail_movie_use_case.dart'
    as _i22;
import 'package:cinema/src/domain/use_cases/get_movies_recent_show_use_case.dart'
    as _i23;
import 'package:cinema/src/domain/use_cases/get_movies_recent_use_case.dart'
    as _i24;
import 'package:cinema/src/domain/use_cases/get_trending_movies_use_case.dart'
    as _i25;
import 'package:cinema/src/domain/use_cases/get_watch_movie_use_case.dart'
    as _i26;
import 'package:cinema/src/domain/use_cases/remove_favorite_movie_use_case.dart'
    as _i27;
import 'package:cinema/src/domain/use_cases/search_movie_use_case.dart' as _i13;
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sqflite/sqflite.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sqlFileHelper = _$SqlFileHelper();
    await gh.factoryAsync<_i3.Database>(
      () => sqlFileHelper.initDatabase(),
      preResolve: true,
    );
    gh.singleton<_i4.DetailMovieRemoteDataSource>(
        _i4.DetailMovieRemoteDataSource(
      gh<_i5.Dio>(),
      baseUrl: gh<String>(instanceName: 'baseUrl'),
    ));
    gh.singleton<_i6.FavoriteTable>(_i6.FavoriteTable(gh<_i3.Database>()));
    gh.singleton<_i7.HomeRemoteDataSource>(_i7.HomeRemoteDataSource(
      gh<_i5.Dio>(),
      baseUrl: gh<String>(instanceName: 'baseUrl'),
    ));
    gh.singleton<_i8.HomeRemoteRepository>(
        _i9.HomeRemoteRepositoryImpl(gh<_i7.HomeRemoteDataSource>()));
    gh.singleton<_i10.SearchMovieRemoteDataSource>(
        _i10.SearchMovieRemoteDataSource(
      gh<_i5.Dio>(),
      baseUrl: gh<String>(instanceName: 'baseUrl'),
    ));
    gh.singleton<_i11.SearchMovieRepository>(
        _i12.SearchMovieRepositoryImpl(gh<_i10.SearchMovieRemoteDataSource>()));
    gh.singleton<_i13.SearchMovieUseCase>(
        _i13.SearchMovieUseCase(gh<_i11.SearchMovieRepository>()));
    gh.singleton<_i14.WatchMovieRemoteDataSource>(
        _i14.WatchMovieRemoteDataSource(
      gh<_i5.Dio>(),
      baseUrl: gh<String>(instanceName: 'baseUrl'),
    ));
    gh.singleton<_i15.WatchMovieRepository>(
        _i16.WatchMovieRepositoryImpl(gh<_i14.WatchMovieRemoteDataSource>()));
    gh.singleton<_i17.DetailMovieLocalDataSource>(
        _i17.DetailMovieLocalDataSource(gh<_i6.FavoriteTable>()));
    gh.singleton<_i18.DetailMovieRepository>(_i19.DetailMovieRepositoryImpl(
      gh<_i4.DetailMovieRemoteDataSource>(),
      gh<_i17.DetailMovieLocalDataSource>(),
    ));
    gh.singleton<_i20.FindFavoriteMovieUseCase>(
        _i20.FindFavoriteMovieUseCase(gh<_i18.DetailMovieRepository>()));
    gh.singleton<_i21.GetAllMovieFavoriteUseCase>(
        _i21.GetAllMovieFavoriteUseCase(gh<_i18.DetailMovieRepository>()));
    gh.singleton<_i22.GetDetailMovieUseCase>(
        _i22.GetDetailMovieUseCase(gh<_i18.DetailMovieRepository>()));
    gh.singleton<_i23.GetMoviesRecentShowUseCase>(
        _i23.GetMoviesRecentShowUseCase(gh<_i8.HomeRemoteRepository>()));
    gh.singleton<_i24.GetMoviesRecentUseCase>(
        _i24.GetMoviesRecentUseCase(gh<_i8.HomeRemoteRepository>()));
    gh.singleton<_i25.GetTrendingMoviesUseCase>(
        _i25.GetTrendingMoviesUseCase(gh<_i8.HomeRemoteRepository>()));
    gh.singleton<_i26.GetWatchMovieUseCase>(
        _i26.GetWatchMovieUseCase(gh<_i15.WatchMovieRepository>()));
    gh.singleton<_i27.RemoveFavoriteMovieUseCase>(
        _i27.RemoveFavoriteMovieUseCase(gh<_i18.DetailMovieRepository>()));
    gh.singleton<_i28.AddFavoriteMovieUseCase>(
        _i28.AddFavoriteMovieUseCase(gh<_i18.DetailMovieRepository>()));
    return this;
  }
}

class _$SqlFileHelper extends _i29.SqlFileHelper {}
