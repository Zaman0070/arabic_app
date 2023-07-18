import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/screens/order/order.dart';
import 'package:waist_app/widgets/button.dart';

class OrderButtonHome extends StatelessWidget {
  const OrderButtonHome({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('MishtariProducts')
            .where('uid', arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          if (snapshot.data!.docs.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: BC.appColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: BC.appColor,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: BC.appColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const Text(
                              'تحويل المبلغ',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: BC.appColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const Text(
                              'قيد التنفيذ',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: BC.appColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const Text(
                              'استلام المبلغ',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: BC.appColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const Text(
                              'تقديم الطلب',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'لا يوجد طلبات نشطة',
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: BC.appColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            );
          }
          return ListView.builder(
              padding: EdgeInsets.zero,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                BuyerModel buyerData =
                    BuyerModel.fromMap(snapshot.data!.docs[index].data());
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: BC.appColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: BC.appColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 4),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: BC.appColor,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const Text(
                                  'تحويل المبلغ',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: buyerData.serviceCompleted == false
                                          ? buyerData.isAccepted ==
                                                  'underProcess'
                                              ? BC.appColor
                                              : Colors.transparent
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: BC.appColor,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const Text(
                                  'قيد التنفيذ',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 4),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: BC.appColor,
                                      ),
                                      color: buyerData.serviceCompleted == false
                                          ? buyerData.isAccepted ==
                                                      'payforcash' ||
                                                  buyerData.isAccepted ==
                                                      'underProcess'
                                              ? BC.appColor
                                              : Colors.transparent
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const Text(
                                  'استلام المبلغ',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 4),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            buyerData.serviceCompleted == true
                                                ? BC.appColor
                                                : Colors.transparent,
                                      ),
                                      color: buyerData.serviceCompleted == false
                                          ? buyerData.isAccepted == '' ||
                                                  buyerData.isAccepted ==
                                                      'payforcash' ||
                                                  buyerData.isAccepted ==
                                                      'sellerAccepted' ||
                                                  buyerData.isAccepted ==
                                                      'buyerAccepted' ||
                                                  buyerData.isAccepted ==
                                                      'underProcess'
                                              ? BC.appColor
                                              : Colors.transparent
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const Text(
                                  'تقديم الطلب',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        buyerData.serviceCompleted == false
                            ? MyButton(
                                name: 'تفاصيل الطلب',
                                onPressed: () {
                                  Get.to(() => Orders(
                                        title: 'الطلبات النشطة',
                                      ));
                                },
                              )
                            : Text(
                                'لا يوجد طلبات نشطة',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: BC.appColor,
                                    fontWeight: FontWeight.bold),
                              ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
