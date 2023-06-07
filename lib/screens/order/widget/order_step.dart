import 'package:flutter/material.dart';
import 'package:waist_app/constants/colors.dart';

class OrderStep extends StatelessWidget {
  const OrderStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: BC.appColor,
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
            const Text(
              'تحويل المبلغ',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: BC.appColor,
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
            const Text(
              'قيد التنفيذ',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
              decoration: BoxDecoration(
                  color: BC.appColor, borderRadius: BorderRadius.circular(10)),
            ),
            const Text(
              'استلام المبلغ',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
              decoration: BoxDecoration(
                  color: BC.appColor, borderRadius: BorderRadius.circular(10)),
            ),
            const Text(
              'تقديم الطلب',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
