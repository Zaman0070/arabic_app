import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/controller/mishtri_controller.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/screens/chat/chat_conversation.dart';
import 'package:waist_app/screens/order/widget/order_box.dart';
import 'package:waist_app/screens/seller&baya/theSeller.dart';
import 'package:waist_app/widgets/loading.dart';

import '../../widgets/arrowButton.dart';
import '../orderDetails.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  UserController userController = Get.put(UserController());
  MishtariController mishtariController = Get.put(MishtariController());
  var merchandId = TextEditingController();
  var password = TextEditingController();

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
          child: ListView(
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
                    'الطلبات النشطة',
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
              SizedBox(
                height: 50.h,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('MishtariProducts')
                      .where('uid',
                          arrayContains: userController.currentUser.value.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                          print(userController.currentUser.value.phoneNumber);

                          BuyerModel buyerData = BuyerModel.fromMap(
                              snapshot.data!.docs[index].data());
                          DateTime date = DateTime.parse(buyerData.days!);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: OrderBox(
                              orderNumber: '#${buyerData.orderNumber}',
                              date:
                                  DateFormat('dd/MM/yyyy  hh:mm ').format(date),
                              purpose: buyerData.purpose!,
                              orderStatus: 'توصيل طلبية',
                              onPressed: buyerData.isAccepted == ''
                                  ? () {
                                      orderConfimation(
                                          context: context,
                                          accpeted: () async {
                                            await mishtariController
                                                .acceptStatus(
                                                    snapshot
                                                        .data!.docs[index].id,
                                                    'requestForPayment')
                                                .whenComplete(() {
                                              Get.to(() => TheSeller(
                                                  id: snapshot
                                                      .data!.docs[index].id,
                                                  buyerModel: buyerData));
                                              // Get.back();
                                            });
                                            // Get.back();
                                          },
                                          declined: () async {
                                            await FirebaseFirestore.instance
                                                .collection('MishtariProducts')
                                                .doc(snapshot
                                                    .data!.docs[index].id)
                                                .update({
                                              'isAccepted': 'declined',
                                            });
                                            Get.back();
                                          });
                                    }
                                  : buyerData.isAccepted ==
                                              'requestForPayment' &&
                                          buyerData.secondPartyMobile !=
                                              userController
                                                  .currentUser.value.phoneNumber
                                      ? () {
                                          payment(
                                            context: context,
                                            pay: () async {
                                              SmartDialog.showLoading(
                                                animationBuilder: (controller,
                                                    child, animationParam) {
                                                  return Loading(
                                                    text: ' ... تحميل ',
                                                  );
                                                },
                                              );
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 2000),
                                                  () async {
                                                await mishtariController
                                                    .acceptStatus(
                                                        snapshot.data!
                                                            .docs[index].id,
                                                        'payforcash')
                                                    .whenComplete(() async {
                                                  SmartDialog.dismiss();
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Chats')
                                                      .doc(
                                                          '${buyerData.uid![0]}+${buyerData.uid![1]}')
                                                      .update({
                                                    'show': true,
                                                    'time': DateTime.now()
                                                        .microsecondsSinceEpoch,
                                                    'chatMap': [
                                                      buyerData.uid![0],
                                                      buyerData.uid![1],
                                                    ],
                                                    'userName': userController
                                                        .currentUser.value.name,
                                                    'userUid': userController
                                                        .currentUser.value.uid,
                                                    'userToken': userController
                                                        .currentUser
                                                        .value
                                                        .token,
                                                  });
                                                  Get.to(() => ChatConversation(
                                                        chatId:
                                                            '${buyerData.uid![0]}+${buyerData.uid![1]}',
                                                        image: userController
                                                            .currentUser
                                                            .value
                                                            .profileImage!,
                                                        name: userController
                                                            .currentUser
                                                            .value
                                                            .name!,
                                                        reciverId:
                                                            buyerData.uid![1],
                                                      ));
                                                });
                                              });
                                            },
                                          );
                                        }
                                      : () {
                                          Get.to(() => OrdersDetails(
                                              buyerModel: buyerData));
                                        },
                            ),
                          );
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }

  void orderConfimation({
    required BuildContext context,
    required Function() accpeted,
    required Function() declined,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: const Color(0xfff9fafe),
      elevation: 0.01,
      useSafeArea: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (BuildContext context) {
        return SizedBox(
          height: 160.h,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Container(
                    width: 20.h,
                    height: 5.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'هل أنت متأكد من إتمام الخدمة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: accpeted,
                      child: Container(
                        width: 0.4.sw,
                        height: 35.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: BC.appColor),
                        child: Center(
                          child: Text(
                            'قبول العرض',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: accpeted,
                      child: Container(
                        width: 0.4.sw,
                        height: 35.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: BC.appColor),
                        child: Center(
                          child: Text(
                            'رفض العرض',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void payment({
    required BuildContext context,
    required Function() pay,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: const Color(0xfff9fafe),
      elevation: 0.01,
      useSafeArea: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (BuildContext context) {
        // bool onTap = false;
        return SizedBox(
          height: 160.h,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Container(
                    width: 20.h,
                    height: 5.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'هل أنت متأكد من إتمام الخدمة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: pay,
                  child: Container(
                    width: 1.sw,
                    height: 35.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: BC.appColor),
                    child: Center(
                      child: Text(
                        'دفع نقدا',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
