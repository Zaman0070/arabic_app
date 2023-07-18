import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:waist_app/widgets/button.dart';
import 'package:waist_app/widgets/loading.dart';
import 'package:waist_app/widgets/textFormfield.dart';

import '../../constants/colors.dart';
import '../../widgets/arrowButton.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool isSwitched = false;
  bool isSwitched2 = false;
  String $bankName = "";
  var accountDetailsController = TextEditingController();
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            }
            return Container(
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
              child: SafeArea(
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
                          'المحفظة',
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
                      height: 40.h,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: BC.appColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'ريال',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                snapshot.data!['walletBalance'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'الرصيد الحالي',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: BC.lightGrey),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Image(
                                image: const AssetImage('assets/Wallet.png'),
                                height: 22.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/stc.png',
                          height: 24.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSwitched2 = false;
                              isSwitched = !isSwitched;
                            });
                          },
                          child: Container(
                            width: 20.h,
                            height: 20.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: BC.appColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.check,
                              color:
                                  isSwitched ? BC.appColor : Colors.transparent,
                              size: 15.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 300.w,
                          child: Text(
                            'تحويل بنكي',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSwitched = false;
                              isSwitched2 = !isSwitched2;
                            });
                          },
                          child: Container(
                            width: 20.h,
                            height: 20.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: BC.appColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.check,
                              color: isSwitched2
                                  ? BC.appColor
                                  : Colors.transparent,
                              size: 15.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    isSwitched == false && isSwitched2 == false
                        ? const SizedBox()
                        : isSwitched == true
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MytextField(
                                            type: TextInputType.name,
                                            controller: lastnameController,
                                            text: 'اسم العائلة',
                                            hint: 'اسم العائلة'),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: MytextField(
                                            type: TextInputType.name,
                                            controller: firstnameController,
                                            text: 'الاسم الأول',
                                            hint: 'الاسم الأول'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MytextField(
                                      type: TextInputType.phone,
                                      controller: phoneController,
                                      text: 'رقم جوال اس تي سي باي',
                                      hint: 'XXX XXXXXXXXX '),
                                ],
                              )
                            : Column(
                                children: [
                                  MytextField(
                                    type: TextInputType.name,
                                    controller: accountDetailsController,
                                    text: 'اسم البنك',
                                    hint: 'اسم البنك',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MytextField(
                                    type: TextInputType.number,
                                    controller: accountDetailsController,
                                    text: isSwitched
                                        ? 'تفاصيل حساب STC'
                                        : "تفاصيل حساب البنك",
                                    hint: isSwitched
                                        ? 'تفاصيل حساب STC'
                                        : "iban number",
                                  ),
                                ],
                              ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 200),
                      child: MyButton(
                          name: 'سحب الرصيد',
                          onPressed: isSwitched == false && isSwitched2 == false
                              ? () {
                                  Fluttertoast.showToast(
                                      msg: 'الرجاء تحديد بنك واحد');
                                }
                              : () async {
                                  if (snapshot.data!['walletBalance']
                                          .toString() ==
                                      "0") {
                                    Fluttertoast.showToast(msg: 'رصيدك منخفض');
                                  } else {
                                    if (isSwitched == true &&
                                        isSwitched2 == false) {
                                      if (firstnameController.text.trim() ==
                                              '' ||
                                          lastnameController.text.trim() ==
                                              '' ||
                                          phoneController.text.trim() == "") {
                                        Fluttertoast.showToast(
                                            msg: 'الرجاء إدخال جميع الحقول');
                                      } else {
                                        SmartDialog.showLoading(
                                          animationBuilder: (controller, child,
                                              animationParam) {
                                            return Loading(
                                              text: ' ... تحميل ',
                                            );
                                          },
                                        );
                                        await FirebaseFirestore.instance
                                            .collection('withdrawRequests')
                                            .doc()
                                            .set({
                                          'userId': FirebaseAuth
                                              .instance.currentUser!.uid,
                                          'amount':
                                              snapshot.data!['walletBalance'],
                                          'firstname':
                                              firstnameController.text.trim(),
                                          'lastname':
                                              lastnameController.text.trim(),
                                          'phone': phoneController.text.trim(),
                                        });

                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({
                                          'walletBalance': 0,
                                        });
                                        SmartDialog.dismiss();
                                        Fluttertoast.showToast(
                                            msg: 'تم سحب الرصيد بنجاح');
                                        Get.back();
                                      }
                                    } else if (isSwitched == false &&
                                        isSwitched2 == true) {
                                      if (accountDetailsController.text
                                              .trim() ==
                                          '') {
                                        Fluttertoast.showToast(
                                            msg: 'الرجاء إدخال جميع الحقول');
                                      } else {
                                        SmartDialog.showLoading(
                                          animationBuilder: (controller, child,
                                              animationParam) {
                                            return Loading(
                                              text: ' ... تحميل ',
                                            );
                                          },
                                        );

                                        await FirebaseFirestore.instance
                                            .collection('withdrawRequests')
                                            .doc()
                                            .set({
                                          'userId': FirebaseAuth
                                              .instance.currentUser!.uid,
                                          'amount':
                                              snapshot.data!['walletBalance'],
                                          'bankDetails':
                                              accountDetailsController.text
                                                  .toString()
                                                  .trim(),
                                        });

                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({
                                          'walletBalance': 0,
                                        });
                                        SmartDialog.dismiss();
                                        Fluttertoast.showToast(
                                            msg: 'تم سحب الرصيد بنجاح');
                                        Get.back();
                                      }
                                    }
                                  }
                                }),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
