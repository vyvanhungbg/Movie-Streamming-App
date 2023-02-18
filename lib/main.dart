import 'dart:io';

import 'package:cinema/l10n/l10n.dart';
import 'package:cinema/routers.dart';
import 'package:cinema/src/base/network/apiendpoint.dart';
import 'package:cinema/src/base/network/dio_client.dart';
import 'package:cinema/src/data/datasources/remote/home_remote_data_source.dart';
import 'package:cinema/src/data/datasources/remote/search_movie_remote_data_srource.dart';
import 'package:cinema/src/data/repositories/home_remote_repository_impl.dart';
import 'package:cinema/src/data/repositories/search/search_movie_repository_impl.dart';
import 'package:cinema/src/domain/use_cases/get_movies_recent_show_use_case.dart';
import 'package:cinema/src/domain/use_cases/get_movies_recent_use_case.dart';
import 'package:cinema/src/domain/use_cases/get_trending_movies_use_case.dart';
import 'package:cinema/src/domain/use_cases/search_movie_use_case.dart';
import 'package:cinema/src/persentation/home/bloc/home_bloc.dart';
import 'package:cinema/src/persentation/home/bloc/home_event.dart';
import 'package:cinema/src/persentation/search/search_movie_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // bool check = checkExperiod(32);
  bool check = false;
  if (!check) {
    runApp(MyApp());
  } else {
    runApp(BlockScreen());
  }
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
                  GetMoviesRecentUseCase(_homeRemoteRepository),
                  GetMoviesRecentShowUseCase(_homeRemoteRepository),
                )
                  ..add(HomeStarted())
                  ..add(HomeGetMoviesTrending())
                  ..add(HomeGetMoviesRecent())
                  ..add(HomeGetMoviesRecentShow())),
        BlocProvider<SearchMovieBloc>(
            create: (context) =>
                SearchMovieBloc(SearchMovieUseCase(_searchRepository)))
      ],
      child: MaterialApp(
        title: 'Cinema',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // locale: Locale.fromSubtags(languageCode: 'vi'),
        supportedLocales: L10n.all,
        routes: Routers.routes,
        initialRoute: Routers.home,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class BlockScreen extends StatelessWidget {
  const BlockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: Text(AppLocalizations.of(context)!.duration)),
      ),
    );
  }
}

bool checkExperiod(int time) {
  DateTime now = new DateTime.now();
  const timeStart = "2023-02-14 16:48:44.909750";
  final dateTimeStart = DateTime.parse(timeStart);
  debugPrint(
      'đã hết hạn_______________${now.difference(dateTimeStart).inHours} tiếng');
  debugPrint(
      'Còn dùng _______________${time - now.difference(dateTimeStart).inHours} tiếng');
  return now.difference(dateTimeStart).inHours > time;
}
