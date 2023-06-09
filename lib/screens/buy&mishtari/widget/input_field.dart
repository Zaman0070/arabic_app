import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waist_app/constants/colors.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  TextEditingController controller;
  String title;
  String hinttext;
  Color color;
  TextInputType type;
  bool calender;
  Function()? calenderFunction;
  InputField(
      {super.key,
      required this.controller,
      required this.title,
      required this.type,
      required this.color,
      required this.hinttext,
      required this.calender,
      this.calenderFunction});

  @override
  Widget build(BuildContext context) {
    return Stack(
      // overflow: Overflow.visible,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: BC.appColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: type,
            textAlign: TextAlign.right,
            validator: (val) {
              if (val!.isEmpty) {
                return "Required";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              contentPadding: calender ? EdgeInsets.only(top: 15) : null,
              prefixIcon: calender
                  ? IconButton(
                      icon: CircleAvatar(
                        radius: 12.h,
                        backgroundColor: BC.appColor,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Icon(Icons.arrow_back_ios,
                                size: 12.h, color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: calenderFunction)
                  : null,
              hintText: hinttext,
              border: InputBorder.none,
            ),
          ),
        ),
        Positioned(
          right: 15,
          top: -11,
          child: Container(
              color: color,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  title,
                  style: TextStyle(color: BC.appColor),
                ),
              )),
        )
      ],
    );
  }
}
