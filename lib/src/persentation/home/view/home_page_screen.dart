import 'package:cinema/src/persentation/home/widgets/movie_progress_list_view.dart';
import 'package:cinema/src/persentation/home/widgets/movies_recent_list_view.dart';
import 'package:cinema/src/persentation/home/widgets/movies_recent_show_list_view.dart';
import 'package:cinema/src/persentation/home/widgets/upcomming_image.dart';
import 'package:cinema/src/persentation/home/widgets/upcomming_text.dart';
import 'package:flutter/material.dart';

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
    super.initState();
    pageController =
        PageController(initialPage: 0, viewportFraction: viewportFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController!.page;
            });
          });
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
              const MovieProgressListView(),
              const MoviesRecentListView(),
              const MoviesRecentShowListView(),
            ],
          ),
        ),
      ),
    );
  }
}
