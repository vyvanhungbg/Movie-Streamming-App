import 'package:cinema/injection.dart';
import 'package:cinema/src/base/network/apiendpoint.dart';
import 'package:cinema/src/base/network/dio_client.dart';
import 'package:cinema/src/base/network/querymodel/watch_paramerter.dart';
import 'package:cinema/src/data/datasources/remote/watch_movie_remote_data_source.dart';
import 'package:cinema/src/data/repositories/watching/watch_movie_repository.dart';
import 'package:cinema/src/data/repositories/watching/watch_movie_repository_impl.dart';
import 'package:cinema/src/domain/use_cases/detail/get_watch_movie_use_case.dart';
import 'package:cinema/src/model/movie_detail.dart';
import 'package:cinema/src/model/movie_progress.dart';
import 'package:cinema/src/persentation/watching/bloc/watch_movie_bloc.dart';
import 'package:cinema/src/persentation/watching/widgets/better_layer_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchMovieScreen extends StatefulWidget {
  const WatchMovieScreen({super.key});

  final title = "Watch Movie";

  @override
  State<StatefulWidget> createState() {
    return _WatchMovieScreenState();
  }
}

class _WatchMovieScreenState extends State<WatchMovieScreen> {
  @override
  Widget build(BuildContext context) {
    final modalRoute = ModalRoute.of(context)!.settings.arguments as Map;
    final episodeId = modalRoute["episodeId"] as String;
    final mediaId = modalRoute["mediaId"] as String;
    final serverName = modalRoute["server"] as String;
    final MovieDetail movieDetail = modalRoute["movieDetail"] as MovieDetail;

    final watchParameter = WatchParameter(
        episodeId: episodeId, mediaId: mediaId, server: serverName);
    return Scaffold(
      body: BlocProvider(
        create: (context) => WatchMovieBloc(getIt.get(), getIt.get())
          ..add(WatchMovieStarted())
          ..add(WatchMovieGetData(watchParameter))
          ..add(GetDurationMovieProgressEvent(
              movieProgress: MovieProgress.init(idMovie: mediaId))),
        child: BetterLayerVideo(
          watchParameter: watchParameter,
          movieDetail: movieDetail,
        ),
      ),
    );
  }
}
