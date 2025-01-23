import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StoryMate',
      // initialRoute: AppRoutes.HOME,
      initialRoute: '/book_intro',
      getPages: AppRoutes.routes,
    );
  }
}
