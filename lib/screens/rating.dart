import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/widgets/button.dart';

import '../constants/colors.dart';

import '../widgets/arrowButton.dart';
import '../widgets/loading.dart';

class Rating extends StatefulWidget {
  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  UserController userController = Get.put(UserController());
  var reviewController = TextEditingController();
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
          child: SingleChildScrollView(
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
                const SizedBox(
                  height: 50,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('MishtariProducts')
                        .where('uid',
                            arrayContains: userController.currentUser.value.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 180.h,
                            ),
                            Text(
                              'لا يوجد طلبات نشطة',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            BuyerModel buyerData = BuyerModel.fromMap(
                                snapshot.data!.docs[index].data());
                            DateTime date = DateTime.parse(buyerData.days!);
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                decoration: BoxDecoration(
                                    color: BC.appColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: BC.appColor)),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "#${buyerData.orderNumber}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: BC.appColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'رقم الطلب',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: BC.lightGrey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat('dd/MM/yyyy  hh:mm ')
                                              .format(date),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'التاريخ و الوقت',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: BC.lightGrey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          buyerData.purpose!,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'الغرض',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: BC.lightGrey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'بأنتظار استلام المبلغ',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'حالة الطلب',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: BC.lightGrey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Text(
                                              'مشتري',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'صفة طالب الأعتراض',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: BC.lightGrey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    buyerData.review == ''
                                        ? Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: BC.lightGrey),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: TextFormField(
                                                  controller: reviewController,
                                                  textAlign: TextAlign.right,
                                                  maxLines: 5,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: 'أكتب رسالتك هنا',
                                                    contentPadding:
                                                        EdgeInsets.only(top: 0),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: BC.appColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'مرفقات',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: BC.appColor,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              MyButton(
                                                name: 'إرسال',
                                                onPressed: () {
                                                  SmartDialog.showLoading(
                                                    animationBuilder:
                                                        (controller, child,
                                                            animationParam) {
                                                      return Loading(
                                                        text:
                                                            'جاري إرسال الطلب ...',
                                                      );
                                                    },
                                                  );
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 2), () {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'MishtariProducts')
                                                        .doc(snapshot.data!
                                                            .docs[index].id)
                                                        .update({
                                                      'review':
                                                          reviewController.text,
                                                    });
                                                    SmartDialog.dismiss();
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              )
                                            ],
                                          )
                                        : Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1, color: BC.appColor),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                buyerData.review!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: BC.appColor,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
