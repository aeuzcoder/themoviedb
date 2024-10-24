import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themoviedb/core/constants.dart';
import 'package:themoviedb/feature/presentation/pages/list_films_page/list_films_page.dart';
import 'package:themoviedb/core/colors.dart';

class EndOfFilms extends StatelessWidget {
  const EndOfFilms({super.key, required this.filmCategory});
  final FilmCategory filmCategory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 216,
      width: 154,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListFilmsPage(
                              filmCategory: filmCategory,
                            )));
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: bgColorLighter,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: fontColor,
                  size: 28,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Show all',
                style: GoogleFonts.raleway(
                    color: fontColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
