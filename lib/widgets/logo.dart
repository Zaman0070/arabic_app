import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class LogoConatiner extends StatelessWidget {
  const LogoConatiner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.h,
      height: 150.h,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage(
                'assets/logo.jpeg',
              ),
              fit: BoxFit.cover),
          color: BC.logo_clr,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xff707070))),
    );
  }
}
