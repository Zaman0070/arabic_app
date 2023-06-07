import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waist_app/controller/image_controller.dart';
import 'package:waist_app/screens/buy&mishtari/widget/input_field.dart';
import 'package:waist_app/services/firebase_services.dart';
import 'package:waist_app/widgets/textFormfield.dart';
import '../../constants/colors.dart';
import '../../widgets/UploadImageButton.dart';
import '../../widgets/arrowButton.dart';
import '../../widgets/button.dart';

class TheSeller extends StatefulWidget {
  const TheSeller({super.key});

  @override
  State<TheSeller> createState() => _TheSellerState();
}

class _TheSellerState extends State<TheSeller> {
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  var priceController = TextEditingController();
  var desController = TextEditingController();
  var daysController = TextEditingController();
  var secondPartyMobileController = TextEditingController();
  List<String> images = [];
  String ayamDate = '';
  bool second = false;
  bool isSwitched = false;
  bool isSwitched2 = false;
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
                    'البائع',
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
                        const Text(
                          'محمد وحيد',
                          style: TextStyle(
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '+966 xx-xxx-xxxx',
                          style: TextStyle(
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'شارع  9 جبل حفيت',
                          style: TextStyle(
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
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              UploadButton(
                image: imagePickerController.selectedImages.isEmpty
                    ? Container()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(imagePickerController.selectedImages[0].path),
                          height: 40.h,
                          width: 40.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                press: () {
                  Get.bottomSheet(
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
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
              const SizedBox(
                height: 20,
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
                text: 'وصف السلعة(اختياري)',
                hint: 'وصف السلعة(اختياري)',
              ),
              SizedBox(
                height: 15.h,
              ),
              InputField(
                calenderFunction: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    ayamDate = picked.toString();
                    DateTime date = DateTime.parse(ayamDate);
                    int days = date.difference(DateTime.now()).inDays;
                    daysController.text = '${days.toString()} ايام';
                    // timeController.text =
                    //     DateFormat('dd MMM yyyy').format(picked);
                  }
                },
                calender: true,
                type: TextInputType.name,
                color: Theme.of(context).scaffoldBackgroundColor,
                controller: daysController,
                title: 'الوقت المتوقع لأنهاء الصفقة',
                hinttext: '7 ايام',
              ),
              SizedBox(
                height: 15.h,
              ),
              MytextField(
                type: TextInputType.name,
                controller: secondPartyMobileController,
                text: 'جوال الطرف الثاني',
                hint: '+966-xx-xxx-xxxx',
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
                      'أتعهد بأن تكون السلعة حسب المتفق عليها وفي خلاف ذلك سيتم استرجاع المبلغ للطرف الأول',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
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
                height: 8.h,
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
                      style: TextStyle(fontSize: 12.sp),
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
                  priceController.text.trim() == '' ||
                          daysController.text.trim() == '' ||
                          secondPartyMobileController.text.trim() == '' ||
                          isSwitched == false ||
                          isSwitched2 == false ||
                          desController.text.trim() == ''
                      ? Fluttertoast.showToast(msg: 'جميع الحقول مطلوبة')
                      : imagePickerController.selectedImages.isNotEmpty
                          ? await FirebaseServices().addSellerData(
                              days: ayamDate,
                              secondPartyMobile:
                                  secondPartyMobileController.text,
                              description: desController.text,
                              price: priceController.text,
                              agree1: isSwitched,
                              agree2: isSwitched2,
                              images: images[0])
                          : Fluttertoast.showToast(msg: 'الرجاء اختيار صورة');
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
