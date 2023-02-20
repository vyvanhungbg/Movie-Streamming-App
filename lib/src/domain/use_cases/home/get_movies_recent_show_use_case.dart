import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/usecase/usecase.dart';
import 'package:cinema/src/data/repositories/home_remote_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class GetMoviesRecentShowUseCase implements UseCase<DataState, Null> {
  final HomeRemoteRepository homeRepository;

  @factoryMethod
  GetMoviesRecentShowUseCase(this.homeRepository);

  @override
  Future<DataState> call({Null params}) {
    return homeRepository.getMoviesRecentShow();
  }
}
