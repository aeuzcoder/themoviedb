import 'dart:convert';

import 'package:themoviedb/core/error/exception.dart';
import 'package:themoviedb/core/constants.dart';
import 'package:themoviedb/feature/data/models/film_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSources {
  Future<List<FilmModel>> getTopFilms(int page);
  Future<List<FilmModel>> getTopAnimations(int page);
  Future<List<FilmModel>> getAllFilms(int page);
  Future<List<FilmModel>> getSeries(int page);
  Future<List<FilmModel>> searchFilm(String query);
}

class RemoteDataSourcesImpl implements RemoteDataSources {
  final http.Client client;
  RemoteDataSourcesImpl({required this.client});
  @override
  Future<List<FilmModel>> getAllFilms(int page) =>
      _getFilmsFromUrl('$API_FILMS&page=$page');

  @override
  Future<List<FilmModel>> getSeries(int page) =>
      _getFilmsFromUrl('$API_SERIES&page=$page');

  @override
  Future<List<FilmModel>> getTopAnimations(int page) =>
      _getFilmsFromUrl('$API_ANIMATIONS&page=$page');

  @override
  Future<List<FilmModel>> getTopFilms(int page) =>
      _getFilmsFromUrl('$API_TOP_FILMS&page=$page');

  @override
  Future<List<FilmModel>> searchFilm(String query) =>
      _getFilmsFromUrl('$API_SEARCH&query=${Uri.encodeComponent(query)}');

  Future<List<FilmModel>> _getFilmsFromUrl(String url) async {
    final uri = Uri.parse(url);
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      final films = json.decode(response.body);
      return (films['results'] as List)
          .map((film) => FilmModel.fromJson(film))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
