// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:themoviedb/core/constants.dart';
import 'package:themoviedb/core/error/exception.dart';
import 'package:themoviedb/feature/data/models/film_model.dart';

abstract class LocalDataSources {
  Future<List<FilmModel>> getFilms(FilmCategory filmCategory);
  Future<List<String>> filmsToCache(
      FilmCategory filmCategory, List<FilmModel> films);
}

class LocalDataSourcesImpl implements LocalDataSources {
  LocalDataSourcesImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<List<String>> filmsToCache(
      FilmCategory filmCategory, List<FilmModel> films) {
    final List<String> jsonFilmsList =
        films.map((film) => json.encode(film.toJson())).toList();
    sharedPreferences.setStringList(filmCategory.toString(), jsonFilmsList);
    log('count films wrote to cache: ${films.length}');
    return Future.value(jsonFilmsList);
  }

  @override
  Future<List<FilmModel>> getFilms(FilmCategory filmCategory) =>
      _getFilms(filmCategory);

  Future<List<FilmModel>> _getFilms(FilmCategory filmCategory) {
    final jsonFilmsList =
        sharedPreferences.getStringList(filmCategory.toString());
    if (jsonFilmsList!.isNotEmpty) {
      log('ALL FILMS FROM CACHE: $jsonFilmsList');
      return Future.value(
        jsonFilmsList
            .map((film) => FilmModel.fromJson(json.decode(film)))
            .toList(),
      );
    } else {
      throw CacheException();
    }
  }
}
