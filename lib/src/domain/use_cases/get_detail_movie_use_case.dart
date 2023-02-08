import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/usecase/usecase.dart';
import 'package:cinema/src/data/repositories/detail_movie_repository.dart';

class GetDetailMovieUseCase implements UseCase<DataState, Map<String, String>> {
  final DetailMovieRepository _detailMovieRepository;

  GetDetailMovieUseCase(this._detailMovieRepository);

  @override
  Future<DataState> call({required Map<String, String> params}) {
    return _detailMovieRepository.getMoviesById(params);
  }

}
