import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:waist_app/Services/phone_services.dart';
import 'package:waist_app/widgets/logo.dart';

import '../../constants/colors.dart';
import '../../widgets/button.dart';
import '../privacy_policy/privacy_policy.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  int? length;
  var countryCodeController = TextEditingController(text: '+966');
  var phoneNumberController = TextEditingController();
  PhoneService service = PhoneService();
  String countryCode = '+966';
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
            const SizedBox(
              height: 50,
            ),
            const LogoConatiner(),

            const SizedBox(
              height: 100,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                maxLength: 9,
                keyboardType: TextInputType.phone,
                controller: phoneNumberController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(width: 0.1)),
                  labelText: 'رقم الهاتف',
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
                  width: 280.w,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        Text(
                          "بالضغط علي تسجيل الدخول فأنت توافق علي'",
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
            const SizedBox(
              height: 15,
            ),
            // MyButton(),
            MyButton(
              name: 'التالي',
              onPressed: () async {
                String number =
                    '${countryCodeController.text}${phoneNumberController.text}';
                phoneNumberController.text.trim().isNotEmpty &&
                        isSwitched == true
                    ? service.verificationPhoneNumber(context, number)
                    : Fluttertoast.showToast(
                        msg: 'من فضلك ادخل رقم الهاتف و اوافق علي الشروط');
              },
            ),
            const SizedBox(
              height: 200,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: BC.appColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'فيديو تعريفي للتطبيق',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: BC.appColor),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
