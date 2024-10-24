import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/feature/presentation/pages/home_page/home_page.dart';
import 'package:themoviedb/feature/presentation/pages/profile_page/profile_page.dart';
import 'package:themoviedb/feature/presentation/pages/search_page/search_page.dart';
import 'package:themoviedb/core/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      //NAV BAR
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: viewInsets == 0
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: CrystalNavigationBar(
                paddingR: const EdgeInsets.symmetric(horizontal: 12),
                currentIndex: index,
                indicatorColor: fontColor,
                unselectedItemColor: Colors.white.withOpacity(0.8),
                selectedItemColor: fontColor,
                onTap: (value) {
                  setState(() {
                    index = value;
                  });
                },
                backgroundColor: Colors.transparent,
                items: [
                  CrystalNavigationBarItem(
                    icon: Icons.home,
                  ),
                  CrystalNavigationBarItem(icon: Icons.search),
                  CrystalNavigationBarItem(icon: Icons.person),
                ],
              ),
            )
          : null,

      body: <Widget>[
        const HomePage(),
        const SearchPage(),
        const ProfilePage()
      ][index],
    );
  }
}
