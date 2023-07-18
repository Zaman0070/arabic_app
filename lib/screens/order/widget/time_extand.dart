import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:waist_app/Services/onsignal.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/model/user.dart';
import 'package:waist_app/screens/bottom_nav/bottomNavi.dart';
import 'package:waist_app/widgets/loading.dart';

// ignore: must_be_immutable
class TimeExtand extends StatefulWidget {
  String id;
  UserModel user;
  TimeExtand({super.key, required this.id, required this.user});

  @override
  State<TimeExtand> createState() => _TimeExtandState();
}

class _TimeExtandState extends State<TimeExtand> {
  OneSignals oneSignals = OneSignals();
  UserController userController = Get.put(UserController());
  late var timeController = TextEditingController();
  late OptionItem optionItemSelectedday1 =
      OptionItem(title: ' 1 أيام', id: "1");
  DropListModel dropListModeldays1 = DropListModel([
    OptionItem(id: "1", title: ' 1 أيام'),
    OptionItem(id: "2", title: ' 2 أيام'),
    OptionItem(id: "3", title: ' 3 أيام'),
    OptionItem(id: "4", title: ' 4 أيام'),
    OptionItem(id: "5", title: ' 5 أيام'),
    OptionItem(id: "7", title: ' 7 أيام'),
    OptionItem(id: "8", title: ' 10 أيام'),
    OptionItem(id: "9", title: ' 14 أيام'),
    OptionItem(id: "10", title: ' 21 أيام'),
    OptionItem(id: "12", title: ' 30 أيام'),
  ]);
  // ignore: unused_local_variable
  String? ayamNumber;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text(
                'تمديد الوقت',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.black),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: BC.appColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              transformAlignment: AlignmentDirectional.centerStart,
              decoration: BoxDecoration(
                  color: BC.appColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: BC.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SelectDropList(
                      height: 40.h,
                      containerDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.transparent),
                          color: Colors.transparent),
                      containerPadding: const EdgeInsets.only(left: 10),
                      containerMargin: EdgeInsets.zero,
                      itemSelected: optionItemSelectedday1,
                      dropListModel: dropListModeldays1,
                      showIcon: false,
                      showArrowIcon: false,
                      showBorder: true,
                      paddingTop: 0,
                      paddingBottom: 0,
                      paddingLeft: 0,
                      paddingRight: 0,
                      borderColor: BC.grey,
                      onOptionSelected: (optionItem) {
                        optionItemSelectedday1 = optionItem;
                        ayamNumber = optionItem.title;
                        timeController.text = optionItem.title;
                        timeController.text = DateTime.now()
                            .add(Duration(days: int.parse(optionItem.id!)))
                            .toString();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () async {
              SmartDialog.showLoading(
                animationBuilder: (controller, child, animationParam) {
                  return Loading(
                    text: 'جاري تمديد التاريخ',
                  );
                },
              );
              await FirebaseFirestore.instance
                  .collection('MishtariProducts')
                  .doc(widget.id)
                  .update({
                'timeExtandRequest': timeController.text,
                'timeExtandRequestAccepted': true
              });
              SmartDialog.dismiss();
              Get.offAll(() => const BottomNavigationExample());
              await oneSignals.sendNotification(widget.user.token!, '',
                  'يرجى تمديد وقت التسليم', 'assets/logo/jpeg',
                  token: widget.user.token!,
                  senderName: userController.currentUser.value.name!,
                  type: 'mishtri');
              await FirebaseFirestore.instance.collection('notification').add({
                'body': 'يرجى تمديد وقت التسليم',
                'senderName': userController.currentUser.value.name!,
                'uid': widget.user.uid!,
                'createdAt': DateTime.now(),
                'time': DateTime.now().toString(),
                'read': false,
                'type': 'mishtri',
              });
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: BC.appColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'تأكيد التمديد',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
