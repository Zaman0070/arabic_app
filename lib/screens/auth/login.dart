import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waist_app/services/phone_services.dart';
import 'package:waist_app/widgets/logo.dart';

import '../../constants/colors.dart';
import '../../widgets/button.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  int? length;
  var countryCodeController = TextEditingController(text: '+92');
  var phoneNumberController = TextEditingController();
  PhoneService service = PhoneService();
  String countryCode = '+92';

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
                maxLength: 10,
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'شروط الأستخدام',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                      color: BC.appColor),
                ),
                Text(
                  'بالضغط علي تسجيل الدخول فأنت توافق علي',
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
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
                phoneNumberController.text.trim().isNotEmpty
                    ? service.verificationPhoneNumber(context, number)
                    : Fluttertoast.showToast(
                        msg: 'Please Enter your Phone Number');
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
