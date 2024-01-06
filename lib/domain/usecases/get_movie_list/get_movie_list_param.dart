enum MovieListCategories {
  upcoming,
  nowPlaying,
}

class GetMovieListParam {
  final MovieListCategories category;
  final int page;

  GetMovieListParam({
    required this.category,
    this.page = 1 ,
  });
}
