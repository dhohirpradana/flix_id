import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/get_movie_list/get_movie_list_param.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

import '../../../data/repositories/movie_repository.dart';

class GetMovieList implements UseCase<Result<List<Movie>>, GetMovieListParam> {
  final MovieRepository _movieRepository;

  GetMovieList({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<List<Movie>>> call(GetMovieListParam params) async {
    var movieListResult = switch (params.category) {
      MovieListCategories.nowPlaying =>
        await _movieRepository.getNowPlaying(page: params.page),
      MovieListCategories.upcoming =>
        await _movieRepository.getUpcoming(page: params.page),
    };

    return switch (movieListResult) {
      Success(value: final movies) => Result.success(movies),
      Failed(message: final message) => Result.failed(message),
    };
  }
}
