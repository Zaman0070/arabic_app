import 'package:flutter/material.dart';

import '../constants/colors.dart';

class LogoConatiner extends StatelessWidget {
  const LogoConatiner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.33,
      height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/logo.jpeg',),
          ),
          color: BC.logo_clr,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xff707070))),
    );
  }
}
