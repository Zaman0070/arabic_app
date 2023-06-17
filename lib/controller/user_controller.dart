import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:waist_app/model/user.dart';
import 'package:waist_app/widgets/loading.dart';

class UserController extends GetxController {
  var currentUser = UserModel().obs;
  var specificUser = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    try {
      SmartDialog.showLoading(
        animationBuilder: (controller, child, animationParam) {
          return Loading(
            text: 'تحميل',
          );
        },
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((snapshot) {
        currentUser.value = UserModel.fromMap(snapshot.data()!);
      });
      update();
      SmartDialog.dismiss();
    } catch (e) {
      e.toString();
    }
  }

  Future<void> getSpecificUser(String uid) async {
    try {
      final docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (docSnapshot.exists) {
        specificUser.value = UserModel.fromMap(docSnapshot.data()!);
      }
      update();
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  Future<void> updateUser(UserModel userModel) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(
          text: 'تحميل',
        );
      },
    );
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uid)
          .update(userModel.toMap());
      SmartDialog.dismiss();
      Get.back();
      update();
      fetchCurrentUser();
    } catch (e) {}
  }
}
