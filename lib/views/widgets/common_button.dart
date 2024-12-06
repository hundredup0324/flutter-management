import 'package:flutter/material.dart';
import 'package:project_management/utils/app_color.dart';

class CommonButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;

  CommonButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height:50,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            title!,
            style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
