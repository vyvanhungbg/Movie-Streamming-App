import 'package:cinema/src/base/network/apiendpoint.dart';
import 'package:cinema/src/base/network/dio_client.dart';
import 'package:cinema/src/base/network/querymodel/watch_paramerter.dart';
import 'package:cinema/src/data/datasources/remote/watch_movie_remote_data_source.dart';
import 'package:cinema/src/data/repositories/watching/watch_movie_repository.dart';
import 'package:cinema/src/data/repositories/watching/watch_movie_repository_impl.dart';
import 'package:cinema/src/domain/use_cases/get_watch_movie_use_case.dart';
import 'package:cinema/src/persentation/watching/bloc/watch_movie_bloc.dart';
import 'package:cinema/src/persentation/watching/widgets/chewie_player_widget.dart';
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
  final WatchMovieRepository _watchMovieRepository = WatchMovieRepositoryImpl(
      WatchMovieRemoteDataSource(DioClient.provideDioClient(),
          baseUrl: ApiEndPoints.baseUrl));

  @override
  Widget build(BuildContext context) {
    final modalRoute = ModalRoute.of(context)!.settings.arguments as Map;
    final episodeId = modalRoute["episodeId"] as String;
    final mediaId = modalRoute["mediaId"] as String;
    final serverName = modalRoute["server"] as String;

    final watchParameter = WatchParameter(
        episodeId: episodeId, mediaId: mediaId, server: serverName);
    print("____________nhan pram");
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            WatchMovieBloc(GetWatchMovieUseCase(_watchMovieRepository))
              ..add(WatchMovieStarted())
              ..add(WatchMovieGetData(watchParameter)),
        child: ChewiePlayerWidget(watchParameter: watchParameter,),
      ),
    );
  }
}
