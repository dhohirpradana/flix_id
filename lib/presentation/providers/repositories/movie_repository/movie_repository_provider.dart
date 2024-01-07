import 'package:flix_id/data/tmdb/tmdb_movie_repsitory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../data/repositories/movie_repository.dart';

part 'movie_repository_provider.g.dart';

@riverpod
MovieRepository movieRepository(MovieRepositoryRef ref) =>
    TmdbMovieRepostory();