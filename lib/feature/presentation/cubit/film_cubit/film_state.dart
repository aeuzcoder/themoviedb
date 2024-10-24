import 'package:equatable/equatable.dart';
import 'package:themoviedb/core/constants.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';

abstract class FilmState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FilmEmptyState extends FilmState {
  @override
  List<Object?> get props => [];
}

class FilmLoadingState extends FilmState {
  final Map<FilmCategory, List<FilmEntity>> oldFilms;
  final bool isFirstOpen;

  FilmLoadingState({required this.oldFilms, required this.isFirstOpen});
  @override
  List<Object?> get props => [oldFilms, isFirstOpen];
}

class FilmLoadedState extends FilmState {
  final Map<FilmCategory, List<FilmEntity>> films;

  FilmLoadedState({required this.films});

  @override
  List<Object?> get props => [films];
}

class FilmErrorState extends FilmState {
  final String message;

  FilmErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}
