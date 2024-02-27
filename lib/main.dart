import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_health/controllers/auth_controller.dart';
import 'package:home_health/controllers/data_controller.dart';
import 'package:home_health/views/main/doctor/index.dart';
import 'package:home_health/views/main/nurse/index.dart';
import './views/screens/starting_screen.dart';
import 'controllers/nurse_data_controller.dart';
import 'global/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(AuthController());
  Get.put(DataController());
  Get.put(NurseDataController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Home Health App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: const Color(0xFFeaeaea),
        fontFamily: 'Poppins',
      ),
      home: Builder(
        builder: (context) {
          if (storage.read("user-data") == null) {
            return const StartingScreen();
          } else {
            if (storage.read("user-data")["profile"] == "doctor") {
              return const DoctorHome();
            } else {
              return const NurseHome();
            }
          }
        },
      ),
      builder: EasyLoading.init(),
    );
  }
}
