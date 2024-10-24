import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themoviedb/core/colors.dart';
import 'package:themoviedb/core/constants.dart';
import 'package:themoviedb/core/title_categories.dart';
import 'package:themoviedb/feature/domain/entities/film_entities.dart';
import 'package:themoviedb/feature/domain/usecases/get_films.dart';
import 'package:themoviedb/feature/presentation/cubit/film_cubit/film_cubit.dart';
import 'package:themoviedb/feature/presentation/widgets/custom_app_bar.dart';
import 'package:themoviedb/feature/presentation/widgets/film_shape.dart';

class ListFilmsPage extends StatefulWidget {
  const ListFilmsPage({super.key, required this.filmCategory});
  final FilmCategory filmCategory;

  @override
  State<ListFilmsPage> createState() => _ListFilmsPageState();
}

class _ListFilmsPageState extends State<ListFilmsPage> {
  final scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    setupScrollController(context);
  }

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          page++;
          context.read<FilmCubit>().loadCategory(
              GetFilmsParams(page: page, filmCategory: widget.filmCategory));
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<FilmEntity> films =
        context.read<FilmCubit>().oldFilms[widget.filmCategory] ?? [];

    return Scaffold(
      appBar: CustomAppBar(
          appBarChild: Text(
            titleOfFilms(widget.filmCategory),
            style: GoogleFonts.raleway(
              color: widgetColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          leadingChild: null),
      backgroundColor: bgColor,
      body: RawScrollbar(
        thumbColor: widgetColor,
        thickness: 6,
        minThumbLength: 32,
        controller: scrollController,
        scrollbarOrientation: ScrollbarOrientation.right,
        thumbVisibility: true,
        trackVisibility: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable internal scrolling
                  itemCount: films.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10, // Количество столбцов в сетке
                      mainAxisSpacing: 0.0, // Расстояние между строками
                      childAspectRatio: 0.55),
                  itemBuilder: (context, index) {
                    final film = films[index];
                    return SizedBox(
                      width: 192,
                      height: 256,
                      child: Column(
                        children: [
                          FilmShape(
                              leftPadding: 0,
                              height: 256,
                              width: 192,
                              film: film),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 2.0, bottom: 12),
                            child: SizedBox(
                              width: 192,
                              child: Center(
                                child: Text(
                                  film.title.toUpperCase(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.raleway(
                                    color: fontColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                // Add the SizedBox at the bottom
                const SizedBox(
                  height: 400,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: widgetColor,
                      strokeWidth: 2,
                    ),
                  ), // Adjust the height as needed
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
