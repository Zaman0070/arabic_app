import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/screens/chat/chat_conversation.dart';
import 'package:waist_app/screens/order/order.dart';
import 'package:waist_app/widgets/button.dart';
import 'package:waist_app/widgets/loading.dart';
import '../constants/colors.dart';
import '../widgets/arrowButton.dart';
// ignore: must_be_immutable
class OrdersDetails extends StatefulWidget {
  BuyerModel buyerModel;
  String id;
  OrdersDetails({super.key, required this.buyerModel, required this.id});

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  UserController userController = Get.put(UserController());

  late DateTime date = DateTime.parse(widget.buyerModel.days!);
  late int difference = DateTime.now().difference(date).inDays;
  bool orderCompleted = false;

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
                  Text(
                    widget.buyerModel.formType!,
                    style: const TextStyle(
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
                height: 40.h,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    color: BC.appColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: BC.appColor)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '#${widget.buyerModel.orderNumber}',
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('hh:mm  dd/MM/yyyy ').format(date),
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.buyerModel.purpose!,
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'ريال',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              widget.buyerModel.price!,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'المبلغ',
                          style: TextStyle(
                            fontSize: 16,
                            color: BC.lightGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'ايام',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '${difference.abs()}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'المدة',
                          style: TextStyle(
                            fontSize: 16,
                            color: BC.lightGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '------------',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'ملاحظات',
                          style: TextStyle(
                            fontSize: 16,
                            color: BC.lightGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 55.h,
                          height: 55.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              widget.buyerModel.images!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          'صورة السلعة',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 16,
                            color: BC.lightGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              
              MyButton(
                name: orderCompleted || widget.buyerModel.orderCompleted == true
                    ? "تم  إتمام  الطلب"
                    : 'تم ارسال الطلب',
                onPressed: orderCompleted == false
                    ? () {
                        FirebaseFirestore.instance
                            .collection('MishtariProducts')
                            .doc(widget.id)
                            .update({
                          'orderCompleted': true,
                        });
                        setState(() {
                          orderCompleted = true;
                        });
                      }
                    : () {
                        orderConfimation(
                            context: context,
                            accpeted: () {
                              SmartDialog.showLoading(
                                animationBuilder:
                                    (controller, child, animationParam) {
                                  return Loading(
                                    text: 'تم استلام الطلب سيتم تحويل المبلغ',
                                  );
                                },
                              );
                              Future.delayed(const Duration(seconds: 2), () {
                                FirebaseFirestore.instance
                                    .collection('MishtariProducts')
                                    .doc(widget.id)
                                    .update({
                                  'serviceCompleted': true,
                                });
                                SmartDialog.dismiss();
                                Get.to(() => Orders(
                                      title: 'الطلبات النشطة',
                                    ));
                              });
                            },
                            declined: () {});
                      },
              ),
              SizedBox(
                height: 12.h,
              ),
              InkWell(
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection('Chats')
                      .doc(
                          '${widget.buyerModel.uid![0]}+${widget.buyerModel.uid![1]}')
                      .set({
                    'show': true,
                    'time': DateTime.now().microsecondsSinceEpoch,
                    'chatMap': [
                      widget.buyerModel.uid![0],
                      widget.buyerModel.uid![1],
                    ],
                    'userName': userController.currentUser.value.name,
                    'userUid': userController.currentUser.value.uid,
                    'userToken': userController.currentUser.value.token,
                  });
                  Get.to(() => ChatConversation(
                        chatId:
                            '${widget.buyerModel.uid![0]}+${widget.buyerModel.uid![1]}',
                        image: userController.currentUser.value.profileImage!,
                        name: userController.currentUser.value.name!,
                        reciverId: widget.buyerModel.uid![1],
                      ));
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: BC.appColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'محادثة الطرف الأخر',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: BC.appColor,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              orderCompleted || widget.buyerModel.orderCompleted == true
                  ? InkWell(
                      onTap: () async {},
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: BC.appColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'قيم التطبيق',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: BC.appColor,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 25.h,
              ),
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
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(
                      'تأكيد الطلب',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: Colors.black),
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
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
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
                            'الغاء',
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
                            'إتمام الطلب',
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
}
