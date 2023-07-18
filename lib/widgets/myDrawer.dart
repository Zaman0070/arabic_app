import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_view/flutter_file_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waist_app/screens/AboutUs.dart';
import 'package:waist_app/screens/auth/login.dart';
import 'package:waist_app/screens/calculator.dart';
import 'package:waist_app/screens/contactUs/contactUs.dart';
import 'package:waist_app/screens/howToUse.dart';
import 'package:waist_app/screens/chat/messages.dart';
import 'package:waist_app/screens/new_order/newOrder.dart';
import 'package:waist_app/screens/order/order.dart';
import 'package:waist_app/screens/privacy_policy/privacy_policy.dart';
import 'package:waist_app/screens/profile/profile.dart';
import 'package:waist_app/screens/wallet/wallet.dart';
import 'package:waist_app/widgets/button.dart';
import '../constants/colors.dart';
import '../screens/notification.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: BC.appColor,
      child: ListView(
        children: [
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: Container(
              height: 55.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Image.asset(
                'assets/logow.png',
                height: 60.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 30, left: 20),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => NewOrder());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'طلب جديد',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image(
                        image: const AssetImage(
                          'assets/Add.png',
                        ),
                        height: 22.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const Wallet());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'المحفظة',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image(
                        image: const AssetImage('assets/Wallet.png'),
                        height: 22.h,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const Messages());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'الدردشة',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image(
                        image: const AssetImage('assets/Chat.png'),
                        height: 22.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => Orders(
                          title: 'طلباتي',
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'طلباتي',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image(
                        image: const AssetImage('assets/Bag.png'),
                        height: 22.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const Profile());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'الملف الشخصي',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image(
                        image: const AssetImage('assets/Person.png'),
                        height: 22.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    _ButtonPressed(context);
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => viewcart()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'اللغة',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image(
                        image: const AssetImage('assets/Languaage.png'),
                        height: 22.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const NotificationsPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'اشعاراتي',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      const Icon(Icons.notifications,
                          color: Colors.white, size: 25)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Calculator()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'حساب العمولة',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      Image(
                        image: const AssetImage('assets/Calculator.png'),
                        height: 22.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () async {
                    Platform.isIOS
                        ? await launch(
                            'https://apps.apple.com/us/app/%D9%85%D8%B4%D8%AA%D8%B1%D9%8A/id1579563179')
                        : await launch(
                            'https://play.google.com/store/apps/details?id=com.mishtari.app');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'أراء العملاء',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image(
                        image: const AssetImage('assets/Users.png'),
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HowToUse()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'دليل الأستخدام (فيديو)',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image(
                        image: const AssetImage('assets/How to use.png'),
                        height: 22.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const PrivacyPolicy());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'الشروط و الأحكام',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image(
                        image: const AssetImage('assets/policy.png'),
                        height: 22.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => ContactUs());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'اتصل بنا',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      const Icon(Icons.phone, size: 25, color: Colors.white)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const AboutUs());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'عن التطبيق',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image(
                        image: const AssetImage('assets/Info.png'),
                        height: 22.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    FileView(
                      controller: FileViewController.asset('assets/word.docx'),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'سياسة الخصوصية',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image(
                        image: const AssetImage('assets/policy.png'),
                        height: 22.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance
                        .signOut()
                        .whenComplete(() => Get.offAll(() => Login()));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'تسجيل الخروج',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }

  void _ButtonPressed(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xff737373),
            height: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 40.w,
                      ),
                      Text(
                        'تغيير اللغة',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: BC.appColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 20.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'الأنجليزية',
                        style: TextStyle(
                          fontSize: 18,
                          color: BC.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'العربية',
                        style: TextStyle(
                          fontSize: 18,
                          color: BC.appColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyButton(
                    onPressed: () {},
                    name: 'تغيير اللغة',
                  )
                ],
              ),
            ),
          );
        });
  }
}
