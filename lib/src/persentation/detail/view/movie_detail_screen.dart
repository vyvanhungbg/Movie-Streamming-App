import 'package:cinema/src/persentation/detail/widgets/build_movie_detail.dart';
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatefulWidget {
  final paramaters = {'id': "movie/watch-black-panther-ii-66672"};

  MovieDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  /*final DetailMovieRepository _movieDetailRepository =
      DetailMovieRepositoryImpl(
          DetailMovieRemoteDataSource(DioClient.provideDioClient(), baseUrl: ApiEndPoints.baseUrl));*/

  @override
  Widget build(BuildContext context) {
    final modalRoute = ModalRoute.of(context)!.settings.arguments as Map;
    final idMovie = modalRoute["id"] as String;

    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                child: SafeArea(child: BuildMovieDetail(id: idMovie)))));
  }
}
