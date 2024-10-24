import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themoviedb/core/constants.dart';
import 'package:themoviedb/feature/presentation/cubit/film_cubit/film_cubit.dart';
import 'package:themoviedb/feature/presentation/cubit/film_cubit/film_state.dart';
import 'package:themoviedb/feature/presentation/pages/home_page/widgets/films_view_widget.dart';
import 'package:themoviedb/feature/presentation/pages/home_page/widgets/main_image_widget.dart';
import 'package:themoviedb/core/colors.dart';
import 'package:themoviedb/feature/presentation/widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: bgColor,

      //APP BAR
      appBar: CustomAppBar(
        appBarChild: Text(
          'TATU CINEMA',
          style: GoogleFonts.raleway(fontWeight: FontWeight.w600),
        ),
        leadingChild: const Icon(Icons.menu),
      ),
      body: BlocBuilder<FilmCubit, FilmState>(
        builder: (context, state) {
          if (state is FilmLoadingState) {
            return const SafeArea(
              //  MAIN PADDING
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  TOP FILM
                      MainImageWidget(
                        film: null,
                      ),

                      //CATEGORIES
                      //  FILMS
                      FilmsViewWidget(
                        filmCategory: FilmCategory.topFilms,
                        isLoading: true,
                        films: null,
                      ),
                      FilmsViewWidget(
                        filmCategory: FilmCategory.allFilms,
                        isLoading: true,
                        films: null,
                      ),
                      FilmsViewWidget(
                        filmCategory: FilmCategory.topAnimations,
                        isLoading: true,
                        films: null,
                      ),
                      FilmsViewWidget(
                        filmCategory: FilmCategory.series,
                        isLoading: true,
                        films: null,
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is FilmLoadedState) {
            final randomFilm = state.films[FilmCategory.topFilms]![
                Random().nextInt(state.films.length)];

            return SafeArea(
              //  MAIN PADDING
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  TOP FILM
                      MainImageWidget(
                        film: randomFilm,
                      ),

                      //CATEGORIES
                      //  FILMS
                      FilmsViewWidget(
                        filmCategory: FilmCategory.topFilms,
                        isLoading: false,
                        films: state.films[FilmCategory.topFilms],
                      ),
                      FilmsViewWidget(
                        filmCategory: FilmCategory.allFilms,
                        isLoading: false,
                        films: state.films[FilmCategory.allFilms],
                      ),
                      FilmsViewWidget(
                        filmCategory: FilmCategory.topAnimations,
                        isLoading: false,
                        films: state.films[FilmCategory.topAnimations],
                      ),
                      FilmsViewWidget(
                        filmCategory: FilmCategory.series,
                        isLoading: false,
                        films: state.films[FilmCategory.series],
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is FilmErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'UNEXPECTED ERROR',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
