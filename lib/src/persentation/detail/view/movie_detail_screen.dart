import 'package:cinema/src/base/network/apiendpoint.dart';
import 'package:cinema/src/base/network/dio_client.dart';
import 'package:cinema/src/data/datasources/remote/detail_movie_remote_data_source.dart';
import 'package:cinema/src/data/repositories/detail_movie_repository.dart';
import 'package:cinema/src/data/repositories/detail_movie_repository_impl.dart';
import 'package:cinema/src/domain/use_cases/get_detail_movie_use_case.dart';
import 'package:cinema/src/persentation/detail/bloc/detail_movie_bloc.dart';
import 'package:cinema/src/persentation/detail/widgets/build_movie_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailScreen extends StatefulWidget {
  final paramaters = {'id': "movie/watch-black-panther-ii-66672"};

  MovieDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final DetailMovieRepository _movieDetailRepository =
      DetailMovieRepositoryImpl(
          DetailMovieRemoteDataSource(DioClient.provideDioClient(), baseUrl: ApiEndPoints.baseUrl));

  @override
  Widget build(BuildContext context) {
    final modalRoute = ModalRoute.of(context)!.settings.arguments as Map;
    final id = modalRoute["id"] as String;
    final paramaters = {'id': id};

    return BlocProvider(
      create: (context) =>
          DetailMovieBloc(GetDetailMovieUseCase(_movieDetailRepository))
            ..add(DetailStarted())
            ..add(GetMovieDetail(paramaters)),
      child:  const Scaffold(
        body: SingleChildScrollView(child: SafeArea(child: BuildMovieDetail()))
      ),
    );
  }
}
