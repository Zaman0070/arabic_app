import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/select_drop_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:waist_app/Services/onsignal.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/controller/percentage_controller.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/model/user.dart';
import 'package:waist_app/screens/privacy_policy/privacy_policy.dart';
import 'package:waist_app/screens/widget/button.dart';
import 'package:waist_app/Services/firebase_services.dart';
import 'package:waist_app/widgets/arrowButton.dart';
import 'package:waist_app/widgets/textFormfield.dart';

// ignore: must_be_immutable
class ServicesBeneficary extends StatefulWidget {
  const ServicesBeneficary({super.key});

  @override
  State<ServicesBeneficary> createState() => _ServicesBeneficaryState();
}

class _ServicesBeneficaryState extends State<ServicesBeneficary> {
  bool value = false;

  var secondphoneController = TextEditingController();
  UserController userController = Get.put(UserController());

  var commodityController = TextEditingController();

  var purposeController = TextEditingController();

  var desController = TextEditingController();
  OneSignals oneSignals = OneSignals();

  var timeController = TextEditingController();
  bool isSwitched = false;
  bool isSwitched2 = false;
  double result = 0;
  UserModel userModel = UserModel();
  List<String> uids = [];
  PercentageController percentageController = Get.put(PercentageController());

  String countryCode = '+966';
  String? ayam;
  String? ayamNumber;
  String ayamDate = '';
  DropListModel dropListModel = DropListModel([
    OptionItem(id: "1", title: "     الرياض"),
    OptionItem(id: "2", title: "     جدة"),
    OptionItem(id: "3", title: "     مكة المدينة"),
    OptionItem(id: "4", title: "     الدمام"),
    OptionItem(id: "5", title: "     الهفوف"),
    OptionItem(id: "5", title: "     الطائف"),
    OptionItem(id: "5", title: "     بريدة"),
    OptionItem(id: "5", title: "     الخبر"),
    OptionItem(id: "5", title: "     تبوك"),
    OptionItem(id: "5", title: "     أبها"),
    OptionItem(id: "5", title: "     نجران"),
    OptionItem(id: "5", title: "     حائل"),
    OptionItem(id: "5", title: "     الجبيل"),
    OptionItem(id: "5", title: "     الخرج"),
    OptionItem(id: "5", title: "     ينبع"),
    OptionItem(id: "5", title: "     القطيف"),
    OptionItem(id: "5", title: "     الأحساء"),
    OptionItem(id: "5", title: "     صبيا"),
    OptionItem(id: "5", title: "     جيزان"),
    OptionItem(id: "5", title: "     عرعر"),
  ]);
  DropListModel dropListModeldays = DropListModel([
    OptionItem(id: "1", title: "     ايام"),
    OptionItem(id: "2", title: "     شهر"),
  ]);
  DropListModel dropListModeldays1 = DropListModel([
    OptionItem(id: "1", title: "     1"),
    OptionItem(id: "2", title: "     2"),
    OptionItem(id: "3", title: "     3"),
    OptionItem(id: "4", title: "     4"),
    OptionItem(id: "5", title: "     5"),
    OptionItem(id: "6", title: "     6"),
    OptionItem(id: "7", title: "     7"),
    OptionItem(id: "8", title: "     10"),
    OptionItem(id: "9", title: "     14"),
    OptionItem(id: "10", title: "     21"),
    OptionItem(id: "11", title: "     30"),
    OptionItem(id: "12", title: "     35"),
    OptionItem(id: "13", title: "     40"),
    OptionItem(id: "14", title: "     45"),
    OptionItem(id: "15", title: "     50"),
    OptionItem(id: "16", title: "     55"),
    OptionItem(id: "17", title: "     60"),
  ]);
  OptionItem optionItemSelected = OptionItem(title: "    المدينة");
  OptionItem optionItemSelectedday = OptionItem(title: "    ايام");
  OptionItem optionItemSelectedday1 = OptionItem(title: "1");
  final _formKey = GlobalKey<FormState>();
  Color addressColor = Colors.grey;
  Color daysColor = Colors.grey;
  Color switchColors = BC.appColor;
  Color switchColors1 = BC.appColor;
  String daysVal = '';
  String addressVal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserController>(
          init: UserController(),
          builder: (controller) {
            late var nameController = TextEditingController(
                text: controller.currentUser.value.name ?? '');
            late var phoneController = TextEditingController(
                text: controller.currentUser.value.phoneNumber ?? '');
            late var addressController = TextEditingController(
                text: controller.currentUser.value.location ?? '');
            return Container(
              height: 1.sh,
              width: 1.sw,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/background.png',
                  ),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          const Text(
                            'مستفيد من الخدمة',
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
                        height: 15.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: BC.appColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: BC.appColor)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 15),
                          child: Column(
                            children: [
                              MytextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'من فضلك ادخل اسم الطرف';
                                  }
                                  return null;
                                },
                                type: TextInputType.name,
                                controller: nameController,
                                text: 'اسم الطرف',
                                hint: 'اسم الطرف',
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              MytextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'من فضلك ادخل رقم الجوال';
                                  }
                                  return null;
                                },
                                type: TextInputType.phone,
                                controller: phoneController,
                                text: 'الجوال',
                                hint: '+966 xx-xxx-xxxx',
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: SelectDropList(
                                  containerDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: addressColor),
                                      color: Colors.transparent),
                                  containerPadding:
                                      const EdgeInsets.only(left: 10),
                                  containerMargin: EdgeInsets.zero,
                                  itemSelected: optionItemSelected,
                                  dropListModel: dropListModel,
                                  showIcon:
                                      false, // Show Icon in DropDown Title
                                  showArrowIcon:
                                      true, // Show Arrow Icon in DropDown

                                  showBorder: true,
                                  paddingTop: 0,
                                  paddingBottom: 0,
                                  paddingLeft: 0,
                                  paddingRight: 0,
                                  borderColor: BC.grey,
                                  icon: Icon(Icons.person, color: BC.appColor),
                                  onOptionSelected: (optionItem) {
                                    optionItemSelected = optionItem;
                                    addressController.text = optionItem.title;
                                    print(optionItem.title);
                                    setState(() {});
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '$addressVal     ',
                                    style: TextStyle(
                                        color: Colors.red.shade800,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      MytextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل الغرض من الخدمة';
                          }
                          return null;
                        },
                        type: TextInputType.name,
                        controller: purposeController,
                        text: 'الغرض من الخدمة',
                        hint: 'الغرض من الخدمة',
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      MytextField(
                         onChanges: (value) {
                          setState(() {
                            result = int.parse(commodityController.text) +
                                int.parse(commodityController.text) *
                                    (percentageController
                                            .percentage.value.percentage! /
                                        100);
                          });
                          return null;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل قيمة السلعة';
                          }
                          return null;
                        },
                        type: TextInputType.number,
                        controller: commodityController,
                        text: 'قيمة السلعة',
                        hint: 'قيمة السلعة',
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: BC.appColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: daysColor)),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: SelectDropList(
                                  height: 40.h,
                                  containerDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Colors.transparent),
                                      color: Colors.transparent),
                                  containerPadding:
                                      const EdgeInsets.only(left: 10),
                                  containerMargin: EdgeInsets.zero,
                                  itemSelected: optionItemSelectedday1,
                                  dropListModel: dropListModeldays1,
                                  showIcon:
                                      false, // Show Icon in DropDown Title
                                  showArrowIcon:
                                      true, // Show Arrow Icon in DropDown
                                  showBorder: true,
                                  paddingTop: 0,
                                  paddingBottom: 0,
                                  paddingLeft: 0,
                                  paddingRight: 0,
                                  borderColor: BC.grey,
                                  icon: Icon(Icons.person, color: BC.appColor),
                                  onOptionSelected: (optionItem) {
                                    optionItemSelectedday1 = optionItem;
                                    ayamNumber = optionItem.title;
                                    timeController.text = optionItem.title;
                                    timeController.text = DateTime.now()
                                        .add(Duration(
                                            days: int.parse(optionItem.id!)))
                                        .toString();
                                    setState(() {});
                                  },
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 40.h,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'یوم',
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                              'الوقت المتوقع لانهاء الصفقة',
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.grey.shade400),
                                            ),
                                          ),

                                          // const Icon(Icons.arrow_drop_down)
                                        ],
                                      ),
                                    ),
                                  )),
                              // Expanded(
                              //   flex: 3,
                              //   child: SelectDropList(
                              //     height: 40.h,
                              //     containerDecoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(10),
                              //         border:
                              //             Border.all(color: Colors.transparent),
                              //         color: Colors.transparent),
                              //     containerPadding:
                              //         const EdgeInsets.only(left: 10),
                              //     containerMargin: EdgeInsets.zero,
                              //     itemSelected: optionItemSelectedday,
                              //     dropListModel: dropListModeldays,
                              //     showIcon: false, // Show Icon in DropDown Title
                              //     showArrowIcon:
                              //         true, // Show Arrow Icon in DropDown
                              //     showBorder: true,
                              //     paddingTop: 0,
                              //     paddingBottom: 0,
                              //     paddingLeft: 0,
                              //     paddingRight: 0,
                              //     borderColor: BC.grey,
                              //     icon: Icon(Icons.person, color: BC.appColor),
                              //     onOptionSelected: (optionItem) {
                              //       optionItemSelectedday = optionItem;
                              //       ayam = optionItem.title;
                              //       setState(() {});
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '$daysVal     ',
                            style: TextStyle(
                                color: Colors.red.shade800, fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك ادخل رقم هاتف البائع';
                            }
                            return null;
                          },
                          maxLength: 9,
                          keyboardType: TextInputType.phone,
                          controller: secondphoneController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(width: 0.1)),
                              labelText: 'رقم هاتف البائع',
                              hintText: 'XX-XXX-XXXX',
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
                                        countryCode,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      MytextField(
                        type: TextInputType.name,
                        controller: desController,
                        text: 'وصف السلعة(اختياري)',
                        hint: 'وصف السلعة(اختياري)',
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 290.w,
                            child: Text(
                              'اوافق بأنه في حالة عدم إنها الصفقة سيتم إعادة المبلغ بعد خصم العمولة',
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
                                  border: Border.all(color: switchColors),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(
                                Icons.check,
                                color: isSwitched
                                    ? BC.appColor
                                    : Colors.transparent,
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
                            width: 290.w,
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
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .where('phoneNumber',
                                      isEqualTo:
                                          '${countryCode.replaceAll('+', "")}${secondphoneController.text}')
                                  .get()
                                  .then((value) {
                                List<String> uid =
                                    value.docs.map((e) => e.id).toList();
                                UserModel userOther =
                                    UserModel.fromMap(value.docs.first.data());
                                uids = uid;
                                userModel = userOther;
                                userController.getSpecificUser(uid[0]);
                              });
                              setState(() {
                                isSwitched2 = !isSwitched2;
                              
                              });
                            },
                            child: Container(
                              width: 20.h,
                              height: 20.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: switchColors1),
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
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: BC.appColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Text(
                                'المبلغ الاجمالي + العمولة والضريبة',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Text(
                                '$result ريال ',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: BC.appColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppButton(
                          text: 'تأكيد الطلب و الدفع',
                          onPressed: () async {
                            var random = Random();
                            int randomNumber = random.nextInt(100000000);
                            if (_formKey.currentState!.validate()) {
                              timeController.text == ''
                                  ? setState(() {
                                      daysColor = Colors.red.shade800;
                                      daysVal = 'هذا الحقل مطلوب';
                                    })
                                  : isSwitched == false
                                      ? setState(() {
                                          switchColors = Colors.red.shade800;
                                        })
                                      : isSwitched2 == false
                                          ? setState(() {
                                              switchColors1 =
                                                  Colors.red.shade800;
                                            })
                                          : addressController.text == ''
                                              ? setState(() {
                                                  addressColor =
                                                      Colors.red.shade800;
                                                  addressVal =
                                                      'هذا الحقل مطلوب';
                                                })
                                              : uids.isEmpty
                                                  ? Fluttertoast.showToast(
                                                      msg:
                                                          'مقابل هذا الرقم البائع غير موجود')
                                                  : await FirebaseServices()
                                                      .addMishtriDetails(
                                                      timeExtandRequest: '',
                                                      timeExtandRequestAccepted:
                                                          false,
                                                      orderNumber: randomNumber,
                                                      formfillby:
                                                          'serviceBeneficiary',
                                                      formType:
                                                          'تفاصيل الطلب للبائع',
                                                      uid: [
                                                        userController
                                                            .currentUser
                                                            .value
                                                            .uid!,
                                                        userController
                                                            .specificUser
                                                            .value
                                                            .uid!
                                                      ],
                                                      name: nameController.text,
                                                      phoneNumber:
                                                          phoneController.text,
                                                      purpose: purposeController
                                                          .text,
                                                      days: timeController.text,
                                                      secondPartyMobile:
                                                          '${countryCode.replaceAll('+', '')}${secondphoneController.text}',
                                                      description:
                                                          desController.text,
                                                      address: addressController
                                                          .text,
                                                      price: result.toString(),
                                                      agree1: isSwitched,
                                                      agree2: isSwitched2,
                                                      images: [],
                                                      isAccepted: '',
                                                      ayam: 'ايام',
                                                      ayamNumber: ayamNumber!,
                                                      review: '',
                                                      orderCompleted: false,
                                                      serviceCompleted: false,
                                                      byerUid: userController
                                                          .currentUser
                                                          .value
                                                          .uid!,
                                                      sellerUid: userController
                                                          .specificUser
                                                          .value
                                                          .uid!,
                                                    );

                              await oneSignals.sendNotification(
                                  userController.specificUser.value.token!,
                                  '${controller.currentUser.value.name!} Send the Request',
                                  'مرحبا بك في تطبيق وسيط: يوجد لديك طلب (order detail) يرجى إكمال الطلب',
                                  'assets/logo/jpeg',
                                  token:
                                      userController.specificUser.value.token!,
                                  senderName:
                                      controller.currentUser.value.name!,
                                  type: 'mishtri');
                              await FirebaseFirestore.instance
                                  .collection('notification')
                                  .add({
                                'body':
                                    'مرحبا بك في تطبيق وسيط: يوجد لديك طلب (order detail) يرجى إكمال الطلب',
                                'senderName':
                                    controller.currentUser.value.name!,
                                'uid': userController.specificUser.value.uid!,
                                'createdAt': DateTime.now(),
                                'time': DateTime.now().toString(),
                                'read': false,
                                'type': 'mishtri',
                              });
                              await userController.updateUserInForm(
                                UserModel(
                                  token:
                                      userController.currentUser.value.token!,
                                  name: nameController.text,
                                  phoneNumber: phoneController.text,
                                  location: addressController.text.trim(),
                                  email: userController.currentUser.value.email,
                                  profileImage: userController
                                      .currentUser.value.profileImage,
                                  uid: userController.currentUser.value.uid,
                                  walletBalance: userController
                                      .currentUser.value.walletBalance,
                                ),
                              );
                            }
                          }),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
