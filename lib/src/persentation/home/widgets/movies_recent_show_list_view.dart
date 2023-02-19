import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/persentation/home/bloc/home_bloc.dart';
import 'package:cinema/src/persentation/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../routers.dart';
import 'package:cinema/generated/assets.dart';

class MoviesRecentShowListView extends StatelessWidget {
  const MoviesRecentShowListView({super.key});

  @override
  Widget build(BuildContext context) {
    navigateDetailMovieWithIdMovie(String idMovie) {
      Navigator.pushNamed(context, Routers.detail, arguments: {'id': idMovie});
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12, left: 12),
          child: Text(
            AppLocalizations.of(context)!.movieRecentShow,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          height: 250,
          width: double.infinity,
          child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) => true,
              builder: (context, state) {
                final list = state.moviesRecentShowData ?? [];
                if (state.moviesRecentShowStatus == DataStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.moviesRecentShowStatus == DataStatus.success &&
                    list.isNotEmpty) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      final lastEpisode =
                          item.latestEpisode?.replaceAll('EPS', '') ?? '';
                      return GestureDetector(
                        onTap: () {
                          navigateDetailMovieWithIdMovie(item.id ?? '');
                        },
                        child: Container(
                          //decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                          margin: const EdgeInsets.all(8),

                          child: Stack(children: [
                            CachedNetworkImage(imageUrl: item.image ?? ''),
                            Card(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(AppLocalizations.of(context)!.eps +
                                    lastEpisode),
                              ),
                            ),
                          ]),
                        ),
                      );
                    },
                    itemCount: list.length,
                  );
                } else {
                  return Image.asset(Assets.imagesImgError);
                }
              }),
        ),
      ],
    );
  }
}
