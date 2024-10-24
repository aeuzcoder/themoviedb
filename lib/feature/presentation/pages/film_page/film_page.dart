import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';
import 'package:themoviedb/feature/presentation/pages/film_page/widgets/film_image_widget.dart';
import 'package:themoviedb/core/colors.dart';

class FilmPage extends StatelessWidget {
  const FilmPage({super.key, required this.film});
  final FilmEntity? film;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Top
            FilmImageWidget(film: film),

            //Overview
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                        color: fontColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  Text(
                    // ignore: unnecessary_string_escapes
                    film == null ? '' : '\n${film!.overview}',
                    style: GoogleFonts.raleway(color: fontColor, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
