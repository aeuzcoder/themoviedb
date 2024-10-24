import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themoviedb/feature/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:themoviedb/core/colors.dart';
import 'package:themoviedb/feature/presentation/pages/search_page/widgets/search_bar_widget.dart';
import 'package:themoviedb/feature/presentation/pages/search_page/widgets/search_tile_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            const SearchBarWidget(),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'Search Films',
                        style: GoogleFonts.raleway(
                          fontSize: 28,
                          color: widgetColor,
                        ),
                      ),
                    ),
                  );
                }
                if (state is SearchErrorState) {
                  return Center(
                    child: Text(
                      state.message,
                      style: GoogleFonts.raleway(fontSize: 28),
                    ),
                  );
                }
                if (state is SearchLoadingState) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: widgetColor,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                }
                if (state is SearchLoadedState) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.foundFilms.length + 1,
                      itemBuilder: (context, index) {
                        if (index == state.foundFilms.length) {
                          return const SizedBox(height: 160);
                        } else if (state.foundFilms[index].posterPath == '') {
                          return const SizedBox();
                        } else {
                          final film = state.foundFilms[index];
                          return SearchTileWidget(
                            film: film,
                          );
                        }
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'ERROR',
                      style: GoogleFonts.raleway(
                        fontSize: 28,
                        color: widgetColor,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
