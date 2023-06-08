import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:waist_app/screens/SplashOne.dart';
import 'package:waist_app/widgets/logo.dart';

import '../constants/colors.dart';

class OnBaording extends StatefulWidget {
  @override
  State<OnBaording> createState() => _OnBaordingState();
}

class _OnBaordingState extends State<OnBaording> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => SplashOne());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LogoConatiner(),
          const SizedBox(
            height: 20,
          ),
          Text(
            'وسيط نبني الثقة',
            style: TextStyle(
                fontSize: 25, color: BC.appColor, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ));
  }
}
