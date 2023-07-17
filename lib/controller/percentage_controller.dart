import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:waist_app/model/percentage.dart';
import 'package:waist_app/widgets/loading.dart';

class PercentageController extends GetxController {
  var percentage = PercentageModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchPercentage();
  }

  Future<void> fetchPercentage() async {
    try {
      SmartDialog.showLoading(
        animationBuilder: (controller, child, animationParam) {
          return Loading(
            text: 'تحميل',
          );
        },
      );
      await FirebaseFirestore.instance
          .collection('percentage')
          .doc('percentage')
          .get()
          .then((snapshot) {
        percentage.value = PercentageModel.fromMap(snapshot.data()!);
      });
      update();
      SmartDialog.dismiss();
    } catch (e) {
      e.toString();
    }
  }



}
