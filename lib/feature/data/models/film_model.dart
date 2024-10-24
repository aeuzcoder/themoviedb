import 'package:themoviedb/feature/domain/entities/film_entities.dart';

class FilmModel extends FilmEntity {
  const FilmModel(
      {required super.title,
      required super.backdropPath,
      required super.originalLanguage,
      required super.overview,
      required super.posterPath,
      required super.releaseData,
      required super.voteAverage,
      required super.voteCount});

  factory FilmModel.fromJson(Map<String, dynamic> json) {
    //  FOR CHECKING
    // log('From Json');
    // log(json.toString());
    // log('title: ${json['title'].runtimeType.toString()} -> String');
    // log('backdropPath: ${json['backdrop_path'].runtimeType.toString()} -> String');
    // log('originalLanguage: ${json['original_language'].runtimeType.toString()} -> String');
    // log('overview: ${json['overview'].runtimeType.toString()} -> String');
    // log('posterPath: ${json['poster_path'].runtimeType.toString()} -> String');
    // log('releaseData: ${json['release_date'].runtimeType.toString()} -> String');
    // log('voteAverage: ${json['vote_average'].runtimeType.toString()} -> double');
    // log('voteCount: ${json['vote_count'].runtimeType.toString()} -> int');

    return FilmModel(
      title: json['title'] ?? json['name'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseData: json['release_date'] ?? '',
      voteAverage: json['vote_average'] ?? 0.0,
      voteCount: json['vote_count'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'backdrop_path': backdropPath,
      'original_language': originalLanguage,
      'overview': overview,
      'poster_path': posterPath,
      'release_data': releaseData,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
