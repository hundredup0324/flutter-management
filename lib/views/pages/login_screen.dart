import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_management/core/controllers/login_controller.dart';
import 'package:project_management/utils/app_color.dart';
import 'package:project_management/utils/app_constant.dart';
import 'package:project_management/utils/image_path.dart';
import 'package:project_management/utils/prefer.dart';
import 'package:project_management/utils/validator.dart';
import 'package:project_management/views/pages/dashboard_screen.dart';
import 'package:project_management/views/widgets/common_button.dart';
import 'package:project_management/views/widgets/common_space_divider_widget.dart';
import 'package:project_management/views/widgets/common_text_field.dart';
import 'package:project_management/views/widgets/icon_and_image.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    return Scaffold(
      backgroundColor: AppColor.cWhite,
      body: Obx(
        () => SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    height: 215,
                    color: AppColor.darkGreen,
                    child: Center(
                      child: Image.asset(
                          "asset/image/png_image/login_illustration.png",
                          height: 150),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                    decoration: BoxDecoration(
                      color: AppColor.cWhite,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Welcome Back !.".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColor.cLabel,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              wordSpacing: 2.0),
                        ),
                        verticalSpace(10),
                        Text(
                          "Welcome to Your Project Hub: Let's Get Started".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.cLabel,
                            fontSize: 14,
                          ),
                        ),
                        verticalSpace(20),
                        CommonTextField(
                          controller: loginController.emailController,
                          labelText: 'Email',
                          hintText: "Enter Email".tr,
                          prefix: ImagePath.emailIcn,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            Validator.validateEmail(value);
                          },
                          validator: (value) {
                            return Validator.validateEmail(value!);
                          },
                        ),
                        verticalSpace(16),
                        CommonTextField(
                          controller: loginController.passwordController,
                          labelText: "Password".tr,
                          hintText: "Enter Password".tr,
                          prefix: ImagePath.lockIcn,
                          obscureText: loginController.isHiddenPassword.value,
                          obscuringCharacter: "*",
                          onChanged: (value) {
                            Validator.validatePassword(value);
                          },
                          validator: (value) {
                            return Validator.validatePassword(value!);
                          },
                          suffix: GestureDetector(
                            onTap: () {
                              loginController.isHiddenPassword.value =
                                  !loginController.isHiddenPassword.value;
                            },
                            child: Icon(
                              loginController.isHiddenPassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColor.cDarkGreyFont,
                            ),
                          ),
                        ),
                        verticalSpace(40),
                        CommonButton(
                            title: "Login",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                                  Get.offAll(() =>  DashBoardScreen());
                                } else {
                                  loginController.authLogin(
                                      email: loginController.emailController.text,
                                      password: loginController
                                          .passwordController.text);
                                }
                              }
                            })
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
