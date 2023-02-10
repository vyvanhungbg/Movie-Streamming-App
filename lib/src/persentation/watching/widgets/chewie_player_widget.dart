import 'package:chewie/chewie.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/base/network/querymodel/watch_paramerter.dart';
import 'package:cinema/src/persentation/watching/bloc/watch_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper_package.dart';
import 'package:video_player/video_player.dart';

class ChewiePlayerWidget extends StatefulWidget {
  final WatchParameter watchParameter;
  List<Server> serverAvailable = Server.values;

  ChewiePlayerWidget({super.key, required this.watchParameter}) {
    serverAvailable = serverAvailable
        .where((element) => element.name != watchParameter.server)
        .toList();
  }

  final title = "Watch Movie";

  @override
  State<StatefulWidget> createState() {
    return _ChewiePlayerWidgetState();
  }
}

class _ChewiePlayerWidgetState extends State<ChewiePlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  var _subtitleController = SubtitleController(
      subtitleDecoder: SubtitleDecoder.utf8,
      subtitleUrl:
          "https://cc.2cdns.com/76/94/76943aa3f5dab048d9043cb9317f4225/eng-2.vtt",
      subtitleType: SubtitleType.webvtt);
  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    //initializePlayer("");
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer(String src) async {
    _videoPlayerController = VideoPlayerController.network(src);

    await Future.wait([_videoPlayerController.initialize()]).catchError((_) {
      tryNextServerWhenError();
      print("Lỗi");
    });

    _createChewieController();
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      fullScreenByDefault: true,

      allowFullScreen: true,
      errorBuilder: (_,__) => Text("Đã xảy ra lỗi"),
      showOptions: true,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: toggleVideo,
            iconData: Icons.live_tv_sharp,
            title: 'Toggle Video Src',
          ),
          OptionItem(
            onTap: () => _subtitleController.subtitleUrl =
                "https://cc.2cdns.com/76/94/76943aa3f5dab048d9043cb9317f4225/eng-2.vtt",
            iconData: Icons.subtitles,
            title: 'Toggle Subtitle',
          )
        ];
      },
      hideControlsTimer: const Duration(seconds: 3),
      zoomAndPan: true,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.white54,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.grey,
      ),
      autoInitialize: true,
    );
  }

  Future<void> toggleVideo() async {
    await _videoPlayerController.pause();
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
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Không tìm thấy film ở tất cả các server")));
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
              initializePlayer(watchMovie!.sources!.first.url).whenComplete(() {
                bloc.add(WatchMovieBegin());
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Tìm thấy film chuẩn bị chiếu !")));
              });
            }
            if (state.watchMovieStatus == DataStatus.failure) {
              // Navigator.pop(context);
              //print("____Lỗi ko tìm thấy ${}");
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
                      child: _chewieController != null &&
                              _chewieController!
                                  .videoPlayerController.value.isInitialized
                          ? SubtitleWrapper(
                              videoPlayerController:
                                  _chewieController!.videoPlayerController,
                              subtitleController: _subtitleController,
                              subtitleStyle: const SubtitleStyle(
                                  textColor: Colors.redAccent, hasBorder: true),
                              videoChild: Chewie(
                                controller: _chewieController!,
                              ))
                          : const Center(child: CircularProgressIndicator())),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DelaySlider extends StatefulWidget {
  const DelaySlider({Key? key, required this.delay, required this.onSave})
      : super(key: key);

  final int? delay;
  final void Function(int?) onSave;

  @override
  State<DelaySlider> createState() => _DelaySliderState();
}

class _DelaySliderState extends State<DelaySlider> {
  int? delay;
  bool saved = false;

  @override
  void initState() {
    super.initState();
    delay = widget.delay;
  }

  @override
  Widget build(BuildContext context) {
    const int max = 1000;
    return ListTile(
      title: Text(
        "Progress indicator delay ${delay != null ? "${delay.toString()} MS" : ""}",
      ),
      subtitle: Slider(
        value: delay != null ? (delay! / max) : 0,
        onChanged: (value) async {
          delay = (value * max).toInt();
          setState(() {
            saved = false;
          });
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.save),
        onPressed: saved
            ? null
            : () {
                widget.onSave(delay);
                setState(() {
                  saved = true;
                });
              },
      ),
    );
  }
}
