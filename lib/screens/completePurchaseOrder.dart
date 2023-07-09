import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:waist_app/Services/firebase_services.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/model/user.dart';
import 'package:waist_app/screens/privacy_policy/privacy_policy.dart';
import 'package:waist_app/widgets/button.dart';
import 'package:waist_app/widgets/textFormfield.dart';

import '../constants/colors.dart';
import '../widgets/arrowButton.dart';

// ignore: must_be_immutable
class CompleteOrder extends StatefulWidget {
  BuyerModel buyerModel;
  UserModel userModel;
  CompleteOrder({
    super.key,
    required this.buyerModel,
    required this.userModel,
  });
  @override
  State<CompleteOrder> createState() => _CompleteOrderState();
}

class _CompleteOrderState extends State<CompleteOrder> {
  UserController userController = Get.put(UserController());
  bool isSwitched = false;
  bool isSwitched2 = false;
  bool mada = false;
  late var nameController = TextEditingController(text: widget.buyerModel.name);
  late var phoneController =
      TextEditingController(text: '${widget.buyerModel.phoneNumber}+');
  late var addressController =
      TextEditingController(text: widget.buyerModel.address!.trim());
  bool second = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      'إكمال طلب الشراء',
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
                  height: 20.h,
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
                      const SizedBox(
                        height: 10,
                      ),
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
                      const Divider(),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.userModel.name!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'اسم الطرف الأول ثلاثي',
                            textAlign: TextAlign.right,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '+${widget.userModel.phoneNumber!}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'الجوال',
                            textAlign: TextAlign.right,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.userModel.location!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'المدينة',
                            textAlign: TextAlign.right,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.buyerModel.purpose!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'الغرض',
                            textAlign: TextAlign.right,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'ريال',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.buyerModel.price!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'المبلغ',
                            textAlign: TextAlign.right,
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
                const SizedBox(
                  height: 25,
                ),
                MytextField(
                  type: TextInputType.name,
                  controller: nameController,
                  text: 'رقم الهاتف',
                  hint: 'رقم الهاتف',
                ),
                const SizedBox(
                  height: 10,
                ),
                MytextField(
                  type: TextInputType.phone,
                  controller: addressController,
                  text: 'المدينة',
                  hint: 'المدينة',
                ),
                const SizedBox(
                  height: 10,
                ),
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     width: double.infinity,
                //     padding: const EdgeInsets.symmetric(vertical: 10),
                //     decoration: BoxDecoration(
                //       border: Border.all(width: 1, color: BC.appColor),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Center(
                //       child: Text(
                //         'تحميل صورة السلعة',
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             color: BC.appColor,
                //             fontSize: 16),
                //       ),
                //     ),
                //   ),
                // ),

                MytextField(
                  type: TextInputType.phone,
                  controller: phoneController,
                  text: 'الجوال',
                  hint: '+966 xx-xxx-xxxx',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 305.w,
                      child: Text(
                        'أتعهد بأن تكون السلعة حسب المتفق عليها وفي خلاف ذلك سيتم استرجاع المبلغ للطرف الأول',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 11.sp),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
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
                          color: isSwitched ? BC.appColor : Colors.transparent,
                          size: 15.h,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 305.w,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [
                            Text(
                              "أوافق على  ",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 11.sp),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => const PrivacyPolicy());
                              },
                              child: Text(
                                'شروط و أحكام',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: BC.appColor,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              'تطبيق وسيط ',
                              style: TextStyle(fontSize: 11.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
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
                          color: isSwitched2 ? BC.appColor : Colors.transparent,
                          size: 15.h,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                    name: 'تأكيد الطلب',
                    onPressed: () async {
                      isSwitched == false || isSwitched2 == false
                          ? Fluttertoast.showToast(msg: 'msg')
                          : await FirebaseServices().addMishtriDetails(
                              serviceCompleted: false,
                              orderCompleted: false,
                              orderNumber: widget.buyerModel.orderNumber!,
                              formfillby: 'seller',
                              formType: 'تفاصيل الطلب للبائع',
                              uid: [
                                userController.currentUser.value.uid!,
                                widget.userModel.uid!
                              ],
                              name: nameController.text,
                              phoneNumber:
                                  phoneController.text.replaceAll("+", ''),
                              purpose: widget.buyerModel.purpose!,
                              days: widget.buyerModel.days!,
                              secondPartyMobile: widget
                                  .buyerModel.secondPartyMobile!
                                  .replaceAll('+', ''),
                              description: widget.buyerModel.description!,
                              address: addressController.text,
                              price: widget.buyerModel.price!,
                              agree1: isSwitched,
                              agree2: isSwitched2,
                              images: widget.buyerModel.images!,
                              isAccepted: '',
                              ayam: widget.buyerModel.ayam!,
                              ayamNumber: widget.buyerModel.ayamNumber!,
                              review: '',
                            );
                    }),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
