import 'package:dartz/dartz.dart';
import 'package:themoviedb/core/error/exception.dart';
import 'package:themoviedb/core/error/failure.dart';
import 'package:themoviedb/core/platform/network_info.dart';
import 'package:themoviedb/core/constants.dart';
import 'package:themoviedb/feature/data/datasources/local_data_sources.dart';
import 'package:themoviedb/feature/data/datasources/remote_data_sources.dart';
import 'package:themoviedb/feature/data/models/film_model.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';
import 'package:themoviedb/feature/domain/repositories/film_repositories.dart';

class FilmRepositoriesImpl implements FilmRepositories {
  final RemoteDataSources remoteDataSources;
  final LocalDataSources localDataSources;
  final NetworkInfo networkInfo;

  FilmRepositoriesImpl({
    required this.remoteDataSources,
    required this.localDataSources,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<FilmEntity>>> getAllFilms(int page) =>
      _getFilms(() {
        return remoteDataSources.getAllFilms(page);
      }, FilmCategory.allFilms);

  @override
  Future<Either<Failure, List<FilmEntity>>> getSeries(int page) =>
      _getFilms(() {
        return remoteDataSources.getSeries(page);
      }, FilmCategory.series);

  @override
  Future<Either<Failure, List<FilmEntity>>> getTopAnimations(int page) =>
      _getFilms(() {
        return remoteDataSources.getTopAnimations(page);
      }, FilmCategory.topAnimations);

  @override
  Future<Either<Failure, List<FilmEntity>>> getTopFilms(int page) =>
      _getFilms(() {
        return remoteDataSources.getTopFilms(page);
      }, FilmCategory.topFilms);

  @override
  Future<Either<Failure, List<FilmEntity>>> searchFilm(String query) =>
      _getFilms(() {
        return remoteDataSources.searchFilm(query);
      }, FilmCategory.empty);

  Future<Either<Failure, List<FilmModel>>> _getFilms(
      Future<List<FilmModel>> Function() getFilms,
      FilmCategory filmCategory) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFilms = await getFilms();
        if (filmCategory != FilmCategory.empty) {
          localDataSources.filmsToCache(filmCategory, remoteFilms);
        }
        return Right(remoteFilms);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        if (filmCategory != FilmCategory.empty) {
          final localFilms = await localDataSources.getFilms(filmCategory);
          return Right(localFilms);
        } else {
          return Left(CacheFailure());
        }
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
