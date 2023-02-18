import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/base/network/querymodel/watch_paramerter.dart';
import 'package:cinema/src/model/movie_detail.dart';
import 'package:cinema/src/persentation/watching/bloc/watch_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BetterLayerVideo extends StatefulWidget {
  final WatchParameter watchParameter;
  final MovieDetail movieDetail;
  List<Server> serverAvailable = Server.values;

  BetterLayerVideo(
      {super.key, required this.watchParameter, required this.movieDetail}) {
    serverAvailable = serverAvailable
        .where((element) => element.name != watchParameter.server)
        .toList();
  }

  final title = "Watch Movie";

  @override
  State<StatefulWidget> createState() {
    return _BetterLayerVideoState();
  }
}

class _BetterLayerVideoState extends State<BetterLayerVideo> {
  late BetterPlayerController _betterPlayerController;
  GlobalKey _betterPlayerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _betterPlayerController = BetterPlayerController(BetterPlayerConfiguration(
      placeholder: CachedNetworkImage(
        imageUrl: widget.movieDetail.cover ?? '',
      ),
      autoPlay: true,
      looping: true,
    ));
    _betterPlayerController
        .isPictureInPictureSupported()
        .then((isSupported) => {
              if (isSupported)
                {
                  _betterPlayerController
                      .enablePictureInPicture(_betterPlayerKey)
                }
            });
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.dispose(forceDispose: true);
  }

  tryNextServerWhenError() {
    final bloc = BlocProvider.of<WatchMovieBloc>(context);
    if (widget.serverAvailable.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Thử tìm server ${widget.serverAvailable.last.name}. Vui lòng đợi !")));
      bloc.add(WatchMovieGetData(
          widget.watchParameter.copyWith(server: widget.serverAvailable.last)));
      if (widget.serverAvailable.length > 1) {
        widget.serverAvailable.removeLast();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Không tìm thấy film ở tất cả các server")));
      bloc.add(WatchMovieFinished());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: widget.title,
      // theme: ,
      home: Scaffold(
        body: BlocConsumer<WatchMovieBloc, WatchMovieState>(
          listener: (context, state) {
            final bloc = BlocProvider.of<WatchMovieBloc>(context);
            if (state.watchMovieStatus == DataStatus.success &&
                state.watchMovieData != null) {
              final watchMovie = state.watchMovieData;
              final sourceSubtitle = state.watchMovieData?.subtitles
                      ?.map((element) => BetterPlayerSubtitlesSource(
                            type: BetterPlayerSubtitlesSourceType.network,
                            name: element.lang,
                            urls: [element.url],
                          ))
                      .toList() ??
                  [];

              final notification = BetterPlayerNotificationConfiguration(
                  showNotification: true,
                  title: widget.movieDetail.title,
                  author: widget.movieDetail.production,
                  imageUrl: widget.movieDetail.cover);
              const bufferingConfiguration = BetterPlayerBufferingConfiguration(
                minBufferMs: 50000,
                maxBufferMs: 13107200,
                bufferForPlaybackMs: 2500,
                bufferForPlaybackAfterRebufferMs: 5000,
              );
              Map<String, String> resolutions = {};

              state.watchMovieData?.sources?.forEach((e) {
                resolutions[e.quality] = e.url;
              });
              _betterPlayerController
                  .setupDataSource(
                BetterPlayerDataSource(
                    resolutions: resolutions,
                    BetterPlayerDataSourceType.network,
                    videoFormat: BetterPlayerVideoFormat.hls,
                    state.watchMovieData?.sources?.first.url ?? '',
                    subtitles: sourceSubtitle,
                    notificationConfiguration: notification,
                    bufferingConfiguration: bufferingConfiguration),
              )
                  .then((response) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Tìm thấy film chuẩn bị chiếu !")));
                bloc.add(WatchMovieBegin());
              }).catchError((error) async {
                tryNextServerWhenError();
              });
            }
            if (state.watchMovieStatus == DataStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Không tìm thấy film này ở server ${widget.watchParameter.server}")));
              tryNextServerWhenError();
            }
          },
          buildWhen: (_, current) =>
              current.watchMovieStatus == DataStatus.begin &&
              current.watchMovieData != null,
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: BetterPlayer(
                      key: _betterPlayerKey,
                      controller: _betterPlayerController,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
