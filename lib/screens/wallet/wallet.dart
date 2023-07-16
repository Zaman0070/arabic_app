import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:waist_app/widgets/button.dart';
import 'package:waist_app/widgets/loading.dart';

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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 300.w,
                          child: Text(
                            'STC Pay',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 15.sp),
                          ),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 300.w,
                          child: Text(
                            'Bank Transfer',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 15.sp),
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
                    const SizedBox(
                      height: 12,
                    ),
                    isSwitched == false && isSwitched2 == false
                        ? SizedBox()
                        : Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              maxLines: 4,
                              keyboardType: TextInputType.phone,
                              controller: accountDetailsController,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(width: 0.1)),
                                labelText: isSwitched
                                    ? 'تفاصيل حساب STC'
                                    : "تفاصيل حساب Bank",
                                // hintText: isSwitched? 'تفاصيل حساب STC' : "تفاصيل حساب Bank",
                                contentPadding:
                                    const EdgeInsets.only(top: 0, right: 15),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: BC.appColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6.6),
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Text(
                                          $bankName,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                  } else if (accountDetailsController
                                      .text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg:
                                            'الرجاء إدخال التفاصيل المصرفية الخاصة بك');
                                  } else {
                                    SmartDialog.showLoading(
                                      animationBuilder:
                                          (controller, child, animationParam) {
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
                                      'amount': snapshot.data!['walletBalance'],
                                      'bankDetails': accountDetailsController
                                          .text
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
