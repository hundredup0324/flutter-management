// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_management/utils/app_color.dart';
import 'package:project_management/utils/app_constant.dart';
import 'package:project_management/utils/prefer.dart';
import 'package:project_management/views/pages/dashboard_screen.dart';
import 'package:project_management/views/pages/login_screen.dart';


GetStorage? getStorage;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  getStorage = GetStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    String languageCode = Prefs.getString(AppConstant.LANGUAGE_CODE) == ''
        ? 'en'
        : Prefs.getString(AppConstant.LANGUAGE_CODE);
    String countryCode = Prefs.getString(AppConstant.LANGUAGE_CODE) == 'ar' ? 'AR' : 'US';
    Locale locale = Locale(languageCode, countryCode);

    getToken() async {
      await dotenv.load(fileName: "asset/.env");
      String isDemoMode = dotenv.get(AppConstant.isDemoMode);
      Prefs.setBool(AppConstant.isDemoMode, bool.parse(isDemoMode));
      String accessToken = Prefs.getToken();
      print("accessToken$accessToken");
      return accessToken;
    }

    return GetMaterialApp(
      title: 'Project Management',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
          fontFamily: "Poppins",
          useMaterial3: true,
          dialogBackgroundColor: AppColor.cWhite,
          dialogTheme: DialogTheme(backgroundColor: AppColor.cWhite)),
      home:  FutureBuilder(
          future: getToken(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data != '') {
              return DashBoardScreen();
            } else {
              return LoginScreen();
            }
          }),
    );
  }
}

