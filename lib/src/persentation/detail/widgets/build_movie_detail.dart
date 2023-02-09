import 'dart:ui';

import 'package:cinema/routers.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/base/network/querymodel/watch_paramerter.dart';
import 'package:cinema/src/persentation/detail/bloc/detail_movie_bloc.dart';
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

    Widget buildOptionsServerWatchMovie(
        {required String title,
        required String episodeId,
        required String mediaId,
        required Server server}) {
      return Card(
        elevation: 3,
        child: GestureDetector(
          onTap: () {
            pushMovieParameterNormal(episodeId, mediaId, server);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const Icon(Icons.play_arrow), Text(title)],
            ),
          ),
        ),
      );
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
              height: MediaQuery.of(context).size.height / 3,
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    ),
                  ),
                  Image.network(
                    movie.image ?? '',
                    fit: BoxFit.scaleDown,
                    width: double.infinity,
                  ),
                  Positioned(
                      top: 8,
                      left: 8,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back)))
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
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text("Công chiếu : ${movie.releaseDate ?? '__'}"),
                    Text("Thời lượng : ${movie.duration ?? '__'}"),
                    Text(movie?.production ?? '')
                  ]),
            ),
            Column(
              children: [
                buildOptionsServerWatchMovie(
                    title: "Xem server 1",
                    episodeId: movie.episodes!.first.id,
                    mediaId: movie.id!,
                    server: Server.mixdrop),
                buildOptionsServerWatchMovie(
                    title: "Xem server 2",
                    episodeId: movie.episodes!.first.id,
                    mediaId: movie.id!,
                    server: Server.upcloud),
                buildOptionsServerWatchMovie(
                    title: "Xem server 3",
                    episodeId: movie.episodes!.first.id,
                    mediaId: movie.id!,
                    server: Server.vidcloud),
              ],
            ),
            Container(
              margin: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.description ?? '',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text("Casts : ${movie.casts?.join(", ")} "),
                ],
              ),
            ),
            ListView.builder(
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: (){
                      pushMovieParameterNormal(movie.episodes![index].id,  movie.id!, Server.upcloud);
                    },
                    child: ListTile(
                      leading: CircleAvatar(child: Text((index + 1).toString())),
                      title: Text(movie.episodes![index].title),
                    ),
                  );
                },
                itemCount: movie.episodes?.length ?? 0,
                scrollDirection: Axis.vertical,
                shrinkWrap: true)
          ],
        );
      } else if (state.movieDetailStatus == DataStatus.failure) {
        return Text("Lỗi ${(state.props.toString())}");
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
