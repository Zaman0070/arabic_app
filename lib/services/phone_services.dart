import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/route_manager.dart';
import 'package:waist_app/Services/firebase_services.dart';
import 'package:waist_app/widgets/loading.dart';

import '../screens/auth/confirmPhone.dart';

class PhoneService {
  FirebaseServices service = FirebaseServices();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  verificationPhoneNumber(BuildContext context, number) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(
          text: 'تم تأكيد الدخول مرحباً بك في تطبيق وسيط',
        );
      },
    );

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
