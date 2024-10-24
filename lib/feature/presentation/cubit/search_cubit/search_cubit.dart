import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/core/error/failure.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';
import 'package:themoviedb/feature/domain/usecases/search_film.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchFilm) : super(SearchInitial());
  final SearchFilm searchFilm;
  String query = '';

  void findFilms() async {
    if (query == '' || query.isEmpty || query.length == 1) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoadingState());
    final failureOrFilms =
        await searchFilm(params: SearchFilmParams(query: query));
    failureOrFilms.fold(
      (failure) {
        emit(SearchErrorState(message: messageOfFailure(failure)));
        log('error: ${failure.toString}');
      },
      (films) {
        emit(SearchLoadedState(foundFilms: films));
      },
    );

    log(state.runtimeType.toString());
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
