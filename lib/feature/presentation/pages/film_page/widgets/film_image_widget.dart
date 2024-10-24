import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themoviedb/core/colors.dart';
import 'package:themoviedb/core/constants.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';
import 'package:themoviedb/feature/presentation/pages/film_page/film_page_language.dart';
import 'package:themoviedb/feature/presentation/widgets/rating_films_widget.dart';

class FilmImageWidget extends StatelessWidget {
  const FilmImageWidget({super.key, required this.film});
  final FilmEntity? film;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height / 2,
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                //  IMAGE
                SizedBox(
                  height: size.height / 2.4,
                  child: film == null
                      ? Container(
                          width: double.infinity,
                          height: size.height / 2.4,
                          color: bgColor,
                        )
                      : CachedNetworkImage(
                          imageUrl: '$HTTP_IMAGE${film!.backdropPath}',
                          fit: BoxFit.cover,
                          fadeInDuration: const Duration(milliseconds: 50),
                          fadeOutDuration: const Duration(milliseconds: 50),
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: bgColor,
                            highlightColor: widgetColor.withOpacity(0.1),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: widgetColor,
                            ),
                          ),
                        ),
                ),

                Container(
                  height: size.height / 2.4,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      bgColor,
                      Colors.transparent,
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  ),
                ),

                //  APPBAR
                AppBar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: fontColor,
                ),

                //Foreground
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Title
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          film == null ? '' : film!.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway(
                              color: fontColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 32),
                        ),
                      ),

                      //Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              RatingFilmsWidget(
                                fontSize: 20,
                                film: film,
                              ),

                              //DATA OF RELEASE
                              Row(
                                children: [
                                  Text(
                                    film == null
                                        ? ' '
                                        : ' ${film!.releaseData}',
                                    style: GoogleFonts.agdasima(
                                      fontWeight: FontWeight.bold,
                                      color: widgetColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    film == null
                                        ? ' '
                                        : '              ${FilmPageLanguage.getLanguageName(film!.originalLanguage)}',
                                    style: GoogleFonts.agdasima(
                                        fontWeight: FontWeight.bold,
                                        color: widgetColor,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
