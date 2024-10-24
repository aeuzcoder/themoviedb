// ignore_for_file: constant_identifier_names

const String API_TOP_FILMS =
    'https://api.themoviedb.org/3/trending/movie/day?api_key=e616910a588bb06fc6c2b9a4356b8373';
const String API_FILMS =
    'https://api.themoviedb.org/3/movie/top_rated?api_key=e616910a588bb06fc6c2b9a4356b8373';
const String API_ANIMATIONS =
    'https://api.themoviedb.org/3/discover/movie?api_key=e616910a588bb06fc6c2b9a4356b8373&with_genres=16';

const String API_SERIES =
    'https://api.themoviedb.org/3/tv/top_rated?api_key=e616910a588bb06fc6c2b9a4356b8373';

const String API_SEARCH =
    'https://api.themoviedb.org/3/search/movie?api_key=e616910a588bb06fc6c2b9a4356b8373';

const String HTTP_IMAGE = 'https://image.tmdb.org/t/p/original';

enum FilmCategory {
  topFilms,
  topAnimations,
  allFilms,
  series,
  empty,
}
