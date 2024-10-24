import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/feature/presentation/cubit/film_cubit/film_cubit.dart';
import 'package:themoviedb/feature/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:themoviedb/feature/presentation/pages/main_page.dart';
import 'package:themoviedb/core/colors.dart';
import 'package:themoviedb/locator_service.dart';
import 'locator_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: bgColor, statusBarIconBrightness: Brightness.light));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<FilmCubit>()..loadAllData(),
        ),
        BlocProvider(
          create: (context) => sl<SearchCubit>(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'THEMOVIEDB',
        home: MainPage(),
      ),
    );
  }
}
