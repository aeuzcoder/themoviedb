// ignore_for_file: unnecessary_string_escapes

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themoviedb/core/colors.dart';
import 'package:themoviedb/feature/presentation/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  Future<void> urlLaunch(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      log('Не удалось открыть $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarChild: Text(
          'PROFILE',
          style: GoogleFonts.raleway(fontWeight: FontWeight.w600),
        ),
        leadingChild: null,
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: ClipOval(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: widgetColor.withOpacity(0.1),
                    ),
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/ae_coder.jpeg',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: 200,
                          height: 200,
                          decoration:
                              BoxDecoration(color: bgColor.withOpacity(0.25)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Text(
              'ABDURAHMON\nERGASHEV',
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                color: widgetColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      urlLaunch('https://t.me/ae_coder');
                    },
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset('assets/logo/telegram.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      urlLaunch('https://github.com/aeuzcoder');
                    },
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset('assets/logo/github.png'),
                    ),
                  )
                ],
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              'Clean Architecture, Cubit,\nRest API, Local Data',
              style: GoogleFonts.raleway(
                color: widgetColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
