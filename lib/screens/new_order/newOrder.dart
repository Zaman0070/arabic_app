import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waist_app/screens/bottom_nav/bottomNavi.dart';
import 'package:waist_app/screens/buy&mishtari/mistari_page_form.dart';
import 'package:waist_app/screens/seller&baya/theSeller.dart';
import 'package:waist_app/screens/services_%20beneficiary/services_benef.dart';
import 'package:waist_app/screens/services_provider/serviceProvider.dart';
import '../../widgets/arrowButton.dart';

class NewOrder extends StatefulWidget {
  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const BottomNavigationExample());
        return true;
      },
      child: Scaffold(
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
                    Get.offAll(() => const BottomNavigationExample());
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
                    Get.to(() => MistariPage(
                          id: '',
                        ));
                  },
                  child: const Image(image: AssetImage('assets/Group 85.png')),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Get.to(() => TheSeller(
                          id: '',
                        ));
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
                    Get.to(() => ServiceProvider());
                  },
                  child: const Image(image: AssetImage('assets/Group 88.png')),
                ))
              ],
            )
          ],
        ),
      )),
    );
  }
}
