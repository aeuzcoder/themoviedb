import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themoviedb/core/constants.dart';
import 'package:themoviedb/core/title_categories.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';
import 'package:themoviedb/feature/presentation/pages/home_page/widgets/end_of_films.dart';
import 'package:themoviedb/feature/presentation/pages/list_films_page/list_films_page.dart';
import 'package:themoviedb/feature/presentation/widgets/film_shape.dart';
import 'package:themoviedb/core/colors.dart';

class FilmsViewWidget extends StatelessWidget {
  const FilmsViewWidget(
      {super.key,
      required this.filmCategory,
      required this.isLoading,
      required this.films});
  final FilmCategory filmCategory;
  final bool isLoading;
  final List<FilmEntity>? films;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                titleOfFilms(filmCategory),
                style: GoogleFonts.raleway(
                  color: fontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListFilmsPage(
                      filmCategory: filmCategory,
                    ),
                  )),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'ALL',
                  style: GoogleFonts.agdasima(
                    color: Colors.red.shade300,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            height: 216,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: films == null ? 10 : films!.length + 1,
              itemBuilder: (context, index) {
                if (films != null && films!.length == index) {
                  return EndOfFilms(
                    filmCategory: filmCategory,
                  );
                } else {
                  return isLoading
                      ? Shimmer.fromColors(
                          baseColor: bgColor,
                          highlightColor: widgetColor.withOpacity(0.5),
                          child: FilmShape(
                            leftPadding: 12,
                            width: 144,
                            height: 216,
                            film: isLoading ? null : films![index],
                          ),
                        )
                      : FilmShape(
                          leftPadding: 12,
                          width: 144,
                          height: 216,
                          film: isLoading ? null : films![index],
                        );
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }
}
