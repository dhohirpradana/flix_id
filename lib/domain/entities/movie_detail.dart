import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail.freezed.dart';

@freezed
class MovieDetail with _$MovieDetail {
  factory MovieDetail({
    required int id,
    required String title,
    String? posterPath,
    required String overview,
    String? backdropPath,
    required int runtime,
    required double voteAverage,
    required List<String> genres,
  }) = _MovieDetail;

  factory MovieDetail.fromJSON(Map<String, dynamic> json) => MovieDetail(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      backdropPath: json['backdrop_path'],
      runtime: json['runtime'],
      // 2 digits after comma
      voteAverage: double.parse((json['vote_average'] ?? 0).toStringAsFixed(1)),
      genres: List<String>.from(
        json['genres'].map((genre) => genre['name']),
      ));
}
