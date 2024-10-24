import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:themoviedb/core/constants.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';
import 'package:themoviedb/feature/presentation/pages/film_page/film_page.dart';
import 'package:themoviedb/core/colors.dart';

class FilmShape extends StatelessWidget {
  const FilmShape({
    super.key,
    required this.leftPadding,
    required this.height,
    required this.width,
    required this.film,
  });
  final double leftPadding;
  final double width;
  final double height;
  final FilmEntity? film;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: leftPadding,
        right: 0,
        top: 0,
        bottom: 0,
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilmPage(
                film: film,
              ),
            )),
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(),
          child: film == null
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: widgetColor,
                )
              : CachedNetworkImage(
                  fadeInDuration: const Duration(milliseconds: 0),
                  fadeOutDuration: const Duration(milliseconds: 0),
                  imageUrl: '$HTTP_IMAGE${film!.posterPath}',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: widgetColor.withOpacity(0.05),
                    child: const Icon(
                      Icons.image,
                      color: bgColor,
                      size: 32,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
