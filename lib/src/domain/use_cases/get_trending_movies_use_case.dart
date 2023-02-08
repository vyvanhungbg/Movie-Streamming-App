import 'package:cinema/src/base/data/data_state.dart';
import 'package:cinema/src/data/repositories/home_remote_repository.dart';
import 'package:cinema/src/domain/use_cases/get_movies_recent_use_case.dart';

class GetTrendingMoviesUseCase implements GetMoviesRecentUseCase {
  final HomeRemoteRepository homeRepository;

  GetTrendingMoviesUseCase(this.homeRepository);

  @override
  Future<DataState> call({Null params}) {
    return homeRepository.getMoviesTrending();
  }
}
