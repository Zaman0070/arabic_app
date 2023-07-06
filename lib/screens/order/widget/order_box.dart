import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/screens/order/widget/order_step.dart';
import 'package:waist_app/widgets/button.dart';

// ignore: must_be_immutable
class OrderBox extends StatelessWidget {
  BuyerModel buyerModel;
  String orderNumber;
  String date;
  String purpose;
  String orderStatus;
  Function() onPressed;
  OrderBox(
      {super.key,
      required this.orderNumber,
      required this.buyerModel,
      required this.date,
      required this.purpose,
      required this.orderStatus,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: BC.appColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: BC.appColor)),
      child: Column(
        children: [
           OrderStep(
            buyerModel: buyerModel,
           ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderNumber,
                style: TextStyle(
                  fontSize: 13,
                  color: BC.appColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'رقم الطلب',
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
              Text(
                '$date م',
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'التاريخ و الوقت',
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
              Text(
                purpose,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'الغرض',
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
              Text(
                orderStatus,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'حالة الطلب',
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
          MyButton(name: 'متابعة الطلب', onPressed: onPressed)
        ],
      ),
    );
  }
}
