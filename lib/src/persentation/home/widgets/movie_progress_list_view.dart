import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/routers.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/persentation/home/bloc/home_bloc.dart';
import 'package:cinema/src/persentation/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MovieProgressListView extends StatefulWidget {
  const MovieProgressListView({Key? key}) : super(key: key);

  @override
  State<MovieProgressListView> createState() => _MovieProgressListViewState();
}

class _MovieProgressListViewState extends State<MovieProgressListView> {
  @override
  Widget build(BuildContext context) {
    navigateDetailMovieWithIdMovie(String idMovie) {
      Navigator.pushNamed(context, Routers.detail, arguments: {'id': idMovie});
    }

    return BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => true,
        builder: (context, state) {
          final list = state.moviesMovieProgressData ?? [];

          return Visibility(
              visible: list.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12, left: 12),
                    child: Text(
                      AppLocalizations.of(context)?.watching ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    height: 250,
                    width: double.infinity,
                    child: (state.moviesProgressStatus == DataStatus.loading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final item = list[index];
                              return GestureDetector(
                                onTap: () {
                                  navigateDetailMovieWithIdMovie(
                                      item.idMovie ?? '');
                                },
                                child: Container(
                                  //decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                                  margin: const EdgeInsets.all(8),

                                  child: CachedNetworkImage(
                                      imageUrl: item.image ?? ''),
                                ),
                              );
                            },
                            itemCount: list.length,
                          )),
                  ),
                ],
              ));
        });
  }
}
