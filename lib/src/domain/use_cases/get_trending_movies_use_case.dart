import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/base/usecase/usecase.dart';
import 'package:cinema/src/data/repositories/home_remote_repository.dart';

class GetTrendingMoviesUseCase implements UseCase<DataState, Null> {
  final HomeRemoteRepository homeRepository;

  GetTrendingMoviesUseCase(this.homeRepository);

  @override
  Future<DataState> call({Null params}) {
    return homeRepository.getMoviesTrending();
  }
}
