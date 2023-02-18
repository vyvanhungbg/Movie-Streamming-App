import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/persentation/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/home_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            margin: const EdgeInsets.only(left: 12, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${list[index].title}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${AppLocalizations.of(context)!.duration}: ${list[index].duration ?? '${AppLocalizations.of(context)?.noInfo}'}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${AppLocalizations.of(context)!.releaseDate}: ${list[index].releaseDate ?? '${AppLocalizations.of(context)?.noInfo}'}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      });
}
