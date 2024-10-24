import 'package:equatable/equatable.dart';

class FilmEntity extends Equatable {
  final String title;
  final String backdropPath;
  final String originalLanguage;
  final String overview;
  final String posterPath;
  final String releaseData;
  final double voteAverage;
  final int voteCount;

  const FilmEntity({
    required this.title,
    required this.backdropPath,
    required this.originalLanguage,
    required this.overview,
    required this.posterPath,
    required this.releaseData,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        title,
        backdropPath,
        originalLanguage,
        overview,
        posterPath,
        releaseData,
        voteAverage,
        voteCount,
      ];
}
