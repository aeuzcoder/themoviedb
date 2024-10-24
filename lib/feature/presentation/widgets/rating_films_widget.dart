import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';

class RatingFilmsWidget extends StatelessWidget {
  const RatingFilmsWidget(
      {super.key, required this.fontSize, required this.film});
  final double fontSize;
  final FilmEntity? film;

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = film == null;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Rating:',
          style: GoogleFonts.agdasima(
            color: Colors.yellow.shade200,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
        Text(
          isEmpty ? '' : '   ${film!.voteAverage}',
          style: GoogleFonts.agdasima(
              color: Colors.yellow.shade200, fontSize: fontSize + 2),
        ),
        Text(
          ' ⭐️',
          style: GoogleFonts.agdasima(
              color: Colors.yellow.shade200, fontSize: fontSize - 4),
        ),
        Text(
          isEmpty ? '' : '   ${film!.voteCount}0',
          style: GoogleFonts.agdasima(
              color: Colors.yellow.shade200, fontSize: fontSize + 2),
        ),
      ],
    );
  }
}
