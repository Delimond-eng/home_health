import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:home_health/controllers/auth_controller.dart';
import 'package:home_health/controllers/data_controller.dart';
import './views/screens/starting_screen.dart';

void main() async {
  Get.put(AuthController());
  Get.put(DataController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Home Health App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: const Color(0xFFeaeaea),
        fontFamily: 'Poppins',
      ),
      home: Builder(builder: (context) => const StartingScreen()),
      builder: EasyLoading.init(),
    );
  }
}
