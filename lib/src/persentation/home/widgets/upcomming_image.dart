import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/generated/assets.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/persentation/home/bloc/home_bloc.dart';
import 'package:cinema/src/persentation/home/bloc/home_state.dart';
import 'package:cinema/src/persentation/home/helper/custom_search_delegate.dart';
import 'package:cinema/src/persentation/search/search_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../../../routers.dart';

class UpcomingSliderImage extends StatelessWidget {
  UpcomingSliderImage(
      {super.key,
      required this.pageController,
      required this.viewportFraction,
      required this.pageOffset});

  final PageController? pageController;
  final double viewportFraction;
  final double? pageOffset;

  @override
  Widget build(BuildContext context) {
    void navigateDetailMovieWithIdMovie(String idMovie) {
      Navigator.pushNamed(context, Routers.detail, arguments: {'id': idMovie});
    }

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        buildWhen: (current, previous) {
          return current.moviesTrendingStatus == DataStatus.loading ||
              current.moviesTrendingStatus == DataStatus.success;
        },
        builder: (context, state) {
          final list = state.moviesTrendingData?.results ?? [];
          if (state.moviesTrendingStatus == DataStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.moviesTrendingStatus == DataStatus.success) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    Assets.imagesImgBackgroundHeader,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.0)),
                    ),
                  ),
                ),
                PageView.builder(
                  controller: pageController,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    double scaleMainView = max(viewportFraction,
                        1 - (pageOffset! - index).abs() + viewportFraction);
                    double angle = (pageOffset! - index).abs();
                    angle = angle > 0.5 ? 1 - angle : angle;
                    return Container(
                      padding: EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 100 - scaleMainView * 25,
                          bottom: 100 - scaleMainView * 25),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(-angle)
                          ..rotateZ(angle * 0.2),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            navigateDetailMovieWithIdMovie(item.id ?? '');
                          },
                          child: Card(
                            elevation: 2,
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: item.image ?? '',
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(Assets.imagesImgError),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 10,
                                  child: Card(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 8),
                                      child: Text(
                                        item.type ?? '',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        final blocSearch =
                            BlocProvider.of<SearchMovieBloc>(context);
                        showSearch(
                            context: context,
                            delegate:
                                CustomSearchDelegate(blocSearch: blocSearch));
                      },
                    ),
                  ),
                )
              ],
            );
          } else {
            return Image.asset(Assets.imagesImgError);
          }
        },
      ),
    );
  }
}
