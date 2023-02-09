import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/usecase/usecase.dart';
import 'package:cinema/src/data/repositories/watching/watch_movie_repository.dart';

class GetWatchMovieUseCase implements UseCase<DataState, Map<String, String>>{

  final WatchMovieRepository _watchMovieRepository;

  GetWatchMovieUseCase(this._watchMovieRepository);

  @override
  Future<DataState> call({required Map<String, String> params}) {
    return _watchMovieRepository.getWatchMoviesEntityByOptions(params);
  }

}