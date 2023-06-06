import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/screens/mishtari/mistari_page_form.dart';
import 'package:waist_app/screens/services_%20beneficiary/services_benef.dart';
import 'package:waist_app/widgets/bottomNavi.dart';
import '../../widgets/arrowButton.dart';

class NewOrder extends StatefulWidget {
  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 30,
              ),
              const Text(
                'طلب جديد',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ArrowButton(
                onPressed: () {
                  Get.offAll(() => BottomNavigationExample());
                },
              )
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  Get.to(() => MistariPage());
                },
                child: const Image(image: AssetImage('assets/Group 85.png')),
              )),
              Expanded(
                  child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Alert Dialog"),
                          content: Text("تحت تطوير البيانات الخلفية"),
                          actions: [
                            TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            BC.appColor)),
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(
                                  'نعم',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        );
                      });
                },
                child: const Image(image: AssetImage('assets/Group 84.png')),
              ))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  Get.to(() => ServicesBeneficary());
                },
                child: const Image(image: AssetImage('assets/Group 89.png')),
              )),
              Expanded(
                  child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Alert Dialog"),
                          content: Text("تحت تطوير البيانات الخلفية"),
                          actions: [
                            TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            BC.appColor)),
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(
                                  'نعم',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        );
                      });
                },
                child: const Image(image: AssetImage('assets/Group 88.png')),
              ))
            ],
          )
        ],
      ),
    ));
  }
}
