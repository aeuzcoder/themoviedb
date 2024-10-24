import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/core/constants.dart';
import 'package:themoviedb/core/error/failure.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';
import 'package:themoviedb/feature/domain/usecases/get_films.dart';
import 'package:themoviedb/feature/presentation/cubit/film_cubit/film_state.dart';

class FilmCubit extends Cubit<FilmState> {
  final GetFilms getFilms;

  FilmCubit(this.getFilms) : super(FilmEmptyState());

  int page = 1;
  Map<FilmCategory, List<FilmEntity>> oldFilms = {
    FilmCategory.allFilms: [],
    FilmCategory.empty: [],
    FilmCategory.series: [],
    FilmCategory.topAnimations: [],
    FilmCategory.topFilms: [],
  };

  /// Основная функция загрузки всех данных
  void loadAllData() async {
    if (state is FilmLoadingState) {
      return;
    }

    final currentState = state;

    if (currentState is FilmLoadedState) {
      oldFilms = currentState.films;
    }

    emit(FilmLoadingState(oldFilms: oldFilms, isFirstOpen: page == 1));

    // Загрузка данных по категориям
    await Future.wait([
      loadCategory(
          GetFilmsParams(page: page, filmCategory: FilmCategory.allFilms)),
      loadCategory(
          GetFilmsParams(page: page, filmCategory: FilmCategory.topFilms)),
      loadCategory(
          GetFilmsParams(page: page, filmCategory: FilmCategory.topAnimations)),
      loadCategory(
          GetFilmsParams(page: page, filmCategory: FilmCategory.series)),
    ]);

    emit(FilmLoadedState(films: oldFilms));
  }

  Future<void> loadCategory(GetFilmsParams params) async {
    final Either<Failure, List<FilmEntity>> failureOrFilms = await getFilms(
        params: GetFilmsParams(
            page: params.page, filmCategory: params.filmCategory));

    failureOrFilms.fold(
      (failure) {
        emit(FilmErrorState(message: messageOfFailure(failure)));
      },
      (films) {
        oldFilms[params.filmCategory]?.addAll(films);
        log('Category: ${params.filmCategory}, List length: ${oldFilms[params.filmCategory]!.length}');
      },
    );
  }

  String messageOfFailure(Failure failure) {
    if (failure.runtimeType == ServerFailure) {
      return 'Server Failure';
    }
    if (failure.runtimeType == CacheFailure) {
      return 'Cache Failure';
    } else {
      return 'Unexpected Error';
    }
  }
}
