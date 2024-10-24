import 'package:flutter/material.dart';
import 'package:themoviedb/core/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, required this.appBarChild, required this.leadingChild});
  final Widget? appBarChild;
  final Widget? leadingChild;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
      child: AppBar(
        leading: leadingChild,
        centerTitle: true,
        title: appBarChild,
        backgroundColor: bgColor,
        foregroundColor: widgetColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
