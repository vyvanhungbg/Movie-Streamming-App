import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/routers.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/persentation/detail/bloc/detail_movie_bloc.dart';
import 'package:cinema/src/persentation/favorite/bloc/favorite_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyFavoriteWidget extends StatefulWidget {
  const BodyFavoriteWidget({Key? key}) : super(key: key);

  @override
  State<BodyFavoriteWidget> createState() => _BodyFavoriteWidgetState();
}

class _BodyFavoriteWidgetState extends State<BodyFavoriteWidget> {
  void pushMovieWithId(String idMovie) {
    Navigator.pushNamed(context, Routers.detail, arguments: {'id': idMovie});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
        builder: (context, state) {
      final moviesFavorite = state.favoriteEntityListData ?? [];
      if (state.favoriteMovieStatus == DataStatus.success) {
        return RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<FavoriteMovieBloc>(context)
                .add(FavoriteMovieGetMovieFavoriteEvent());
          },
          child: GridView.count(
            // crossAxisCount is the number of columns
            crossAxisCount: 2,
            // This creates two columns with two items in each column
            children: List.generate(moviesFavorite.length ?? 0, (index) {
              return GestureDetector(
                onLongPress: () {
                  BlocProvider.of<DetailMovieBloc>(context)
                      .add(RemoveFavoriteMovie(moviesFavorite[index].id));
                  BlocProvider.of<FavoriteMovieBloc>(context)
                      .add(FavoriteMovieGetMovieFavoriteEvent());
                },
                onTap: () {
                  pushMovieWithId(moviesFavorite[index].id ?? '');
                },
                child: Container(
                  //decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: const EdgeInsets.all(3),

                  child: CachedNetworkImage(
                      imageUrl: moviesFavorite[index].image ?? '',
                      fit: BoxFit.fill),
                ),
              );
            }),
          ),
        );
      } else if (state.favoriteMovieStatus == DataStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Text("Lỗi");
      }
    });
  }
}
