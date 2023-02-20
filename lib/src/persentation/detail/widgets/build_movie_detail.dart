import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/generated/assets.dart';
import 'package:cinema/routers.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/base/network/querymodel/watch_paramerter.dart';
import 'package:cinema/src/model/favorite_entity.dart';
import 'package:cinema/src/model/movie_detail.dart';
import 'package:cinema/src/persentation/detail/bloc/detail_movie_bloc.dart';
import 'package:cinema/src/persentation/detail/widgets/description_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildMovieDetail extends StatelessWidget {
  const BuildMovieDetail({super.key});

  @override
  Widget build(BuildContext context) {
    pushMovieParameterNormal(String episodeId, String mediaId, Server server,
        MovieDetail movieDetail) {
      Navigator.pushNamed(context, Routers.watching, arguments: {
        'episodeId': episodeId,
        'mediaId': mediaId,
        'server': server.name,
        'movieDetail': movieDetail
      });
    }

    Widget buildOptionsServerWatchMovie(
        {required String title,
        required String episodeId,
        required String mediaId,
        required Server server,
        required MovieDetail movieDetail,
        double dy = 1.0}) {
      return Transform.translate(
        offset: Offset(0.0, dy),
        child: Card(
          elevation: 3,
          child: InkWell(
            onTap: () {
              pushMovieParameterNormal(episodeId, mediaId, server, movieDetail);
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

    Widget TitleAndContentWidget(
        {required String title,
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
                  CachedNetworkImage(
                    imageUrl: movie.image ?? '',
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
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: InkWell(
                              onTap: () {
                                final entityFavorite = FavoriteEntity.init(
                                    id: movie.id!, image: movie.image);

                                final currentFavorite =
                                    state.actionFavoriteStatus;
                                if (currentFavorite ==
                                    ActionFavoriteStatus.unFavorite) {
                                  BlocProvider.of<DetailMovieBloc>(context)
                                      .add(AddFavoriteMovie(entityFavorite));
                                } else if (currentFavorite ==
                                    ActionFavoriteStatus.favorite) {
                                  BlocProvider.of<DetailMovieBloc>(context).add(
                                      RemoveFavoriteMovie(entityFavorite.id));
                                } else {
                                  BlocProvider.of<DetailMovieBloc>(context).add(
                                      FindFavoriteMovie(entityFavorite.id));
                                }
                              },
                              child: Icon(
                                state.actionFavoriteStatus ==
                                        ActionFavoriteStatus.favorite
                                    ? Icons.favorite_outlined
                                    : Icons.favorite_border_outlined,
                                color: Colors.red,
                              ))),
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
                    TitleAndContentWidget(
                        title: "${AppLocalizations.of(context)!.releaseDate}: ",
                        content: movie.releaseDate ?? '__'),
                    TitleAndContentWidget(
                        title: "${AppLocalizations.of(context)!.duration}: ",
                        content: movie.duration ?? '__'),
                    TitleAndContentWidget(
                        title: "${AppLocalizations.of(context)!.production}: ",
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
                    server: Server.mixdrop,
                    movieDetail: movie),
                buildOptionsServerWatchMovie(
                    title: "Server siêu lag",
                    episodeId: movie.episodes!.first.id,
                    mediaId: movie.id!,
                    server: Server.upcloud,
                    movieDetail: movie,
                    dy: -15),
                buildOptionsServerWatchMovie(
                    title: "Server trái đất",
                    episodeId: movie.episodes!.first.id,
                    mediaId: movie.id!,
                    server: Server.vidcloud,
                    movieDetail: movie),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DescriptionTextWidget(
                    text:
                        "    ${movie.description?.replaceAll("\\n", "").trim()}" ??
                            '',
                    limit: 150,
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                  TitleAndContentWidget(
                    title: "${AppLocalizations.of(context)!.casts}: ",
                    content: movie.casts?.join(", ") ?? '__',
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              child: TitleAndContentWidget(
                title: "${AppLocalizations.of(context)!.genres}: ",
                content: movie.genres?.join(", ") ?? '__',
              ),
            ),
            Visibility(
              visible: movie.episodes!.length > 1,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.all(12),
                      child: Text(
                        AppLocalizations.of(context)!.episode,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )),
                  ExpansionTile(
                    title: Text(AppLocalizations.of(context)!.list),
                    children: [
                      ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: () {
                                pushMovieParameterNormal(
                                    movie.episodes![index].id,
                                    movie.id!,
                                    Server.upcloud,
                                    movie);
                              },
                              child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                      child: Text((index + 1).toString())),
                                  title: Text(movie.episodes![index].title),
                                ),
                              ),
                            );
                          },
                          itemCount: movie.episodes?.length ?? 0,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics())
                    ],
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.all(12),
                child: Text(
                  AppLocalizations.of(context)!.recommendations,
                  style: const TextStyle(
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
                        child: CachedNetworkImage(
                            imageUrl: recommendEntity?.image ?? ''),
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
        return Image.asset(Assets.imagesImgError);
      } else {
        return const CircularProgressIndicator();
      }
    });
  }
}
