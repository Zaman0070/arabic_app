import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waist_app/widgets/button.dart';
import 'package:waist_app/widgets/textFormfield.dart';

import '../constants/colors.dart';

import '../widgets/arrowButton.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var valueController = TextEditingController();
  var resultController = TextEditingController();
  double calculateFivePercent(double value) {
    double result = value * 0.05;
    return result;
  }

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
                    'حساب العمولة',
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
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(' 5% '),
                  Text(
                    'عمولة التطبيق',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                    SizedBox(
                      height: 10.h,
                    ),
                    MytextField(
                      type: TextInputType.number,
                      controller: valueController,
                      text: 'قيمة السلعة او الخدمة',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    MytextField(
                      controller: resultController,
                      text: 'العمولة شامل الضريبة',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    MyButton(
                      onPressed: () {
                        double value = double.parse(valueController.text);
                        double result = calculateFivePercent(value);
                        resultController.text = result.toString();
                      },
                      name: 'احسب العمولة',
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
