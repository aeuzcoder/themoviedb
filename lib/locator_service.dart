import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:themoviedb/core/platform/network_info.dart';
import 'package:themoviedb/feature/data/datasources/local_data_sources.dart';
import 'package:themoviedb/feature/data/datasources/remote_data_sources.dart';
import 'package:themoviedb/feature/data/repositories/film_repositories_impl.dart';
import 'package:themoviedb/feature/domain/repositories/film_repositories.dart';
import 'package:themoviedb/feature/domain/usecases/get_films.dart';
import 'package:themoviedb/feature/domain/usecases/search_film.dart';

import 'package:http/http.dart' as http;
import 'package:themoviedb/feature/presentation/cubit/film_cubit/film_cubit.dart';
import 'package:themoviedb/feature/presentation/cubit/search_cubit/search_cubit.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //  Bloc / Cubit
  sl.registerFactory(() => FilmCubit(sl<GetFilms>()));
  sl.registerFactory(() => SearchCubit(sl<SearchFilm>()));

  //  Usecases
  sl.registerLazySingleton(() => GetFilms(filmRepositories: sl()));
  sl.registerLazySingleton(() => SearchFilm(filmRepositories: sl()));

  //  Repository
  sl.registerLazySingleton<FilmRepositories>(
    () => FilmRepositoriesImpl(
      remoteDataSources: sl(),
      localDataSources: sl(),
      networkInfo: sl(),
    ),
  );

  //  Data Sources

  sl.registerLazySingleton<RemoteDataSources>(
      () => RemoteDataSourcesImpl(client: sl()));

  sl.registerLazySingleton<LocalDataSources>(
      () => LocalDataSourcesImpl(sharedPreferences: sl()));

  //  Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));

  //  External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
