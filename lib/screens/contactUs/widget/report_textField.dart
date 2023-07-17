import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/widgets/arrowButton.dart';
import 'package:waist_app/widgets/loading.dart';

// ignore: must_be_immutable
class ReportTextField extends StatelessWidget {
  ReportTextField({super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
      child: Column(children: [
        SizedBox(
          height: 12.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 40,
            ),
            Text(
              'مراسلة الادارة',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            ArrowButton(
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  height: 150.h,
                  width: 1.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: BC.appColor)),
                  child: TextFormField(
                    controller: _controller,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالتك هنا',
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        color: BC.appColor,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () async {
                  SmartDialog.showLoading(
                    animationBuilder: (controller, child, animationParam) {
                      return Loading(
                        text: ' ... تحميل ',
                      );
                    },
                  );
                  await FirebaseFirestore.instance.collection('complain').add({
                    'complain': _controller.text,
                    'date': DateTime.now().toString(),
                    'uid': FirebaseAuth.instance.currentUser!.uid,
                  });
                  SmartDialog.dismiss();
                  Get.back();
                },
                child: Container(
                  height: 40.h,
                  width: 1.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: BC.appColor,
                  ),
                  child: Center(
                    child: Text(
                      'ارسال',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    )));
  }
}
