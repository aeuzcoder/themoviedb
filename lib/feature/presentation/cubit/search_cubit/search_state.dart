part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoadingState extends SearchState {}

final class SearchErrorState extends SearchState {
  final String message;

  const SearchErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

final class SearchLoadedState extends SearchState {
  final List<FilmEntity> foundFilms;

  const SearchLoadedState({required this.foundFilms});
  @override
  List<Object> get props => [foundFilms];
}
