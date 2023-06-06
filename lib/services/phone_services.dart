import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/route_manager.dart';
import 'package:waist_app/services/firebase_services.dart';
import 'package:waist_app/screens/bottom_nav/bottomNavi.dart';

import '../screens/auth/confirmPhone.dart';

class PhoneService {
  FirebaseServices service = FirebaseServices();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  addUser(context, uid) async {
    final QuerySnapshot result = await users.where('uid', isEqualTo: uid).get();

    List<DocumentSnapshot> document = result.docs;

    if (document.isNotEmpty) {
      Get.offAll(() => BottomNavigationExample());
    } else {
      return service.users.doc(user!.uid).set({
        'uid': user!.uid,
        'mobile': user!.phoneNumber,
        'email': '',
        'image': '',
        'city': '',
        'name': ''
      }).then((value) {
        Get.offAll(() => BottomNavigationExample());
        // ignore: avoid_print, invalid_return_type_for_catch_error
      }).catchError((error) => print('failed to add user : $error'));
    }
  }

  verificationPhoneNumber(BuildContext context, number) async {
    SmartDialog.showLoading();
    verificationCompleted(PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    }

    verificationFailed(FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {}
    }

    Future<void> codeSent(String verId, int? resendToken) async {
      SmartDialog.dismiss();
      await Get.to(() => OTP(
            number: number,
            verId: verId,
          ));
    
    }

    try {
      auth.verifyPhoneNumber(
          phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {}
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
