import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/controller/image_controller.dart';
import 'package:waist_app/screens/widget/button.dart';
import 'package:waist_app/Services/firebase_services.dart';
import 'package:waist_app/widgets/UploadImageButton.dart';
import 'package:waist_app/widgets/textFormfield.dart';

import '../../controller/user_controller.dart';
import '../../widgets/arrowButton.dart';

// ignore: must_be_immutable
class MistariPage extends StatefulWidget {
  MistariPage({super.key});

  @override
  State<MistariPage> createState() => _MistariPageState();
}

class _MistariPageState extends State<MistariPage> {
  bool value = false;

  var secondphoneController = TextEditingController(text: "");

  var commodityController = TextEditingController(text: '0');

  var purposeController = TextEditingController();

  var desController = TextEditingController();

  var timeController = TextEditingController();
  String ayamDate = '';
  String countryCode = '+966';

  bool isSwitched = false;
  bool isSwitched2 = false;
  int result = 0;
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  List<String> images = [];

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
                          'المشتري',
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
                              type: TextInputType.name,
                              controller: nameController,
                              text: 'اسم الطرف',
                              hint: 'اسم الطرف',
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            MytextField(
                              type: TextInputType.phone,
                              controller: phoneController,
                              text: 'الجوال',
                              hint: '+966 xx-xxx-xxxx',
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            AppTextField(
                                isDropDown: true,
                                dropDownOnTap: () {},
                                list: const [
                                  'مكة المكرمة',
                                  'المدينة المنورة',
                                  'الجوف',
                                ],
                                controller: addressController,
                                hint: 'المدينة',
                                label: ''),
                            // MytextField(
                            //   type: TextInputType.name,
                            //   controller: addressController,
                            //   text: 'المدينة',
                            //   hint: 'المدينة',
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: UploadButton(
                        image: imagePickerController.selectedImages.isEmpty
                            ? Container()
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(imagePickerController
                                      .selectedImages[0].path),
                                  height: 40.h,
                                  width: 40.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        press: () {
                          Get.bottomSheet(
                            Container(
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25))),
                              child: Padding(
                                padding: const EdgeInsets.all(22.0),
                                child: Column(
                                  textDirection: TextDirection.rtl,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        images = await imagePickerController
                                            .pickImage(ImageSource.camera)
                                            .whenComplete(() {
                                          Get.back();
                                        });
                                      },
                                      child: Text(
                                        'اختر صورة من الكاميرا',
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                    ),
                                    Divider(
                                      color: BC.appColor,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        images = await imagePickerController
                                            .pickImage(ImageSource.gallery)
                                            .whenComplete(() {
                                          Get.back();
                                        });
                                      },
                                      child: Text('اختر صورة من المعرض',
                                          style: TextStyle(fontSize: 16.sp)),
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
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    MytextField(
                      type: TextInputType.name,
                      controller: purposeController,
                      text: 'الغرض من الحوالة',
                      hint: 'الغرض من الحوالة',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    MytextField(
                      type: TextInputType.number,
                      controller: commodityController,
                      text: 'قيمة السلعة',
                      hint: 'قيمة السلعة',
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
                    AppTextField(
                        isDropDown: true,
                        dropDownOnTap: () {},
                        list: const [
                          '1 ايام  ',
                          '2 ايام  ',
                          '3 ايام  ',
                          '4 ايام  ',
                          '5 ايام  ',
                          '6 ايام  ',
                          '7 ايام  ',
                          '10 ايام  ',
                          '15 ايام  ',
                          '21 ايام  ',
                          '30 ايام  ',
                          '45 ايام  ',
                          '60 ايام  ',
                        ],
                        controller: timeController,
                        hint: 'الوقت المتوقع لأنهاء الصفقة',
                        label: ''),
                    // InputField(
                    //   calenderFunction: () async {
                    //     final DateTime? picked = await showDatePicker(
                    //       context: context,
                    //       initialDate: DateTime.now(),
                    //       firstDate: DateTime(2015, 8),
                    //       lastDate: DateTime(2101),
                    //     );
                    //     if (picked != null) {
                    //       ayamDate = picked.toString();
                    //       DateTime date = DateTime.parse(ayamDate);
                    //       int days = date.difference(DateTime.now()).inDays;
                    //       timeController.text = '${days.toString()} ايام';
                    //       // timeController.text =
                    //       //     DateFormat('dd MMM yyyy').format(picked);
                    //     }
                    //   },
                    //   calender: true,
                    //   type: TextInputType.name,
                    //   color: Theme.of(context).scaffoldBackgroundColor,
                    //   controller: timeController,
                    //   title: 'الوقت المتوقع لأنهاء الصفقة',
                    //   hinttext: '7 ايام',
                    // ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        controller: secondphoneController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(width: 0.1)),
                          labelText: 'رقم الهاتف',
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
                          ),
                        ),
                      ),
                    ),
                    // MytextField(
                    //   type: TextInputType.number,
                    //   controller: secondphoneController,
                    //   text: 'جوال الطرف الثاني',
                    //   hint: '+966-xx-xxx-xxxx',
                    // ),
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
                              result = int.parse(commodityController.text) + 20;
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
                            "أوافق على شروط و أحكام تطبيق وسيط",
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
                              isSwitched2 = !isSwitched2;
                              result = int.parse(commodityController.text) + 20;
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
                      height: 10.h,
                    ),
                    Row(
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
                    SizedBox(
                      height: 20.h,
                    ),
                    AppButton(
                        text: 'تأكيد الطلب و الدفع',
                        onPressed: () async {
                          nameController.text.trim() == '' ||
                                  phoneController.text.trim() == '' ||
                                  purposeController.text.trim() == '' ||
                                  commodityController.text.trim() == '' ||
                                  timeController.text.trim() == '' ||
                                  // secondphoneController.text.trim() == '' ||
                                  isSwitched == false ||
                                  isSwitched2 == false ||
                                  desController.text.trim() == ''
                              // addressController.text.trim() == ''
                              ? Fluttertoast.showToast(
                                  msg: 'جميع الحقول مطلوبة')
                              : imagePickerController.selectedImages.isNotEmpty
                                  ? await FirebaseServices().addMishtriDetails(
                                      name: nameController.text,
                                      phoneNumber: phoneController.text,
                                      purpose: purposeController.text,
                                      days: ayamDate,
                                      secondPartyMobile:
                                          secondphoneController.text,
                                      description: desController.text,
                                      address: addressController.text,
                                      price: result.toString(),
                                      agree1: isSwitched,
                                      agree2: isSwitched2,
                                      images: images[0])
                                  : Fluttertoast.showToast(
                                      msg: 'الرجاء اختيار صورة');
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
