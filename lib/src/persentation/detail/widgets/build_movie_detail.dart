import 'dart:ui';

import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/persentation/detail/bloc/detail_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildMovieDetail extends StatelessWidget {
  const BuildMovieDetail({super.key});

  @override
  Widget build(BuildContext context) {

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
                      top: 8, left: 8, child: GestureDetector(onTap: (){Navigator.pop(context);},child: Icon(Icons.arrow_back)))
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
            Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Icon(Icons.play_arrow), Text("Xem")],
                ),
              ),
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
                  Text("Casts : ${movie.casts?.join(", ")} ")
                ],
              ),
            )
          ],
        );
      } else if (state.movieDetailStatus == DataStatus.failure) {
        return  Text("Lỗi ${(state.props.toString())}");
      } else {
        return const Center(child: CircularProgressIndicator(),);
      }
    });
  }
}
