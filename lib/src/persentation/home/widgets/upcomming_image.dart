import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/persentation/home/bloc/home_bloc.dart';
import 'package:cinema/src/persentation/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routers.dart';

class UpcomingSliderImage extends StatelessWidget {
  const UpcomingSliderImage(
      {super.key,
      required this.pageController,
      required this.viewportFraction,
      required this.pageOffset});

  final PageController? pageController;
  final double viewportFraction;
  final double? pageOffset;

  @override
  Widget build(BuildContext context) {
    pushUserNormal(String idMovie) {
      Navigator.pushNamed(context, Routers.detail, arguments: {'id':idMovie});
    }
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (current, previous) {
          return current.moviesTrendingStatus == DataStatus.loading || current.moviesTrendingStatus == DataStatus.success;
        },
        builder: (context, state) {
          final list = state.moviesTrendingData?.results ?? [];
          if (state.moviesTrendingStatus == DataStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return PageView.builder(
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
                      left: 20,
                      top: 100 - scaleMainView * 25,
                      bottom: 50),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: (){pushUserNormal(item.id ?? '');},
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: item.image ?? '',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator(),),
                            errorWidget: (context, url, error) =>
                                Text('Không có ảnh '),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 10,
                            child: Card(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
