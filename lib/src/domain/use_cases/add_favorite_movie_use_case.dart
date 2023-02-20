import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/data/repositories/detail_movie_repository.dart';
import 'package:cinema/src/model/favorite_entity.dart';
import 'package:injectable/injectable.dart';

import '../../base/usecase/usecase.dart';

@Singleton()
class AddFavoriteMovieUseCase implements UseCase<DataState, FavoriteEntity> {
  final DetailMovieRepository _detailMovieRepository;

  @factoryMethod
  AddFavoriteMovieUseCase(this._detailMovieRepository);

  @override
  Future<DataState> call({required FavoriteEntity params}) {
    return _detailMovieRepository.addFavorite(params);
  }
}
