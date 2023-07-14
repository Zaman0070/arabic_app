import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waist_app/Services/onsignal.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/controller/mishtri_controller.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/screens/bottom_nav/bottomNavi.dart';
import 'package:waist_app/screens/buy&mishtari/completePurchaseOrder.dart';
import 'package:waist_app/screens/order/widget/order_box.dart';
import 'package:waist_app/screens/seller&baya/completeSaleOrder.dart';
import 'package:waist_app/screens/services_provider/completeService.dart';
import 'package:waist_app/widgets/loading.dart';
import '../../widgets/arrowButton.dart';
import 'orderDetails.dart';

// ignore: must_be_immutable
class Orders extends StatefulWidget {
  String title;
  Orders({super.key, required this.title});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  UserController userController = Get.put(UserController());
  MishtariController mishtariController = Get.put(MishtariController());
  var merchandId = TextEditingController();
  var password = TextEditingController();
  OneSignals oneSignals = OneSignals();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const BottomNavigationExample());
        return true;
      },
      child: Scaffold(
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
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ArrowButton(
                      onPressed: () {
                        Get.offAll(() => const BottomNavigationExample());
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
                        .where('serviceCompleted', isEqualTo: false)
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
                            BuyerModel buyerData = BuyerModel.fromMap(
                                snapshot.data!.docs[index].data());
                            DateTime date = DateTime.parse(buyerData.days!);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: OrderBox(
                                buttonText: buyerData.formfillby == 'seller'
                                    ? 'متابعة الخدمة'
                                    : 'متابعة الطلب',
                                buyerModel: buyerData,
                                orderNumber: '#${buyerData.orderNumber}',
                                date: DateFormat('dd/MM/yyyy  hh:mm ')
                                    .format(date),
                                purpose: buyerData.purpose!,
                                orderStatus: buyerData.isAccepted == '' ||
                                        buyerData.isAccepted ==
                                            'sellerAccepted' ||
                                        buyerData.isAccepted == 'buyerAccepted'
                                    ? 'تقديم الطلب'
                                    : buyerData.isAccepted == 'payforcash'
                                        ? 'استلام المبلغ'
                                        : buyerData.isAccepted == 'underProcess'
                                            ? 'قيد التنفيذ'
                                            : 'تحويل المبلغ',
                                onPressed: buyerData
                                                .timeExtandRequestAccepted ==
                                            true &&
                                        buyerData.byerUid ==
                                            userController.currentUser.value.uid
                                    ? () {
                                        extandTime(
                                            context: context,
                                            accpeted: () async {
                                              SmartDialog.showLoading(
                                                animationBuilder: (controller,
                                                    child, animationParam) {
                                                  return Loading(
                                                    text: ' ... تحميل ',
                                                  );
                                                },
                                              );
                                              await FirebaseFirestore.instance
                                                  .collection(
                                                      'MishtariProducts')
                                                  .doc(snapshot
                                                      .data!.docs[index].id)
                                                  .update({
                                                'days':
                                                    buyerData.timeExtandRequest,
                                                'timeExtandRequestAccepted':
                                                    false
                                              });
                                              SmartDialog.dismiss();
                                              Get.back();
                                            },
                                            declined: () async {
                                              SmartDialog.showLoading(
                                                animationBuilder: (controller,
                                                    child, animationParam) {
                                                  return Loading(
                                                    text: ' ... تحميل ',
                                                  );
                                                },
                                              );
                                              await FirebaseFirestore.instance
                                                  .collection(
                                                      'MishtariProducts')
                                                  .doc(snapshot
                                                      .data!.docs[index].id)
                                                  .update({
                                                'days':
                                                    buyerData.timeExtandRequest,
                                                'timeExtandRequestAccepted':
                                                    false
                                              });
                                              SmartDialog.dismiss();
                                              Get.back();
                                              await oneSignals.sendNotification(
                                                  userController.specificUser
                                                      .value.token!,
                                                  '',
                                                  'يقبل المشتري عرض تمديد الوقت',
                                                  'assets/logo/jpeg',
                                                  token: userController
                                                      .specificUser
                                                      .value
                                                      .token!,
                                                  senderName: userController
                                                      .currentUser.value.name!,
                                                  type: 'mishtri');
                                            });
                                        //////////Extand Time////////////
                                      }
                                    : buyerData.isAccepted == '' &&
                                            buyerData.secondPartyMobile ==
                                                userController.currentUser.value
                                                    .phoneNumber
                                        ? () {
                                            userController.getSpecificUser(
                                                buyerData.uid![0]);
                                            orderConfimation(
                                                context: context,
                                                accpeted: () async {
                                                  buyerData.formType == 'seller'
                                                      ? await mishtariController
                                                          .acceptStatus(
                                                              snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id,
                                                              'sellerAccepted')
                                                          .whenComplete(() {
                                                          Get.to(() => CompleteOrder(
                                                              id: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id,
                                                              type: 'update',
                                                              userModel:
                                                                  userController
                                                                      .specificUser
                                                                      .value,
                                                              buyerModel:
                                                                  buyerData));
                                                        })
                                                      : buyerData.formType ==
                                                              'buyer'
                                                          ? await mishtariController
                                                              .acceptStatus(
                                                                  snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .id,
                                                                  'byerAccepted')
                                                              .whenComplete(() {
                                                              Get.to(() =>
                                                                  CompleteSaleOrder(
                                                                    id: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .id,
                                                                    buyerModel:
                                                                        buyerData,
                                                                    userModel: userController
                                                                        .specificUser
                                                                        .value,
                                                                  ));
                                                            })
                                                          : buyerData.formType ==
                                                                  'serviceProvider'
                                                              ? await mishtariController
                                                                  .acceptStatus(
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id,
                                                                      'byerAccepted')
                                                                  .whenComplete(
                                                                      () {
                                                                  Get.to(() =>
                                                                      CompleteServiceProvider(
                                                                        id: snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .id,
                                                                        buyerModel:
                                                                            buyerData,
                                                                        userModel: userController
                                                                            .specificUser
                                                                            .value,
                                                                      ));
                                                                })
                                                              : await mishtariController
                                                                  .acceptStatus(
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id,
                                                                      'byerAccepted')
                                                                  .whenComplete(
                                                                      () {
                                                                  Get.to(() =>
                                                                      CompleteServiceProvider(
                                                                        id: snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .id,
                                                                        buyerModel:
                                                                            buyerData,
                                                                        userModel: userController
                                                                            .specificUser
                                                                            .value,
                                                                      ));
                                                                });
                                                },
                                                declined: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'MishtariProducts')
                                                      .doc(snapshot
                                                          .data!.docs[index].id)
                                                      .update({
                                                    'isAccepted': 'declined',
                                                  });
                                                  Get.back();
                                                  userController
                                                      .getSpecificUser(
                                                          buyerData.uid![0]);
                                                  await oneSignals.sendNotification(
                                                      userController
                                                          .specificUser
                                                          .value
                                                          .token!,
                                                      '',
                                                      'طبيق وسيط: تم رفض طلبك (order detail)  من الطرف الآخر وسيتم إعادة المبلغ بعد خصم العمولة',
                                                      'assets/logo/jpeg',
                                                      token: userController
                                                          .specificUser
                                                          .value
                                                          .token!,
                                                      senderName: userController
                                                          .currentUser
                                                          .value
                                                          .name!,
                                                      type: 'mishtri');
                                                });
                                          }
                                        : buyerData.isAccepted ==
                                                    'buyerAccepted' &&
                                                buyerData.secondPartyMobile ==
                                                    userController.currentUser
                                                        .value.phoneNumber
                                            ? () {
                                                userController.getSpecificUser(
                                                    buyerData.uid![0]);
                                                payment(
                                                  context: context,
                                                  pay: () async {
                                                    SmartDialog.showLoading(
                                                      animationBuilder:
                                                          (controller, child,
                                                              animationParam) {
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
                                                              snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id,
                                                              'payforcash')
                                                          .whenComplete(
                                                              () async {
                                                        SmartDialog.dismiss();
                                                        Get.to(() => OrdersDetails(
                                                            user: userController
                                                                .specificUser
                                                                .value,
                                                            uid: buyerData
                                                                        .formType ==
                                                                    'seller'
                                                                ? buyerData
                                                                    .uid![0]
                                                                : buyerData
                                                                    .uid![1],
                                                            formType: buyerData
                                                                .formfillby!,
                                                            id: snapshot.data!
                                                                .docs[index].id,
                                                            buyerModel:
                                                                buyerData));
                                                      });
                                                    });
                                                  },
                                                );
                                              }
                                            : buyerData.isAccepted == '' &&
                                                    buyerData.phoneNumber ==
                                                        userController
                                                            .currentUser
                                                            .value
                                                            .phoneNumber
                                                ? () {
                                                    userController
                                                        .getSpecificUser(
                                                            buyerData.uid![0]);
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'يرجى انتظار البائع لقبول العرض');
                                                  }
                                                : () {
                                                    Get.to(() => OrdersDetails(
                                                        user: userController
                                                            .specificUser.value,
                                                        uid: buyerData
                                                                    .formType ==
                                                                'seller'
                                                            ? buyerData.uid![0]
                                                            : buyerData.uid![1],
                                                        formType: buyerData
                                                            .formfillby!,
                                                        id: snapshot.data!
                                                            .docs[index].id,
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
      ),
    );
  }

  void extandTime({
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
                  'يرسل البائع عرض تمديد الوقت',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: declined,
                      child: Container(
                        width: 0.44.sw,
                        height: 35.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: BC.appColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'رفض العرض',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: BC.appColor),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: accpeted,
                      child: Container(
                        width: 0.44.sw,
                        height: 35.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: BC.appColor),
                        child: Center(
                          child: Text(
                            'قبول العرض',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
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
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: declined,
                      child: Container(
                        width: 0.44.sw,
                        height: 35.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: BC.appColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'رفض العرض',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: BC.appColor),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: accpeted,
                      child: Container(
                        width: 0.44.sw,
                        height: 35.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: BC.appColor),
                        child: Center(
                          child: Text(
                            'قبول العرض',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
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
