import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waist_app/controller/mishtri_controller.dart';
import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/screens/order/widget/order_box.dart';

import '../../widgets/arrowButton.dart';
import '../orderDetails.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
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
          child: ListView(
            children: [
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
                    'الطلبات النشطة',
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
              GetBuilder<MishtariController>(
                  init: MishtariController(),
                  builder: (controller) {
                    return controller.allMishtari.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: controller.allMishtari.length,
                            itemBuilder: (context, index) {
                              BuyerModel buyerData =
                                  controller.allMishtari[index];
                              DateTime date = DateTime.parse(buyerData.days!);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: OrderBox(
                                  orderNumber: '#${buyerData.orderNumber}',
                                  date: DateFormat('dd/MM/yyyy  hh:mm ')
                                      .format(date),
                                  purpose: buyerData.purpose!,
                                  orderStatus: 'توصيل طلبية',
                                  onPressed: () {
                                    Get.to(() =>
                                        OrdersDetails(buyerModel: buyerData));
                                  },
                                ),
                              );
                            })
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 180.h,
                              ),
                              Text(
                                'لا يوجد طلبات نشطة',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
