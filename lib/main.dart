import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/routes/app_pages.dart';
import 'package:kredipal/routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.appPages,
    );
  }
}
