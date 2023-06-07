import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class ArrowButton extends StatelessWidget {
  final Function()? onPressed;
  ArrowButton({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 30.h,
        height: 30.h,
        decoration: BoxDecoration(
            color: BC.appColor, borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ));
  }
}
