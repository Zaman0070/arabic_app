import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:waist_app/screens/buy&mishtari/widget/input_field.dart';
import 'package:waist_app/Services/firebase_services.dart';
import 'package:waist_app/widgets/textFormfield.dart';

import '../../constants/colors.dart';

import '../../widgets/arrowButton.dart';
import '../../widgets/button.dart';

class ServiceProvider extends StatefulWidget {
  @override
  State<ServiceProvider> createState() => _ServiceProviderState();
}

class _ServiceProviderState extends State<ServiceProvider> {
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
                type: TextInputType.number,
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
                      : await FirebaseServices().addServiceProvider(
                          days: ayamDate,
                          secondPartyMobile: secondPartyMobileController.text,
                          description: desController.text,
                          price: priceController.text,
                          agree1: isSwitched,
                          agree2: isSwitched2,
                        );
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
