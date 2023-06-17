import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/widgets/loading.dart';

class MishtariController extends GetxController {
  var allMishtari = <BuyerModel>[].obs;
  var mishtariListbyPhone = <BuyerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMishtari();
    fetchMishtariByPhone();
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

  Future<void> fetchMishtariByPhone() async {
    UserController userController = Get.put(UserController());
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
          .where('secondPartyMobile',
              isEqualTo: userController.currentUser.value.phoneNumber)
          .get()
          .then((querySnapshot) {
        mishtariListbyPhone.value = querySnapshot.docs
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
