import 'dart:ffi';

import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/response/array_response.dart';
import 'package:cinema/src/base/usecase/usecase.dart';
import 'package:cinema/src/data/repositories/home_remote_repository.dart';
import 'package:cinema/src/model/movie_response_model.dart';

class GetMoviesRecentUseCase implements UseCase<DataState, Null>{
  final HomeRemoteRepository homeRepository;

  GetMoviesRecentUseCase(this.homeRepository);

  @override
  Future<DataState> call({Null params}) {
    return homeRepository.getMoviesRecent();
  }

}