import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:themoviedb/core/constants.dart';
import 'package:themoviedb/core/error/failure.dart';
import 'package:themoviedb/core/usecases/usecase.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';
import 'package:themoviedb/feature/domain/repositories/film_repositories.dart';

class GetFilms extends UseCase<List<FilmEntity>, GetFilmsParams> {
  final FilmRepositories filmRepositories;

  GetFilms({required this.filmRepositories});

  @override
  Future<Either<Failure, List<FilmEntity>>> call(
      {required GetFilmsParams params}) async {
    switch (params.filmCategory) {
      case FilmCategory.topFilms:
        return await filmRepositories.getTopFilms(params.page);
      case FilmCategory.topAnimations:
        return await filmRepositories.getTopAnimations(params.page);
      case FilmCategory.allFilms:
        return await filmRepositories.getAllFilms(params.page);
      case FilmCategory.series:
        return await filmRepositories.getSeries(params.page);

      default:
        return Left(SoftwareFailure());
    }
  }
}

class GetFilmsParams extends Equatable {
  final int page;
  final FilmCategory filmCategory;

  const GetFilmsParams({required this.page, required this.filmCategory});

  @override
  List<Object?> get props => [page, filmCategory];
}
