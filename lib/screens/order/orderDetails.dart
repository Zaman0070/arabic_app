import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waist_app/Services/onsignal.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/model/user.dart';
import 'package:waist_app/screens/bottom_nav/bottomNavi.dart';
import 'package:waist_app/screens/chat/chat_conversation.dart';
import 'package:waist_app/screens/help.dart';
import 'package:waist_app/screens/order/order.dart';
import 'package:waist_app/widgets/button.dart';
import 'package:waist_app/widgets/loading.dart';
import '../../constants/colors.dart';
import '../../widgets/arrowButton.dart';
import 'dart:ui' as ui;

// ignore: must_be_immutable
class OrdersDetails extends StatefulWidget {
  UserModel user;
  BuyerModel buyerModel;
  String id;
  String formType;
  String uid;
  OrdersDetails(
      {super.key,
      required this.buyerModel,
      required this.id,
      required this.formType,
      required this.uid,
      required this.user});

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  UserController userController = Get.put(UserController());
  OneSignals oneSignals = OneSignals();

  late DateTime date = DateTime.parse(widget.buyerModel.days!);
  late int difference = DateTime.now().difference(date).inDays;
  bool orderCompleted = false;
  late var timeController = TextEditingController();
  late OptionItem optionItemSelectedday1 = OptionItem(title: ' 1 أيام');
  DropListModel dropListModeldays1 = DropListModel([
    OptionItem(id: "1", title: ' 1 أيام'),
    OptionItem(id: "2", title: ' 2 أيام'),
    OptionItem(id: "3", title: ' 3 أيام'),
    OptionItem(id: "4", title: ' 4 أيام'),
    OptionItem(id: "5", title: ' 5 أيام'),
    OptionItem(id: "7", title: ' 7 أيام'),
    OptionItem(id: "8", title: ' 10 أيام'),
    OptionItem(id: "9", title: ' 14 أيام'),
    OptionItem(id: "10", title: ' 21 أيام'),
    OptionItem(id: "12", title: ' 30 أيام'),
  ]);
  // ignore: unused_local_variable
  String? ayamNumber;
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
                    widget.buyerModel.byerUid ==
                            userController.currentUser.value.uid
                        ? 'تفاصيل الطلب للمشتري'
                        : 'تفاصيل الطلب للبائع',
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
                        Text(
                          widget.buyerModel.isAccepted == '' ||
                                  widget.buyerModel.isAccepted ==
                                      'sellerAccepted' ||
                                  widget.buyerModel.isAccepted ==
                                      'buyerAccepted'
                              ? 'تقديم الطلب'
                              : widget.buyerModel.isAccepted == 'payforcash'
                                  ? 'استلام المبلغ'
                                  : widget.buyerModel.isAccepted ==
                                          'underProcess'
                                      ? 'قيد التنفيذ'
                                      : 'تحويل المبلغ',
                          style: const TextStyle(
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
                    widget.formType != 'seller' && widget.formType != 'buyer'
                        ? Container()
                        : Row(
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
              widget.buyerModel.byerUid != userController.currentUser.value.uid
                  ? InkWell(
                      onTap: () {
                        orderExtendDate(
                          increaseDateTime: () async {
                            SmartDialog.showLoading(
                              animationBuilder:
                                  (controller, child, animationParam) {
                                return Loading(
                                  text: 'جاري تمديد التاريخ',
                                );
                              },
                            );
                            await FirebaseFirestore.instance
                                .collection('MishtariProducts')
                                .doc(widget.id)
                                .update({
                              'timeExtandRequest': timeController.text,
                              'timeExtandRequestAccepted': true
                            });
                            SmartDialog.dismiss();
                            Get.offAll(() => const BottomNavigationExample());
                            await oneSignals.sendNotification(
                                widget.user.token!,
                                '',
                                'يرجى تمديد وقت التسليم',
                                'assets/logo/jpeg',
                                token: widget.user.token!,
                                senderName:
                                    userController.currentUser.value.name!,
                                type: 'mishtri');
                          },
                          context: context,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: BC.appColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'تمديد التاريخ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 12.h,
              ),
              MyButton(
                name: widget.uid == userController.currentUser.value.uid
                    ? "تم  إتمام  الطلب"
                    : 'تم ارسال الطلب',
                onPressed: widget.uid != userController.currentUser.value.uid
                    ? () async {
                        SmartDialog.showLoading(
                          animationBuilder:
                              (controller, child, animationParam) {
                            return Loading(
                              text: 'تحت العملية',
                            );
                          },
                        );
                        await FirebaseFirestore.instance
                            .collection('MishtariProducts')
                            .doc(widget.id)
                            .update({
                          'isAccepted': 'underProcess',
                        });
                        SmartDialog.dismiss();
                        Get.back();
                      }
                    : () {
                        orderConfimation(
                            context: context,
                            accpeted: () async {
                              SmartDialog.showLoading(
                                animationBuilder:
                                    (controller, child, animationParam) {
                                  return Loading(
                                    text: 'تم استلام الطلب سيتم تحويل المبلغ',
                                  );
                                },
                              );
                              Future.delayed(const Duration(seconds: 2),
                                  () async {
                                await FirebaseFirestore.instance
                                    .collection('MishtariProducts')
                                    .doc(widget.id)
                                    .update({
                                  'serviceCompleted': true,
                                });
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.user.uid)
                                    .update({
                                  'walletBalance': FieldValue.increment(
                                      int.parse(widget.buyerModel.price!)),
                                });
                                SmartDialog.dismiss();
                                Get.to(() => Orders(
                                      title: 'الطلبات النشطة',
                                    ));
                              });
                              await oneSignals.sendNotification(
                                  widget.user.token!,
                                  '',
                                  'تطبيق وسيط: تم تأكيد طلبك من الطرف الآخر وبانتظار تأكيد إنهاء المعاملة',
                                  'assets/logo/jpeg',
                                  token: widget.user.token!,
                                  senderName:
                                      userController.currentUser.value.name!,
                                  type: 'mishtri');
                            },
                            declined: () {
                              Get.back();
                            });
                      },
              ),
              SizedBox(
                height: 12.h,
              ),
              InkWell(
                onTap: () async {
                  await userController
                      .getSpecificUser(widget.buyerModel.uid![1]);

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
                    'lastMsg': '',
                    'lastMsgTime': DateTime.now().microsecondsSinceEpoch,
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
              widget.buyerModel.byerUid == userController.currentUser.value.uid
                  ? InkWell(
                      onTap: () {
                        Get.to(() => Help());
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

  void orderExtendDate({
    required BuildContext context,
    required Function() increaseDateTime,
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
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    'تمديد الوقت',
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
                height: 25.h,
              ),
              Directionality(
                textDirection: ui.TextDirection.rtl,
                child: Container(
                  transformAlignment: AlignmentDirectional.centerStart,
                  decoration: BoxDecoration(
                      color: BC.appColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: BC.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SelectDropList(
                          height: 40.h,
                          containerDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.transparent),
                              color: Colors.transparent),
                          containerPadding: const EdgeInsets.only(left: 10),
                          containerMargin: EdgeInsets.zero,
                          itemSelected: optionItemSelectedday1,
                          dropListModel: dropListModeldays1,
                          showIcon: false, // Show Icon in DropDown Title
                          showArrowIcon: false, // Show Arrow Icon in DropDown
                          showBorder: true,
                          paddingTop: 0,
                          paddingBottom: 0,
                          paddingLeft: 0,
                          paddingRight: 0,
                          borderColor: BC.grey,

                          onOptionSelected: (optionItem) {
                            optionItemSelectedday1 = optionItem;
                            ayamNumber = optionItem.title;
                            timeController.text = optionItem.title;
                            timeController.text = DateTime.now()
                                .add(Duration(days: int.parse(optionItem.id!)))
                                .toString();
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: increaseDateTime,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: BC.appColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'تأكيد التمديد',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
