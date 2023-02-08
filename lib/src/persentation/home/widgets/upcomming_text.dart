import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/persentation/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class UpcomingText extends StatelessWidget {
  const UpcomingText({
    required this.pageOffset,
    super.key,
  });

  final double? pageOffset;

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          current.moviesTrendingStatus == DataStatus.success,
      builder: (context, state) {
        final list = state.moviesTrendingData?.results ?? [];
        final index = (pageOffset ?? 0).round();
        if (list.length > index) {
          return Container(
            margin: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${list[index].title}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Thời lượng: ${list[index].duration ?? '__'}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      });
}
