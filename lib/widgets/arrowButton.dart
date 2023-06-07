import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class ArrowButton extends StatelessWidget {
  final Function()? onPressed;
  const ArrowButton({super.key, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: BC.appColor,
        radius: 13.h,
        child: Padding(
          padding: const EdgeInsets.only(left: 2.5),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 16.h,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
