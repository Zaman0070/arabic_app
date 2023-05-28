import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waist_app/services/phone_services.dart';
import 'package:waist_app/widgets/logo.dart';

import '../../constants/colors.dart';
import '../../widgets/button.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  bool validate = false;
  int? length;
  var countryCodeController = TextEditingController(text: '+966');
  var phoneNumberController = TextEditingController();
  PhoneService _service = PhoneService();
  String countryCode = '+966';
  // List<String> country(BuildContext context) => [
  //       '+967',
  //       '+92',
  //     ];
  validation() {
    if (phoneNumberController.text.isEmpty) {
    } else if (phoneNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("please enter your correct phoneNumber"),
          duration: Duration(milliseconds: 300),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
            LogoConatiner(),

            const SizedBox(
              height: 100,
            ),

            Stack(
              // overflow: Overflow.visible,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: BC.appColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: BC.appColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              countryCode,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: TextFormField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.right,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Required";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'XX-XXX-XXXX',
                            contentPadding: EdgeInsets.only(top: 0),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 15,
                  top: -10,
                  child: Container(
                      color: Colors.white,
                      child: Text(
                        'رقم الهاتف',
                        style: TextStyle(color: BC.appColor),
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 15,
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
                    ? _service.verificationPhoneNumber(context, number)
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
