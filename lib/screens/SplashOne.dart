import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:waist_app/screens/splashTwo.dart';
import 'package:waist_app/widgets/button.dart';

import '../constants/colors.dart';
import '../widgets/logo.dart';

class SplashOne extends StatefulWidget {
  @override
  State<SplashOne> createState() => _SplashOneState();
}

class _SplashOneState extends State<SplashOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/background.png',
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          LogoConatiner(),
          SizedBox(
            height: 25.h,
          ),
          const Image(
            image: AssetImage('assets/greeting.png'),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: BC.appColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  'وسيط نبني الثقة في كل معاملة بين الطرفين البائع و المشتري علي الأنترنت',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                MyButton(
                  name: 'التالي',
                  onPressed: () {
                    Get.to(() => SplashTwo());
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
