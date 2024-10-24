import 'package:themoviedb/core/constants.dart';

String titleOfFilms(FilmCategory filmCategory) {
  switch (filmCategory) {
    case FilmCategory.allFilms:
      return 'ALL FILMS';
    case FilmCategory.empty:
      return 'EMPTY';
    case FilmCategory.series:
      return 'SERIES';
    case FilmCategory.topAnimations:
      return 'TOP ANIMATIONS';
    case FilmCategory.topFilms:
      return 'TOP FILMS';
    default:
      return '';
  }
}
