import 'package:cinema/src/persentation/detail/view/movie_detail_screen.dart';
import 'package:cinema/src/persentation/home/view/home_page_screen.dart';
import 'package:flutter/material.dart';

class Routers {
  Routers._();
  static const String detail = '/movie_detail';
  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    detail: (context) =>  MovieDetailScreen(),
    home: (context) => const HomePageScreen(),
  };
}