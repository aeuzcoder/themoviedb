import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themoviedb/core/colors.dart';
import 'package:themoviedb/core/constants.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';
import 'package:themoviedb/feature/presentation/pages/film_page/film_page.dart';
import 'package:themoviedb/feature/presentation/pages/film_page/film_page_language.dart';
import 'package:themoviedb/feature/presentation/widgets/rating_films_widget.dart';

class SearchTileWidget extends StatelessWidget {
  const SearchTileWidget({super.key, required this.film});
  final FilmEntity? film;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24, top: 12),
      child: Container(
        height: 120,
        width: size.width,
        decoration: BoxDecoration(
          color: widgetColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),

        //ROW
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilmPage(
                film: film,
              ),
            ),
          ),
          child: Row(
            children: [
              //IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 80,
                  height: 120,
                  child: CachedNetworkImage(
                    imageUrl: '$HTTP_IMAGE${film?.posterPath}',
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 0),
                    fadeOutDuration: const Duration(milliseconds: 0),
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: widgetColor.withOpacity(0.05),
                      child: const Icon(
                        Icons.image,
                        color: bgColor,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),

              //TITLE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //TITLE
                    SizedBox(
                      width: size.width - 192,
                      child: Text(
                        film == null ? '' : film!.title.toUpperCase(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.raleway(
                          color: fontColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // RATING
                    RatingFilmsWidget(
                      film: film,
                      fontSize: 16,
                    ),

                    //REALEASE DATA
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          film == null ? '' : film!.releaseData,
                          style: GoogleFonts.agdasima(
                            fontWeight: FontWeight.bold,
                            color: widgetColor,
                          ),
                        ),
                        Text(
                          '           ${film == null ? '' : FilmPageLanguage.getLanguageName(film!.originalLanguage)}',
                          style: GoogleFonts.agdasima(
                            fontWeight: FontWeight.bold,
                            color: widgetColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
