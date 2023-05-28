import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waist_app/constants/colors.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  String text;
  Function() onPressed;
  AppButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 45.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: BC.appColor,
        ),
        child: Center(
          child: Text(text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
