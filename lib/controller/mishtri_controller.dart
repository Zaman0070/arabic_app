import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/widgets/loading.dart';

class MishtariController extends GetxController {
  var allMishtari = <BuyerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMishtari();
  }

  Future<void> fetchMishtari() async {
    try {
      SmartDialog.showLoading(
        animationBuilder: (controller, child, animationParam) {
          return Loading(
            text: ' ... تحميل ',
          );
        },
      );
      await FirebaseFirestore.instance
          .collection('MishtariProducts')
          .get()
          .then((querySnapshot) {
        allMishtari.value = querySnapshot.docs
            .map((doc) => BuyerModel.fromMap(doc.data()))
            .toList();
      });
      update();
      SmartDialog.dismiss();
    } catch (e) {
      print(e);
    }
  }
}
