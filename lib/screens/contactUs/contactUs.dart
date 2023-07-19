import 'dart:io';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waist_app/controller/image_controller.dart';

import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/screens/contactUs/widget/report_textField.dart';
import 'package:waist_app/widgets/UploadImageButton.dart';

import '../../constants/colors.dart';
import '../../widgets/arrowButton.dart';
import '../../widgets/loading.dart';

// ignore: must_be_immutable
class ContactUs extends StatefulWidget {
  ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  var whatsapp = "+966 12 3456789";
  // Replace with the desired phone number
  var messageControllre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    width: 40,
                  ),
                  Text(
                    'اتصل بنا',
                    style: TextStyle(
                      fontSize: 20.sp,
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
              InkWell(
                onTap: () async {
                  await launch("https://wa.me/${whatsapp}?text=Hello");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '+966 12-345-6789 ',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'الواتس اب',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Image.asset(
                      'assets/whatsapp.png',
                      height: 28.h,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () async {
                  await launch("tel://+966 12-345-6789");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '+966 12-345-6789 ',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'الهاتف',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Icon(
                      Icons.phone,
                      size: 35,
                      color: BC.appColor,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ReportTextField());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'مراسلة الادارة',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Image.asset(
                      'assets/Location.png',
                      height: 28.h,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () async {
                  await launch(
                      'mailto:wasit@gmail.com?subject=This is Subject Title&body=This is Body of Email');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'wasit@gmail.com',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'البريد الألكتروني',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Image.asset(
                      'assets/Mail.png',
                      height: 21.h,
                    )
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  _ButtonPressed(context, messageControllre);
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
                      'طلب اعتراض',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: BC.appColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _ButtonPressed(context, controller) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          ImagePickerController imagePickerController =
              Get.put(ImagePickerController());
          List<dynamic> images = [];
          return Container(
            color: const Color(0xff737373),
            height: 700.h,
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
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        'الطلبات السابقة',
                        style: TextStyle(
                          fontSize: 18.sp,
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
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'يرجي اختيار الطلب قبل تقديم الأعتراض',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 285.h,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('MishtariProducts')
                            .where('uid',
                                arrayContains:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Container();
                          }
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                BuyerModel buyerData = BuyerModel.fromMap(
                                    snapshot.data!.docs[index].data());
                                DateTime date = DateTime.parse(buyerData.days!);
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    decoration: BoxDecoration(
                                        color: BC.appColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: BC.appColor)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '#${buyerData.orderNumber}',
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              DateFormat('dd/MM/yyyy  hh:mm ')
                                                  .format(date),
                                              style: TextStyle(
                                                fontSize: 13.sp,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              buyerData.purpose!,
                                              style: TextStyle(
                                                fontSize: 13.sp,
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
                                        Column(
                                          children: [
                                            Directionality(
                                              textDirection:
                                                  ui.TextDirection.rtl,
                                              child: Container(
                                                height: 80.h,
                                                width: 1.sw,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                        color: BC.appColor)),
                                                child: TextFormField(
                                                  controller: controller,
                                                  maxLines: 4,
                                                  decoration: InputDecoration(
                                                    hintText: 'اكتب رسالتك هنا',
                                                    hintStyle: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: BC.appColor,
                                                    ),
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w,
                                                            vertical: 10.h),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            UploadButton(
                                              image: imagePickerController
                                                      .selectedImages.isEmpty
                                                  ? Container()
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.file(
                                                        File(
                                                            imagePickerController
                                                                .selectedImages[
                                                                    0]
                                                                .path),
                                                        height: 40.h,
                                                        width: 40.h,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                              press: () {
                                                Get.bottomSheet(
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        25),
                                                                topRight: Radius
                                                                    .circular(
                                                                        25))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              22.0),
                                                      child: Column(
                                                        textDirection: ui
                                                            .TextDirection.rtl,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              images = await imagePickerController
                                                                  .pickImage(
                                                                      ImageSource
                                                                          .camera)
                                                                  .whenComplete(
                                                                      () {
                                                                print(images);
                                                                Get.back();
                                                              });
                                                            },
                                                            child: Text(
                                                              'اختر صورة من الكاميرا',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.sp),
                                                            ),
                                                          ),
                                                          Divider(
                                                            color: BC.appColor,
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              images = await imagePickerController
                                                                  .pickMulti()
                                                                  .whenComplete(
                                                                      () {
                                                                Get.back();
                                                              });
                                                            },
                                                            child: Text(
                                                                'اختر صورة من المعرض',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.sp)),
                                                          ),
                                                          SizedBox(
                                                            height: 8.h,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                SmartDialog.showLoading(
                                                  animationBuilder: (controller,
                                                      child, animationParam) {
                                                    return Loading(
                                                      text:
                                                          'أرسل تقريرك بنجاح إلى المسؤول',
                                                    );
                                                  },
                                                );
                                                Future.delayed(
                                                    const Duration(seconds: 2),
                                                    () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Report')
                                                      .doc()
                                                      .set({
                                                    'uid': FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                    'report': 'report',
                                                    'message': controller.text,
                                                    'image': images.isEmpty
                                                        ? ''
                                                        : images,
                                                    'orderNumber':
                                                        buyerData.orderNumber,
                                                  });
                                                  setState(() {});
                                                  SmartDialog.dismiss();
                                                  Get.back();
                                                });
                                              },
                                              child: Container(
                                                height: 40.h,
                                                width: 1.sw,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
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
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
