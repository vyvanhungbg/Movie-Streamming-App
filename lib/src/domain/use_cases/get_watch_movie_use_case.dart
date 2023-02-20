import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/usecase/usecase.dart';
import 'package:cinema/src/data/repositories/watching/watch_movie_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class GetWatchMovieUseCase implements UseCase<DataState, Map<String, String>> {
  final WatchMovieRepository _watchMovieRepository;

  @factoryMethod
  GetWatchMovieUseCase(this._watchMovieRepository);

  @override
  Future<DataState> call({required Map<String, String> params}) {
    return _watchMovieRepository.getWatchMoviesEntityByOptions(params);
  }
}
