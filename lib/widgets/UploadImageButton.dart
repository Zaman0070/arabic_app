import 'package:flutter/material.dart';
import '../constants/colors.dart';

// ignore: must_be_immutable
class UploadButton extends StatelessWidget {
  Widget image;
  Function()? press;

  UploadButton({super.key, this.press, required this.image});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: BC.appColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              image,
              Text(
                'تحميل صورة السلعة',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: BC.appColor,
                    fontSize: 16),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
