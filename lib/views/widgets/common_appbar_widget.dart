// ignore_for_file: prefer_const_constructors


import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_management/utils/app_color.dart';
import 'package:project_management/utils/ui_text_style.dart';
import 'package:project_management/views/widgets/common_space_divider_widget.dart';
import 'package:project_management/views/widgets/icon_and_image.dart';

import '../../utils/image_path.dart';


Widget simpleAppBar({String? title}) {
  return Container(
    width: Get.height,
    height: 70,
    decoration: BoxDecoration(
      color: AppColor.cGrey,
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(22),
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    child: Text(
      title!,
      style: pSemiBold23.copyWith(color: AppColor.cFont),
    ),
  );
}

Container myAppBar({required String title}) {
  return Container(
    width: Get.width,
    color: AppColor.themeGreenColor,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    child: Row(children: [
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: assetSvdImageWidget(image: ImagePath.backIcn, height: 32, width: 32),
      ),
      horizontalSpace(16),
      Text(
        title,
        style: pSemiBold18.copyWith(color: AppColor.cWhite),
      ),
    ]),
  );
}
