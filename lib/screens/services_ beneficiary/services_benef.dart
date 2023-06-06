import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/screens/mishtari/widget/input_field.dart';
import 'package:waist_app/screens/widget/button.dart';
import 'package:waist_app/services/firebase_services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'مستفيد من الخدمة',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: BC.appColor,
                radius: 13.h,
                child: RotatedBox(
                    quarterTurns: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 17.h,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
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
                    InputField(
                      calender: false,
                      type: TextInputType.name,
                      color: Colors.transparent,
                      controller: nameController,
                      title: 'اسم الطرف',
                      hinttext: 'اسم الطرف',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InputField(
                      calender: false,
                      type: TextInputType.phone,
                      color: Colors.transparent,
                      controller: phoneController,
                      title: 'الجوال',
                      hinttext: '+966 xx-xxx-xxxx',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InputField(
                      calender: false,
                      type: TextInputType.name,
                      color: Colors.transparent,
                      controller: addressController,
                      title: 'المدينة',
                      hinttext: 'المدينة',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            InputField(
              calender: false,
              type: TextInputType.name,
              color: Theme.of(context).scaffoldBackgroundColor,
              controller: purposeController,
              title: 'الغرض من الحوالة',
              hinttext: 'الغرض من الحوالة',
            ),
            SizedBox(
              height: 10.h,
            ),
            InputField(
              calender: false,
              type: TextInputType.number,
              color: Theme.of(context).scaffoldBackgroundColor,
              controller: commodityController,
              title: 'قيمة السلعة',
              hinttext: 'قيمة السلعة',
            ),
            SizedBox(
              height: 10.h,
            ),
            InputField(
              calender: false,
              type: TextInputType.name,
              color: Theme.of(context).scaffoldBackgroundColor,
              controller: desController,
              title: 'وصف السلعة(اختياري)',
              hinttext: 'وصف السلعة(اختياري)',
            ),
            SizedBox(
              height: 10.h,
            ),
            InputField(
              calenderFunction: () {},
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
            InputField(
              calender: false,
              type: TextInputType.phone,
              color: Theme.of(context).scaffoldBackgroundColor,
              controller: secondphoneController,
              title: 'جوال الطرف الثاني',
              hinttext: '+966-xx-xxx-xxxx',
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
                          days: timeController.text,
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
    );
  }
}
