import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/usecase/usecase.dart';
import 'package:cinema/src/data/repositories/home_remote_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class GetAllMovieProgressUseCase implements UseCase<DataState, Null?> {
  final HomeRemoteRepository _homeRemoteRepository;

  @factoryMethod
  GetAllMovieProgressUseCase(this._homeRemoteRepository);

  @override
  Future<DataState> call({required Null? params}) {
    return _homeRemoteRepository.getAll();
  }
}
