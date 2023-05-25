import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/screens/mishtari/widget/input_field.dart';
import 'package:waist_app/screens/mishtari/widget/upload_image.dart';

// ignore: must_be_immutable
class MistariPage extends StatefulWidget {
  MistariPage({super.key});

  @override
  State<MistariPage> createState() => _MistariPageState();
}

class _MistariPageState extends State<MistariPage> {
  bool value = false;
  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var secondphoneController = TextEditingController();

  var addressController = TextEditingController();

  var commodityController = TextEditingController();

  var purposeController = TextEditingController();

  var desController = TextEditingController();

  var timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'المشتري',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: BC.appColor,
                radius: 13.h,
                child: RotatedBox(
                    quarterTurns: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 17.h,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: BC.appColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: BC.appColor)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Column(
                  children: [
                    InputField(
                      color: Colors.transparent,
                      controller: nameController,
                      title: 'اسم الطرف',
                      hinttext: '',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InputField(
                      color: Colors.transparent,
                      controller: phoneController,
                      title: 'الجوال',
                      hinttext: '',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InputField(
                      color: Colors.transparent,
                      controller: addressController,
                      title: 'المدينة',
                      hinttext: '',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: UploadImage(
                onTap: () {},
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            InputField(
              color: Theme.of(context).scaffoldBackgroundColor,
              controller: purposeController,
              title: 'الغرض من الحوالة',
              hinttext: '',
            ),
            SizedBox(
              height: 10.h,
            ),
            InputField(
              color: Theme.of(context).scaffoldBackgroundColor,
              controller: commodityController,
              title: 'قيمة السلعة',
              hinttext: '',
            ),
            SizedBox(
              height: 10.h,
            ),
            InputField(
              color: Theme.of(context).scaffoldBackgroundColor,
              controller: desController,
              title: 'وصف السلعة(اختياري)',
              hinttext: '',
            ),
            SizedBox(
              height: 10.h,
            ),
            InputField(
              color: Theme.of(context).scaffoldBackgroundColor,
              controller: timeController,
              title: 'الوقت المتوقع لأنهاء الصفقة',
              hinttext: '',
            ),
            SizedBox(
              height: 10.h,
            ),
            InputField(
              color: Theme.of(context).scaffoldBackgroundColor,
              controller: secondphoneController,
              title: 'جوال الطرف الثاني',
              hinttext: '',
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Checkbox(
                    value: value,
                    onChanged: (val) {
                      setState(() {
                        value = val!;
                      });
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
