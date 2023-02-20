import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/usecase/usecase.dart';
import 'package:cinema/src/data/repositories/detail_movie_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class FindFavoriteMovieUseCase implements UseCase<DataState, String> {
  final DetailMovieRepository _detailMovieRepository;

  @factoryMethod
  FindFavoriteMovieUseCase(this._detailMovieRepository);

  @override
  Future<DataState> call({required String params}) {
    return _detailMovieRepository.findByID(params);
  }
}
