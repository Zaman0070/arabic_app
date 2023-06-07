import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waist_app/constants/colors.dart';

// ignore: must_be_immutable
class UploadImage extends StatelessWidget {
  Function() onTap;
  UploadImage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: BC.appColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child: Text(
            'تحميل صورة السلعة',
            style: TextStyle(
                color: BC.appColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp),
          )),
        ),
      ),
    );
  }
}
