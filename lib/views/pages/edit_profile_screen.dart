import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management/core/controllers/edit_profile_controller.dart';
import 'package:project_management/utils/app_color.dart';
import 'package:project_management/utils/app_constant.dart';
import 'package:project_management/utils/common_snackbar_widget.dart';
import 'package:project_management/utils/image_path.dart';
import 'package:project_management/utils/prefer.dart';
import 'package:project_management/utils/ui_text_style.dart';
import 'package:project_management/utils/validator.dart';
import 'package:project_management/views/widgets/common_button.dart';
import 'package:project_management/views/widgets/common_space_divider_widget.dart';
import 'package:project_management/views/widgets/common_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileController profileController = Get.put(EditProfileController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.cWhite,
      appBar: AppBar(
        backgroundColor: AppColor.darkGreen,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => {
            Get.back(result: {
              "profileImage": Prefs.getString(AppConstant.profileImage)
            })
          },
        ),
        title: Text(
          "Edit Profile".tr,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColor.cWhite),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: SingleChildScrollView(
          child: Obx(
            () => Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: const Color(0xFFF3F3F3),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.transparent,
                          backgroundImage: profileImage(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16))),
                            builder: (context) {
                              return Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16))),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    imageWidget(
                                        title: "Camera".tr,
                                        iconData: Icons.camera_alt,
                                        imageSource: ImageSource.camera),
                                    horizontalSpace(35),
                                    imageWidget(
                                        title: "Gallery".tr,
                                        iconData: Icons.photo,
                                        imageSource: ImageSource.gallery),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColor.darkGreen,
                          child: Icon(Icons.camera_alt,
                              size: 18, color: AppColor.primaryColor),
                        ),
                      )
                    ],
                  ),
                  verticalSpace(20),
                  CommonTextField(
                    prefix: ImagePath.userEdit,
                    controller: profileController.nameController,
                    keyboardType: TextInputType.text,
                    labelText: "Name".tr,
                    validator: (value) {
                      return Validator.validateName(value!, "Name");
                    },
                  ),
                  verticalSpace(20),
                  CommonTextField(
                    prefix: ImagePath.emailIcn,
                    controller: profileController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: "Email".tr,
                    validator: (value) {
                      return Validator.validateEmail(value!);
                    },
                  ),
                  verticalSpace(20),
                  CommonTextField(
                    prefix: ImagePath.phoneIcn,
                    controller: profileController.phoneController,
                    keyboardType: TextInputType.phone,
                    labelText: "Phone".tr,
                    validator: (value) {
                      return Validator.validateMobile(value!);
                    },
                  ),
                  verticalSpace(20),
                  CommonButton(
                    title: "Save Changes".tr,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (Prefs.getBool(AppConstant.isDemoMode) == true) {
                          commonToast(AppConstant.demoString);
                        } else {
                          profileController.saveProfileData(
                              email:
                                  profileController.emailController.text.trim(),
                              name:
                                  profileController.nameController.text.trim(),
                              phoneNo:
                                  profileController.phoneController.text.trim(),
                              avatar: profileController.imagePath.value);
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  ImageProvider profileImage() {
    return profileController.imagePath.value.isNotEmpty
        ? FileImage(File(profileController.imagePath.value))
        : Image(
                image: profileController.profileImage.value.isNotEmpty
                    ? CachedNetworkImageProvider(
                        profileController.profileImage.value)
                    : AssetImage(ImagePath.placeholder) as ImageProvider)
            .image;
  }

  Widget imageWidget(
      {ImageSource? imageSource, String? title, IconData? iconData}) {
    return GestureDetector(
      onTap: () {
        profileController.pickImage(imageSource: imageSource!);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, color: AppColor.cDarkGreyFont, size: 55),
          verticalSpace(8),
          Text(title!,
              style: pSemiBold19.copyWith(color: AppColor.cDarkGreyFont))
        ],
      ),
    );
  }
}
