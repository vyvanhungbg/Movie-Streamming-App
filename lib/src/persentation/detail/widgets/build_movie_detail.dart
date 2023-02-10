import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/routers.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/base/network/querymodel/watch_paramerter.dart';
import 'package:cinema/src/persentation/detail/bloc/detail_movie_bloc.dart';
import 'package:cinema/src/persentation/detail/widgets/description_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildMovieDetail extends StatelessWidget {
  const BuildMovieDetail({super.key});

  @override
  Widget build(BuildContext context) {
    pushMovieParameterNormal(String episodeId, String mediaId, Server server) {
      Navigator.pushNamed(context, Routers.watching, arguments: {
        'episodeId': episodeId,
        'mediaId': mediaId,
        'server': server.name
      });
    }

    Widget buildOptionsServerWatchMovie({required String title,
      required String episodeId,
      required String mediaId,
      required Server server,
      double dy = 1.0}) {
      return Transform.translate(
        offset: Offset(0.0, dy),
        child: Card(
          elevation: 3,
          child: InkWell(
            onTap: () {
              pushMovieParameterNormal(episodeId, mediaId, server);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const Icon(Icons.play_arrow), Text(title)],
              ),
            ),
          ),
        ),
      );
    }

    Widget TitleAndContentWidget({required String title,
      required String content,
      TextStyle styleTitle = const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      TextStyle styleContent = const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black)}) {
      return RichText(
        text: TextSpan(
            text: title,
            style: styleTitle,
            children: [TextSpan(text: content, style: styleContent)]),
      );
    }

    pushUserNormal(String idMovie) {
      Navigator.pushNamed(context, Routers.detail, arguments: {'id': idMovie});
    }

    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state) {
          final movie = state.movieDetailData;
          if (movie != null && state.movieDetailStatus == DataStatus.success) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(movie.cover ?? ''),
                        fit: BoxFit.cover,
                      )),
                  width: double.infinity,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 3,
                  child: Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        child: Container(
                          decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.0)),
                        ),
                      ),
                      CachedNetworkImage(imageUrl :
                      movie.image ?? '',
                        fit: BoxFit.scaleDown,
                        width: double.infinity,
                      ),
                      Container(
                          padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back))),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              padding: const EdgeInsets.all(3),
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 1, color: Colors.grey)),
                              child: InkWell(
                                  onTap: () {

                                  },
                                  child: const Icon(
                                      Icons.favorite_border_outlined))),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        TitleAndContentWidget(title: "Start: ",
                            content: movie.releaseDate ?? '__'),
                        TitleAndContentWidget(title: "Duration: ",
                            content: movie.duration ?? '__'),
                        TitleAndContentWidget(title: "Production: ",
                            content: movie.production ?? '__'),
                      ]),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildOptionsServerWatchMovie(
                        title: "Server sao hỏa",
                        episodeId: movie.episodes!.first.id,
                        mediaId: movie.id!,
                        server: Server.mixdrop),
                    buildOptionsServerWatchMovie(
                        title: "Server siêu lag",
                        episodeId: movie.episodes!.first.id,
                        mediaId: movie.id!,
                        server: Server.upcloud,
                        dy: -15),
                    buildOptionsServerWatchMovie(
                        title: "Server trái đất",
                        episodeId: movie.episodes!.first.id,
                        mediaId: movie.id!,
                        server: Server.vidcloud),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DescriptionTextWidget(
                        text:
                        "    ${movie.description?.replaceAll("\\n", "")
                            .trim()}" ??
                            '',
                        limit: 150,
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                      TitleAndContentWidget(
                        title: "Casts: ",
                        content: movie.casts?.join(", ") ?? '__',
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: movie.episodes!.length > 1,
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.all(12),
                          child: const Text(
                            "Episodes",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          )),
                      ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: () {
                                pushMovieParameterNormal(
                                    movie.episodes![index].id, movie.id!,
                                    Server.upcloud);
                              },
                              child: Card(
                                child: ListTile(
                                  leading:
                                  CircleAvatar(
                                      child: Text((index + 1).toString())),
                                  title: Text(movie.episodes![index].title),
                                ),
                              ),
                            );
                          },
                          itemCount: movie.episodes?.length ?? 0,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics()),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(12),
                    child: const Text(
                      "Recommendations",
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                Container(
                  height: 200,
                  child: ListView.builder(
                      itemBuilder: (_, index) {
                        final recommendEntity = movie.recommendations?[index];
                        return GestureDetector(
                          onTap: () {
                            pushUserNormal(recommendEntity?.id ?? '');
                          },
                          child: Container(
                            //decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                            margin: const EdgeInsets.all(8),
                            child: CachedNetworkImage(imageUrl : recommendEntity?.image ?? ''),
                          ),
                        );
                      },
                      itemCount: movie.recommendations?.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true),
                )
              ],
            );
          } else if (state.movieDetailStatus == DataStatus.failure) {
            return const Text("Error cannot find this movie !}");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
