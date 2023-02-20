import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/usecase/usecase.dart';
import 'package:cinema/src/data/repositories/home_remote_repository.dart';
import 'package:cinema/src/model/movie_progress.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class UpdateMovieProgressUseCase implements UseCase<DataState, MovieProgress> {
  final HomeRemoteRepository _homeRemoteRepository;

  @factoryMethod
  UpdateMovieProgressUseCase(this._homeRemoteRepository);

  @override
  Future<DataState> call({required MovieProgress params}) {
    return _homeRemoteRepository.update(params);
  }
}
