import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waist_app/constants/colors.dart';

// ignore: must_be_immutable
class InputFields extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  Function()? onTap;
  Widget? child;
  InputFields(
      {super.key,
      required this.controller,
      required this.hintText,
      this.child,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          SizedBox(
            height: 45.h,
            width: 0.67.sw,
            child: TextFormField(
              cursorColor: BC.appColor,
              style: TextStyle(color: BC.white),
              controller: controller,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 10, right: 10.w),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: BC.appColor)),
                  hintText: hintText,
                  hintStyle: TextStyle(color: BC.grey)),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          InkWell(
            onTap: onTap,
            child: Container(
                height: 45.h,
                width: 85.w,
                decoration: BoxDecoration(
                    color: BC.appColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'ارسال',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
