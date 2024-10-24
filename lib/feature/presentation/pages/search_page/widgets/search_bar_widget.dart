import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themoviedb/core/colors.dart';
import 'package:themoviedb/feature/presentation/cubit/search_cubit/search_cubit.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final searchCubit = context.read<SearchCubit>();
    controller = TextEditingController(text: searchCubit.query);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: widgetColor, width: 0.8),
            color: bgColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: TextField(
                controller: controller,
                onChanged: (query) {
                  searchCubit.query = controller.text;
                  searchCubit.findFilms();
                },
                style: GoogleFonts.raleway(color: fontColor, fontSize: 24),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: GoogleFonts.raleway(
                      color: widgetColor.withOpacity(0.6), fontSize: 22),
                ),
              ),
            ),
          )),
    );
  }
}
