import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/screens/contactUs/widget/report_textField.dart';
import '../../constants/colors.dart';
import '../../widgets/arrowButton.dart';
import '../../widgets/loading.dart';

// ignore: must_be_immutable
class ContactUs extends StatelessWidget {
  ContactUs({super.key});
  var whatsapp = "+966 12 3456789"; // Replace with the desired phone number
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
                  _ButtonPressed(context);
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

  void _ButtonPressed(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xff737373),
            height: 550.h,
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
                                return InkWell(
                                  onTap: () {
                                    SmartDialog.showLoading(
                                      animationBuilder:
                                          (controller, child, animationParam) {
                                        return Loading(
                                          text: 'أرسل تقريرك بنجاح إلى المسؤول',
                                        );
                                      },
                                    );
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      FirebaseFirestore.instance
                                          .collection('Report')
                                          .doc()
                                          .set({
                                        'uid': FirebaseAuth
                                            .instance.currentUser!.uid,
                                        'report': 'report',
                                        'orderNumber': buyerData.orderNumber,
                                      });
                                      SmartDialog.dismiss();
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      decoration: BoxDecoration(
                                          color: BC.appColor.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border:
                                              Border.all(color: BC.appColor)),
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
                                        ],
                                      ),
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
