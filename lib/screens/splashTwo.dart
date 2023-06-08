import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:waist_app/screens/auth/login.dart';
import 'package:waist_app/widgets/button.dart';

import '../constants/colors.dart';
import '../widgets/logo.dart';

class SplashTwo extends StatefulWidget {
  const SplashTwo({super.key});

  @override
  State<SplashTwo> createState() => _SplashOneState();
}

class _SplashOneState extends State<SplashTwo> {
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
          const LogoConatiner(),
          SizedBox(
            height: 25.h,
          ),
          const Image(
            image: AssetImage('assets/Finance insurance.png'),
          ),
          const SizedBox(
            height: 20,
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
                  'هو وسيط مالي يحمي المشتري والبائع عن طريق تحصيل الأموال وحفظها  الي ان يتم تسليم وفحص المنتج',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                MyButton(
                  name: 'التالي',
                  onPressed: () {
                    Get.offAll(() => const Login());
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
