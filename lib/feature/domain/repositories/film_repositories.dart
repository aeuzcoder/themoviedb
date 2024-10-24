import 'package:dartz/dartz.dart';
import 'package:themoviedb/core/error/failure.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';

abstract class FilmRepositories {
  Future<Either<Failure, List<FilmEntity>>> getTopFilms(int page);
  Future<Either<Failure, List<FilmEntity>>> getTopAnimations(int page);
  Future<Either<Failure, List<FilmEntity>>> getAllFilms(int page);
  Future<Either<Failure, List<FilmEntity>>> getSeries(int page);
  Future<Either<Failure, List<FilmEntity>>> searchFilm(String query);
}
