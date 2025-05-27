import 'package:flutter/material.dart';
import 'package:kredipal/constant/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color backgroundColor;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor = AppColor.appBarColor,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: showBackButton,
      actions: actions,
      elevation: 4,
      shadowColor: Colors.black26,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
