import 'package:cinema/routers.dart';
import 'package:cinema/src/base/network/apiendpoint.dart';
import 'package:cinema/src/base/network/dio_client.dart';
import 'package:cinema/src/data/datasources/remote/home_remote_data_source.dart';
import 'package:cinema/src/data/datasources/remote/search_movie_remote_data_srource.dart';
import 'package:cinema/src/data/repositories/home_remote_repository_impl.dart';
import 'package:cinema/src/data/repositories/search/search_movie_repository_impl.dart';
import 'package:cinema/src/domain/use_cases/get_movies_recent_use_case.dart';
import 'package:cinema/src/domain/use_cases/get_trending_movies_use_case.dart';
import 'package:cinema/src/domain/use_cases/search_movie_use_case.dart';
import 'package:cinema/src/persentation/detail/view/movie_detail_screen.dart';
import 'package:cinema/src/persentation/home/bloc/home_bloc.dart';
import 'package:cinema/src/persentation/home/bloc/home_event.dart';
import 'package:cinema/src/persentation/home/view/home_page_screen.dart';
import 'package:cinema/src/persentation/search/search_movie_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final HomeRemoteRepositoryImpl _homeRemoteRepository =
  HomeRemoteRepositoryImpl(HomeRemoteDataSource(
      DioClient.provideDioClient(),
      baseUrl: ApiEndPoints.baseUrl));

  final _searchRepository = SearchMovieRepositoryImpl(
      SearchMovieRemoteDataSource(DioClient.provideDioClient(),
          baseUrl: ApiEndPoints.baseUrl));

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
                GetTrendingMoviesUseCase(_homeRemoteRepository),
                GetMoviesRecentUseCase(_homeRemoteRepository))
              ..add(HomeStarted())
              ..add(HomeGetMoviesTrending())
              ..add(HomeGetMoviesRecent())),
        BlocProvider<SearchMovieBloc>(
            create: (context) =>
                SearchMovieBloc(SearchMovieUseCase(_searchRepository)))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: Routers.routes,
        initialRoute: Routers.home,
        debugShowCheckedModeBanner: false,
      ),
    );



  }
}

