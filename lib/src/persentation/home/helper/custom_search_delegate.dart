import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/routers.dart';
import 'package:cinema/src/base/data/data_status.dart';
import 'package:cinema/src/persentation/search/search_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  List<String> searchDefaults = [
    "vy van hung",
    "marvel",
    "batman",
    "DC",
    "comic",
  ];
  final SearchMovieBloc blocSearch;

  CustomSearchDelegate({required this.blocSearch}) {}

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    blocSearch.add(SearchMovieStarted(searchKey: query));
    void pushUserNormal(String idMovie) {
      Navigator.pushNamed(context, Routers.detail, arguments: {'id': idMovie});
    }

    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
        buildWhen: (privious, current) =>
            current.searchMovieStatus == DataStatus.success ||
            current.searchMovieStatus == DataStatus.loading,
        builder: (context, state) {
          final movies = state.searchMovieData?.results ?? [];
          if (state.searchMovieStatus == DataStatus.success &&
              movies.isNotEmpty) {
            return GridView.count(
              // crossAxisCount is the number of columns
              crossAxisCount: 2,
              // This creates two columns with two items in each column
              children: List.generate(movies.length ?? 0, (index) {
                return GestureDetector(
                  onTap: () {
                    pushUserNormal(movies[index].id ?? '');
                  },
                  child: Container(
                    //decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: const EdgeInsets.all(3),

                    child: CachedNetworkImage(
                        imageUrl: movies[index].image ?? '', fit: BoxFit.fill),
                  ),
                );
              }),
            );
          } else if (state.searchMovieStatus == DataStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
                child: Container(
                    margin: const EdgeInsets.all(8),
                    child: const Text(
                      "Không tìm thấy bộ film nào phù hợp",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    )));
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    matchQuery = searchDefaults
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (_, index) => GestureDetector(
        child: ListTile(
          title: Text(matchQuery[index]),
        ),
        onTap: () {
          query = matchQuery[index];
        },
      ),
      itemCount: matchQuery.length,
    );
  }
}
