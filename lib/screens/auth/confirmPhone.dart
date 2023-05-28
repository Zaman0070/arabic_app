// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:waist_app/services/phone_services.dart';
import 'package:waist_app/widgets/arrowButton.dart';

import '../../constants/colors.dart';
import '../../widgets/bottomNavi.dart';
import '../../widgets/button.dart';
import '../../widgets/otpInput.dart';

class OTP extends StatefulWidget {
  final String? number;
  final String? verId;
  OTP({this.number, this.verId});
  @override
  State<OTP> createState() => _LoginPageState();
}

class _LoginPageState extends State<OTP> {
  String error = '';

  PhoneService _phoneService = PhoneService();
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  Future<void> phoneCredential(BuildContext context, String otp) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      SmartDialog.showLoading();
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verId!, smsCode: otp);
      // need to oto validate or no

      final authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user!;

      // ignore: unnecessary_null_comparison
      if (user != null) {
        _phoneService.users.doc(user.uid).set({
          'uid': user.uid,
          'mobile': user.phoneNumber,
        }).then((value) {
          Get.offAll(() => BottomNavigationExample());

          // ignore: invalid_return_type_for_catch_error
        }).catchError((error) =>
            // ignore: invalid_return_type_for_catch_error
            Fluttertoast.showToast(msg: 'Faild to add user : $error'));
        SmartDialog.dismiss();
      } else {
        print('login Failed');
        if (mounted) {
          setState(() {
            error = 'login failed';
          });
        }
      }
    } catch (e) {
      print(e.toString());
      if (mounted) {
        setState(() {
          error = 'Invalid OTP';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ArrowButton(
                    onPressed: () {},
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/Phone.png',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OtpInput(_fieldOne, true),
                      ),
                      Expanded(
                        child: OtpInput(_fieldTwo, false),
                      ),
                      Expanded(
                        child: OtpInput(_fieldThree, false),
                      ),
                      Expanded(child: OtpInput(_fieldFour, false)),
                      Expanded(child: OtpInput(_fieldFive, false)),
                      Expanded(child: OtpInput(_fieldSix, false)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '60 ثانية',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: BC.appColor),
                      ),
                      const Text(
                        'يرجي ادخال رمز التحقق المرسل الي هاتفك',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyButton(
                    name: 'التالي',
                    onPressed: () {
                      if (_fieldOne.text.length == 1) {
                        if (_fieldTwo.text.length == 1) {
                          if (_fieldThree.text.length == 1) {
                            if (_fieldFour.text.length == 1) {
                              if (_fieldFive.text.length == 1) {
                                String _otp =
                                    '${_fieldOne.text}${_fieldTwo.text}'
                                    '${_fieldThree.text}${_fieldFour.text}'
                                    '${_fieldFive.text}${_fieldSix.text}';

                                setState(() {
                                  phoneCredential(context, _otp);
                                });

                                // login
                              }
                            }
                          }
                        }
                      } else {}
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      _showDialog();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: BC.appColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'إعادة ارسال الرمز',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: BC.appColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            content: SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('تم تأكيد الدخول'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'وسيط ',
                        style: TextStyle(color: BC.appColor),
                      ),
                      const Text('مرحباً بك في تطبيق'),
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
