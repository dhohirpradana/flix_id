abstract interface class UseCase<R, P> {
  Future<R> call(P params);
}