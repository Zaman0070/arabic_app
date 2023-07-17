import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:waist_app/Services/firebase_services.dart';
import 'package:waist_app/Services/onsignal.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/screens/privacy_policy/privacy_policy.dart';
import 'package:waist_app/widgets/textFormfield.dart';

import '../../constants/colors.dart';

import '../../widgets/arrowButton.dart';
import '../../widgets/button.dart';

class ServiceProvider extends StatefulWidget {
  const ServiceProvider({super.key});

  @override
  State<ServiceProvider> createState() => _ServiceProviderState();
}

class _ServiceProviderState extends State<ServiceProvider> {
  var priceController = TextEditingController();
  var desController = TextEditingController();
  var daysController = TextEditingController();
  var secondPartyMobileController = TextEditingController();
  UserController userController = Get.put(UserController());

  List<String> images = [];
  int result = 0;
  List<String> uids = [];
  OneSignals oneSignals = OneSignals();

  String ayamDate = '';
  bool second = false;
  bool isSwitched = false;
  bool isSwitched2 = false;
  String countryCode = '+966';

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
  OptionItem optionItemSelectedday = OptionItem(title: "    ايام");
  OptionItem optionItemSelectedday1 = OptionItem(title: "1");
  String? ayam;
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
          child: SingleChildScrollView(
            child: Column(children: [
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
                    'مقدم الخدمة',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          userController.currentUser.value.name!,
                          style: TextStyle(
                            fontSize: 13.sp,
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '+${userController.currentUser.value.phoneNumber!}',
                          style: TextStyle(
                            fontSize: 13.sp,
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          userController.currentUser.value.location!,
                          style: TextStyle(
                            fontSize: 13.sp,
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
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              MytextField(
                type: TextInputType.number,
                controller: priceController,
                text: 'قيمة السلعة',
                hint: 'قيمة السلعة',
              ),
              SizedBox(
                height: 15.h,
              ),
              MytextField(
                type: TextInputType.name,
                controller: desController,
                text: 'وصف الخدمة(اختياري)',
                hint: 'وصف الخدمة(اختياري)',
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: BC.appColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: BC.grey)),
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
                          icon: Icon(Icons.person, color: BC.appColor),
                          onOptionSelected: (optionItem) {
                            optionItemSelectedday1 = optionItem;
                            ayamNumber = optionItem.title;
                            daysController.text = optionItem.title;
                            daysController.text = DateTime.now()
                                .add(Duration(days: int.parse(optionItem.id!)))
                                .toString();
                            setState(() {});
                          },
                        ),
                      ),
                      // Expanded(
                      //   flex: 3,
                      //   child: SelectDropList(
                      //     height: 40.h,
                      //     containerDecoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(color: Colors.transparent),
                      //         color: Colors.transparent),
                      //     containerPadding: const EdgeInsets.only(left: 10),
                      //     containerMargin: EdgeInsets.zero,
                      //     itemSelected: optionItemSelectedday,
                      //     dropListModel: dropListModeldays,
                      //     showIcon: false, // Show Icon in DropDown Title
                      //     showArrowIcon: true, // Show Arrow Icon in DropDown
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
                      Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 40.h,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'ايام',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  const Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  controller: secondPartyMobileController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 0.1)),
                    labelText: 'رقم هاتف المستفيد',
                    hintText: 'XX-XXX-XXXX',
                    contentPadding: const EdgeInsets.only(top: 0, right: 15),
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
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 290.w,
                    child: Text(
                      'أتعهد بأن تكون الخدمة حسب المتفق عليها وفي خلاف ذلك سيتم استرجاع المبلغ للطرف الأول',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  InkWell(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection('users')
                          .where('phoneNumber',
                              isEqualTo:
                                  '${countryCode.replaceAll('+', "")}${secondPartyMobileController.text}')
                          .get()
                          .then((value) {
                        List<String> uid = value.docs.map((e) => e.id).toList();
                        uids = uid;

                        userController.getSpecificUser(uid[0]);
                        print(uids[0]);
                      });
                      setState(() {
                        isSwitched = !isSwitched;
                        result = int.parse(priceController.text) + 20;
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
                height: 8.h,
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
                    width: 25.w,
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
              SizedBox(
                height: 20.h,
              ),
              MyButton(
                name: 'تأكيد الطلب',
                onPressed: () async {
                  var random = Random();
                  int randomNumber = random.nextInt(100000000);
                  priceController.text.trim() == '' ||
                          daysController.text.trim() == '' ||
                          secondPartyMobileController.text.trim() == '' ||
                          isSwitched == false ||
                          isSwitched2 == false
                      ? Fluttertoast.showToast(msg: 'جميع الحقول مطلوبة')
                      : await FirebaseServices().addMishtriDetails(
                          timeExtandRequest: '',
                          timeExtandRequestAccepted: false,
                          serviceCompleted: false,
                          orderCompleted: false,
                          orderNumber: randomNumber,
                          review: '',
                          formfillby: 'serviceProvider',
                          formType: 'تفاصيل الطلب للمشتري',
                          uid: [
                            userController.currentUser.value.uid!,
                            userController.specificUser.value.uid!
                          ],
                          name: userController.currentUser.value.name!,
                          phoneNumber:
                              userController.currentUser.value.phoneNumber!,
                          purpose: '',
                          days: daysController.text,
                          secondPartyMobile:
                              '${countryCode.replaceAll('+', '')}${secondPartyMobileController.text}',
                          description: desController.text,
                          address: userController.currentUser.value.location!,
                          price: result.toString(),
                          agree1: isSwitched,
                          agree2: isSwitched2,
                          images: [],
                          isAccepted: '',
                          ayam: 'ايام',
                          ayamNumber: ayamNumber!,
                          byerUid: userController.specificUser.value.uid!,
                          sellerUid: userController.currentUser.value.uid!,
                        );
                  await oneSignals.sendNotification(
                      userController.specificUser.value.token!,
                      '${userController.currentUser.value.name!} Send the Request',
                      'مرحبا بك في تطبيق وسيط: يوجد لديك طلب (order detail) يرجى إكمال الطلب',
                      'assets/logo/jpeg',
                      token: userController.specificUser.value.token!,
                      senderName: userController.currentUser.value.name!,
                      type: 'mishtri');
                },
              ),
              SizedBox(
                height: 20.h,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
