import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/widgets/loading.dart';

import '../widgets/arrowButton.dart';

class Rating extends StatefulWidget {
  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  UserController userController = Get.put(UserController());
  var reviewController = TextEditingController();
  double rating = 0.0;
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
            child: Column(
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    const Text(
                      'آراء العملاء',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ArrowButton(
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/logo.jpeg',
                            height: 120.h,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        RatingBar.builder(
                          itemSize: 45.h,
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (ratings) {
                            rating = ratings;
                            print(ratings);
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            height: 150.h,
                            width: 1.sw,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: BC.appColor)),
                            child: TextFormField(
                              controller: reviewController,
                              maxLines: 8,
                              decoration: InputDecoration(
                                hintText: 'اكتب رأيك هنا',
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
                              animationBuilder:
                                  (controller, child, animationParam) {
                                return Loading(
                                  text: ' ... تحميل ',
                                );
                              },
                            );
                            await FirebaseFirestore.instance
                                .collection('rating')
                                .add({
                              'feedback': reviewController.text,
                              'rating': rating,
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
                ),
              ],
            )),
      ),
    );
  }
}
