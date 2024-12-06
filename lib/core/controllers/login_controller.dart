import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management/core/model/login_response.dart';
import 'package:project_management/network/network_dio.dart';
import 'package:project_management/utils/app_constant.dart';
import 'package:project_management/utils/base_api.dart';
import 'package:project_management/utils/common_snackbar_widget.dart';
import 'package:project_management/utils/prefer.dart';
import 'package:project_management/views/widgets/loading_widget.dart';

import '../../views/pages/dashboard_screen.dart';

String defaultLanguageCode = Prefs.getString(AppConstant.LANGUAGE_CODE) == '' ? 'en' : Prefs.getString(AppConstant.LANGUAGE_CODE);

class  LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxList workSpaceList=<Workspace>[].obs;
  RxBool isHiddenPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (Prefs.getBool(AppConstant.isDemoMode) == true) {
      emailController.text = 'admin@example.com';
      passwordController.text = '1234';
    } else {
      emailController.clear();
      passwordController.clear();
    }

  }
  authLogin({required String email, required String password}) async {
    Loader.showLoader();
    var response =await  NetworkHttps.postRequest(API.loginLink,{'email': email, 'password': password});
    if(response['status']==1)
    {
      var loginResponse =LoginResponse.fromJson(response);
      print("workspace ${jsonDecode(loginResponse.data!.workspaces!.length.toString())}");
      workSpaceList.value=loginResponse.data!.workspaces!;
      print("workspace1 ${jsonDecode(workSpaceList.length.toString())}");
      Prefs.setString(AppConstant.workSpaceArray, jsonEncode(loginResponse.data!.workspaces!));
      Prefs.setToken(loginResponse.data!.token??"");
      Prefs.setUserID(loginResponse.data!.user!.id.toString());
      Prefs.setString(AppConstant.userName, loginResponse.data!.user!.name??"");
      Prefs.setString(AppConstant.emailId,loginResponse.data!.user!.email??"");
      Prefs.setString(AppConstant.phoneNo, loginResponse.data!.user!.mobileNo??"");
      Prefs.setString(AppConstant.profileImage, loginResponse.data!.user!.avatar??"");
      Prefs.setString(AppConstant.userType,loginResponse.data!.user!.type??"");
      Prefs.setString(AppConstant.workSpaceId,loginResponse.data!.user!.activeWorkspace.toString()??"");
      Get.offAll(() => const DashBoardScreen());
      commonToast(loginResponse.data!.user!.name ??"" " Login successfully");
      Loader.hideLoader();
    } else {
      Loader.hideLoader();
      commonToast(response["message"]);
    }
  }

}