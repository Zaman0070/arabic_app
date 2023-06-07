import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/screens/buy&mishtari/widget/input_field.dart';
import 'package:waist_app/screens/widget/button.dart';
import 'package:waist_app/services/firebase_services.dart';
import 'package:waist_app/widgets/arrowButton.dart';
import 'package:waist_app/widgets/textFormfield.dart';

// ignore: must_be_immutable
class ServicesBeneficary extends StatefulWidget {
  ServicesBeneficary({super.key});

  @override
  State<ServicesBeneficary> createState() => _ServicesBeneficaryState();
}

class _ServicesBeneficaryState extends State<ServicesBeneficary> {
  bool value = false;
  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var secondphoneController = TextEditingController();

  var addressController = TextEditingController();

  var commodityController = TextEditingController(text: '0');

  var purposeController = TextEditingController();

  var desController = TextEditingController();

  var timeController = TextEditingController();
  bool isSwitched = false;
  bool isSwitched2 = false;
  int result = 0;
  String ayamDate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
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
                      MytextField(
                        type: TextInputType.name,
                        controller: addressController,
                        text: 'المدينة',
                        hint: 'المدينة',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
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
                    timeController.text = '${days.toString()} ايام';
                    // timeController.text =
                    //     DateFormat('dd MMM yyyy').format(picked);
                  }
                },
                calender: true,
                type: TextInputType.name,
                color: Theme.of(context).scaffoldBackgroundColor,
                controller: timeController,
                title: 'الوقت المتوقع لأنهاء الصفقة',
                hinttext: '7 ايام',
              ),
              SizedBox(
                height: 10.h,
              ),
              MytextField(
                type: TextInputType.name,
                controller: secondphoneController,
                text: 'جوال الطرف الثاني',
                hint: '+966-xx-xxx-xxxx',
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
                        color: isSwitched2 ? BC.appColor : Colors.transparent,
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
                            secondphoneController.text.trim() == '' ||
                            isSwitched == false ||
                            isSwitched2 == false ||
                            desController.text.trim() == '' ||
                            addressController.text.trim() == ''
                        ? Fluttertoast.showToast(msg: 'جميع الحقول مطلوبة')
                        : await FirebaseServices().addServiceBeneficary(
                            name: nameController.text,
                            phoneNumber: phoneController.text,
                            purpose: purposeController.text,
                            days: ayamDate,
                            secondPartyMobile: secondphoneController.text,
                            description: desController.text,
                            address: addressController.text,
                            price: result.toString(),
                            agree1: isSwitched,
                            agree2: isSwitched2,
                          );
                  }),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
