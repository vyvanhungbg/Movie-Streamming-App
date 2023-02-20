import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/data/repositories/detail_movie_repository.dart';
import 'package:injectable/injectable.dart';

import '../../base/usecase/usecase.dart';

@Singleton()
class RemoveFavoriteMovieUseCase implements UseCase<DataState, String> {
  final DetailMovieRepository _detailMovieRepository;

  @factoryMethod
  RemoveFavoriteMovieUseCase(this._detailMovieRepository);

  @override
  Future<DataState> call({required String params}) {
    return _detailMovieRepository.removeFavorite(params);
  }
}
