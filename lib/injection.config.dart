// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cinema/src/base/sqfite/favorite_table.dart' as _i6;
import 'package:cinema/src/base/sqfite/movie_progress_table.dart' as _i8;
import 'package:cinema/src/base/sqfite/sqlfile_helper.dart' as _i35;
import 'package:cinema/src/data/datasources/local/detail_movie/detail_movie_local_data_source.dart'
    as _i16;
import 'package:cinema/src/data/datasources/local/home/home_movie_local_data_source.dart'
    as _i23;
import 'package:cinema/src/data/datasources/remote/detail_movie_remote_data_source.dart'
    as _i4;
import 'package:cinema/src/data/datasources/remote/home_remote_data_source.dart'
    as _i7;
import 'package:cinema/src/data/datasources/remote/search_movie_remote_data_srource.dart'
    as _i9;
import 'package:cinema/src/data/datasources/remote/watch_movie_remote_data_source.dart'
    as _i13;
import 'package:cinema/src/data/repositories/detail_movie_repository.dart'
    as _i17;
import 'package:cinema/src/data/repositories/detail_movie_repository_impl.dart'
    as _i18;
import 'package:cinema/src/data/repositories/home_remote_repository.dart'
    as _i24;
import 'package:cinema/src/data/repositories/home_remote_repository_impl.dart'
    as _i25;
import 'package:cinema/src/data/repositories/search/search_movie_repository.dart'
    as _i10;
import 'package:cinema/src/data/repositories/search/search_movie_repository_impl.dart'
    as _i11;
import 'package:cinema/src/data/repositories/watching/watch_movie_repository.dart'
    as _i14;
import 'package:cinema/src/data/repositories/watching/watch_movie_repository_impl.dart'
    as _i15;
import 'package:cinema/src/domain/use_cases/detail/get_detail_movie_use_case.dart'
    as _i21;
import 'package:cinema/src/domain/use_cases/detail/get_watch_movie_use_case.dart'
    as _i22;
import 'package:cinema/src/domain/use_cases/favorite/add_favorite_movie_use_case.dart'
    as _i29;
import 'package:cinema/src/domain/use_cases/favorite/find_favorite_movie_use_case.dart'
    as _i19;
import 'package:cinema/src/domain/use_cases/favorite/get_all_movie_favorite_use_case.dart'
    as _i20;
import 'package:cinema/src/domain/use_cases/favorite/remove_favorite_movie_use_case.dart'
    as _i26;
import 'package:cinema/src/domain/use_cases/home/find_movie_progress_use_case.dart'
    as _i30;
import 'package:cinema/src/domain/use_cases/home/get_all_movie_progress_use_case.dart'
    as _i31;
import 'package:cinema/src/domain/use_cases/home/get_movies_recent_show_use_case.dart'
    as _i32;
import 'package:cinema/src/domain/use_cases/home/get_movies_recent_use_case.dart'
    as _i33;
import 'package:cinema/src/domain/use_cases/home/get_trending_movies_use_case.dart'
    as _i34;
import 'package:cinema/src/domain/use_cases/home/save_movie_progress_use_case.dart'
    as _i27;
import 'package:cinema/src/domain/use_cases/home/search_movie_use_case.dart'
    as _i12;
import 'package:cinema/src/domain/use_cases/home/update_movie_progress_use_case.dart'
    as _i28;
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
    gh.singleton<_i8.MovieProgressTable>(
        _i8.MovieProgressTable(gh<_i3.Database>()));
    gh.singleton<_i9.SearchMovieRemoteDataSource>(
        _i9.SearchMovieRemoteDataSource(
      gh<_i5.Dio>(),
      baseUrl: gh<String>(instanceName: 'baseUrl'),
    ));
    gh.singleton<_i10.SearchMovieRepository>(
        _i11.SearchMovieRepositoryImpl(gh<_i9.SearchMovieRemoteDataSource>()));
    gh.singleton<_i12.SearchMovieUseCase>(
        _i12.SearchMovieUseCase(gh<_i10.SearchMovieRepository>()));
    gh.singleton<_i13.WatchMovieRemoteDataSource>(
        _i13.WatchMovieRemoteDataSource(
      gh<_i5.Dio>(),
      baseUrl: gh<String>(instanceName: 'baseUrl'),
    ));
    gh.singleton<_i14.WatchMovieRepository>(
        _i15.WatchMovieRepositoryImpl(gh<_i13.WatchMovieRemoteDataSource>()));
    gh.singleton<_i16.DetailMovieLocalDataSource>(
        _i16.DetailMovieLocalDataSource(gh<_i6.FavoriteTable>()));
    gh.singleton<_i17.DetailMovieRepository>(_i18.DetailMovieRepositoryImpl(
      gh<_i4.DetailMovieRemoteDataSource>(),
      gh<_i16.DetailMovieLocalDataSource>(),
    ));
    gh.singleton<_i19.FindFavoriteMovieUseCase>(
        _i19.FindFavoriteMovieUseCase(gh<_i17.DetailMovieRepository>()));
    gh.singleton<_i20.GetAllMovieFavoriteUseCase>(
        _i20.GetAllMovieFavoriteUseCase(gh<_i17.DetailMovieRepository>()));
    gh.singleton<_i21.GetDetailMovieUseCase>(
        _i21.GetDetailMovieUseCase(gh<_i17.DetailMovieRepository>()));
    gh.singleton<_i22.GetWatchMovieUseCase>(
        _i22.GetWatchMovieUseCase(gh<_i14.WatchMovieRepository>()));
    gh.singleton<_i23.HomeMovieLocalDataSource>(
        _i23.HomeMovieLocalDataSource(gh<_i8.MovieProgressTable>()));
    gh.singleton<_i24.HomeRemoteRepository>(_i25.HomeRemoteRepositoryImpl(
      gh<_i7.HomeRemoteDataSource>(),
      gh<_i23.HomeMovieLocalDataSource>(),
    ));
    gh.singleton<_i26.RemoveFavoriteMovieUseCase>(
        _i26.RemoveFavoriteMovieUseCase(gh<_i17.DetailMovieRepository>()));
    gh.singleton<_i27.SaveMovieProgressUseCase>(
        _i27.SaveMovieProgressUseCase(gh<_i24.HomeRemoteRepository>()));
    gh.singleton<_i28.UpdateMovieProgressUseCase>(
        _i28.UpdateMovieProgressUseCase(gh<_i24.HomeRemoteRepository>()));
    gh.singleton<_i29.AddFavoriteMovieUseCase>(
        _i29.AddFavoriteMovieUseCase(gh<_i17.DetailMovieRepository>()));
    gh.singleton<_i30.FindMovieProgressUseCase>(
        _i30.FindMovieProgressUseCase(gh<_i24.HomeRemoteRepository>()));
    gh.singleton<_i31.GetAllMovieProgressUseCase>(
        _i31.GetAllMovieProgressUseCase(gh<_i24.HomeRemoteRepository>()));
    gh.singleton<_i32.GetMoviesRecentShowUseCase>(
        _i32.GetMoviesRecentShowUseCase(gh<_i24.HomeRemoteRepository>()));
    gh.singleton<_i33.GetMoviesRecentUseCase>(
        _i33.GetMoviesRecentUseCase(gh<_i24.HomeRemoteRepository>()));
    gh.singleton<_i34.GetTrendingMoviesUseCase>(
        _i34.GetTrendingMoviesUseCase(gh<_i24.HomeRemoteRepository>()));
    return this;
  }
}

class _$SqlFileHelper extends _i35.SqlFileHelper {}
