import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:waist_app/constants/colors.dart';

// ignore: must_be_immutable
class Loading extends StatelessWidget {
  String text;
   Loading({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150.h,
        width: 200.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.inkDrop(
                size: 50,
                color: BC.appColor,
              ),
              SizedBox(
                height: 25.h,
              ),
               Text(text),
            ],
          ),
        ));
  }
}
