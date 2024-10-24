import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:themoviedb/core/error/failure.dart';
import 'package:themoviedb/core/usecases/usecase.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';
import 'package:themoviedb/feature/domain/repositories/film_repositories.dart';

class SearchFilm extends UseCase<List<FilmEntity>, SearchFilmParams> {
  final FilmRepositories filmRepositories;
  SearchFilm({required this.filmRepositories});
  @override
  Future<Either<Failure, List<FilmEntity>>> call(
      {required SearchFilmParams params}) async {
    return await filmRepositories.searchFilm(params.query);
  }
}

class SearchFilmParams extends Equatable {
  final String query;

  const SearchFilmParams({required this.query});
  @override
  List<Object?> get props => [query];
}
