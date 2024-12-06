// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:project_management/views/pages/home_screen.dart';
import 'package:project_management/views/pages/project/project_detail.dart';
import 'package:project_management/views/pages/project/project_screen.dart';
import 'package:project_management/views/pages/settings_screen.dart';

class DashboardController extends GetxController {
  RxInt currantIndex = 0.obs;
  List itemList = [
    {
      "icon": "asset/image/svg_image/ic_dashboard.svg",
      "screen": HomeScreen(),
      "title": "Dashboard",
    },
    {
      "icon": "asset/image/svg_image/ic_projects.svg",
      "screen": ProjectScreen(),
      "title": "Project"
    },
    {
      "icon": "asset/image/svg_image/ic_settings.svg",
      "screen": SettingsScreen(),
      "title": "Settings"
    },
  ];

  @override
  void onInit() {
    currantIndex = 0.obs;
    super.onInit();
  }
}
