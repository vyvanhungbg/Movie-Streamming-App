import 'dart:io';

import 'package:cinema/l10n/l10n.dart';
import 'package:cinema/routers.dart';
import 'package:cinema/src/base/network/dio_client.dart';
import 'package:cinema/src/persentation/detail/bloc/detail_movie_bloc.dart';
import 'package:cinema/src/persentation/favorite/bloc/favorite_movie_bloc.dart';
import 'package:cinema/src/persentation/home/bloc/home_bloc.dart';
import 'package:cinema/src/persentation/home/bloc/home_event.dart';
import 'package:cinema/src/persentation/search/search_movie_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'firebase_options.dart';
import 'injection.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  HttpOverrides.global = MyHttpOverrides();
  await configureDependencies();
  await getIt.allReady();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // bool check = checkExperiod(32);
  bool check = false;
  FlutterNativeSplash.remove();
  if (!check) {
    runApp(MyApp());
  } else {
    runApp(BlockScreen());
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
                  getIt.get(),
                  getIt.get(),
                  getIt.get(),
                  getIt.get(),
                  getIt.get(),
                  getIt.get(),
                  getIt.get(),
                )
                  ..add(HomeStarted())
                  ..add(HomeGetMoviesTrending())
                  ..add(HomeGetMoviesRecent())
                  ..add(HomeGetMoviesRecentShow())),
        BlocProvider<SearchMovieBloc>(
            create: (context) => SearchMovieBloc(getIt.get())),
        BlocProvider<FavoriteMovieBloc>(
            create: (context) => FavoriteMovieBloc(getIt.get())
              ..add(FavoriteMovieStaredEvent())
              ..add(FavoriteMovieGetMovieFavoriteEvent())),
        BlocProvider<DetailMovieBloc>(
            create: (context) => DetailMovieBloc(
                getIt.get(), getIt.get(), getIt.get(), getIt.get())
              ..add(DetailStarted())),
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
        initialRoute: Routers.main_page,
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
