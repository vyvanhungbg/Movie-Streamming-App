import 'package:cinema/src/base/network/apiendpoint.dart';
import 'package:cinema/src/base/network/dio_client.dart';
import 'package:cinema/src/data/datasources/remote/home_remote_data_source.dart';
import 'package:cinema/src/data/datasources/remote/search_movie_remote_data_srource.dart';
import 'package:cinema/src/data/repositories/home_remote_repository_impl.dart';
import 'package:cinema/src/data/repositories/search/search_movie_repository_impl.dart';
import 'package:cinema/src/domain/use_cases/get_movies_recent_use_case.dart';
import 'package:cinema/src/domain/use_cases/get_trending_movies_use_case.dart';
import 'package:cinema/src/persentation/home/bloc/home_bloc.dart';
import 'package:cinema/src/persentation/home/bloc/home_event.dart';
import 'package:cinema/src/persentation/home/helper/custom_search_delegate.dart';
import 'package:cinema/src/persentation/home/widgets/movies_recent_list_view.dart';
import 'package:cinema/src/persentation/home/widgets/upcomming_image.dart';
import 'package:cinema/src/persentation/home/widgets/upcomming_text.dart';
import 'package:cinema/src/persentation/search/search_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/search_movie_use_case.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageScreenState();
  }
}

class _HomePageScreenState extends State<HomePageScreen> {

  PageController? pageController;
  double viewportFraction = 0.8;
  double? pageOffset = 0;

  @override
  void initState() {
    pageController =
        PageController(initialPage: 0, viewportFraction: viewportFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController!.page;
            });
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UpcomingSliderImage(
                  pageController: pageController!,
                  viewportFraction: viewportFraction,
                  pageOffset: pageOffset),
              UpcomingText(pageOffset: pageOffset),
              MoviesRecentListView(),
            ],
          ),
        ),
      ),
    );
  }
}
