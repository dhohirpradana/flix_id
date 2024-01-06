import 'package:flix_id/data/repositories/movie_repository.dart';
import 'package:flix_id/domain/usecases/get_actors/get_actor_param.dart';

import '../../entities/actor.dart';
import '../../entities/result.dart';
import '../usecase.dart';

class GetActors implements UseCase<Result<List<Actor>>, GetActorsParam> {
  final MovieRepository _movieRepository;

  GetActors({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<List<Actor>>> call(GetActorsParam params) async {
    var actorListResult = await _movieRepository.getActors(id: params.movieId);

    return switch (actorListResult) {
      Success(value: final actors) => Result.success(actors),
      Failed(:final message) => Result.failed(message),
    };
  }
}
