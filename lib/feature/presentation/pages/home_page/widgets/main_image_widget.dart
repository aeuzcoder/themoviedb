import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themoviedb/core/constants.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';
import 'package:themoviedb/feature/presentation/pages/film_page/film_page.dart';
import 'package:themoviedb/core/colors.dart';
import 'package:themoviedb/feature/presentation/widgets/rating_films_widget.dart';

class MainImageWidget extends StatelessWidget {
  const MainImageWidget({super.key, required this.film});
  final FilmEntity? film;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        film == null
            ? Shimmer.fromColors(
                baseColor: bgColor,
                highlightColor: widgetColor.withOpacity(0.5),
                child: Container(
                  width: size.width,
                  height: size.height / 2,
                  color: bgColor,
                ),
              )
            : CachedNetworkImage(
                imageUrl: '$HTTP_IMAGE${film!.backdropPath}',
                width: size.width,
                height: size.height / 2,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 100),
                fadeOutDuration: const Duration(milliseconds: 100),
              ),

        //Gradient top
        Container(
          width: size.width,
          height: 200,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              bgColor,
              Colors.transparent,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),

        //Gradient bottom
        Container(
          width: size.width,
          height: size.height / 2,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              bgColor,
              Colors.transparent,
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),

        //  TOP OF THE WEEK
        SizedBox(
          height: size.height / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  'TOP OF THE WEEK',
                  style: GoogleFonts.raleway(
                      color: fontColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),

              //FILM NAME
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilmPage(
                      film: film,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          film == null ? '' : film!.title,
                          style: GoogleFonts.raleway(
                              color: fontColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        ),
                        RatingFilmsWidget(
                          fontSize: 20,
                          film: film,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
