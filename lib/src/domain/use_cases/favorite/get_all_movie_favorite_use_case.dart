import 'dart:ffi';

import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/usecase/usecase.dart';
import 'package:cinema/src/data/repositories/detail_movie_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class GetAllMovieFavoriteUseCase implements UseCase<DataState, int> {
  final DetailMovieRepository _detailMovieRepository;

  @factoryMethod
  GetAllMovieFavoriteUseCase(this._detailMovieRepository);

  @override
  Future<DataState> call({required int params}) {
    return _detailMovieRepository.getAll();
  }
}
