import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/usecase/usecase.dart';
import 'package:cinema/src/data/repositories/search/search_movie_repository.dart';

class SearchMovieUseCase implements UseCase<DataState, String>{

  final SearchMovieRepository _searchMovieRepository;

  SearchMovieUseCase(this._searchMovieRepository);

  @override
  Future<DataState> call({required String params}) {
    return _searchMovieRepository.searchMovie(params);
  }

}