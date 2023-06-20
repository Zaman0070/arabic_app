import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/model/seller.dart';
import 'package:waist_app/model/service_provider.dart';
import 'package:waist_app/model/services_beneficary.dart';
import 'package:waist_app/screens/auth/login.dart';
import 'package:waist_app/screens/privacy_policy/privacy_policy.dart';
import 'package:waist_app/widgets/loading.dart';

class FirebaseServices {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference mishtriProduct =
      FirebaseFirestore.instance.collection('MishtariProducts');
  CollectionReference serviceBeneficary =
      FirebaseFirestore.instance.collection('ServiceBeneficaryProducts');
  CollectionReference sellerProduct =
      FirebaseFirestore.instance.collection('SellerProduct');
  CollectionReference serviceProvider =
      FirebaseFirestore.instance.collection('ServiceProvider');

  Future<void> addMishtriDetails({
    required String name,
    required String phoneNumber,
    required String address,
    required String purpose,
    required String price,
    required String description,
    required String days,
    required String secondPartyMobile,
    required String images,
    required bool agree1,
    required bool agree2,
    required String isAccepted,
    required String ayam,
    required String ayamNumber,
    required List<dynamic> uid,
  }) async {
    var random = Random();
    int randomNumber = random.nextInt(100000000);

    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(
          text: 'بأنتظار تأكيد الطلب من قبل البائع',
        );
      },
    );
    try {
      BuyerModel buyerModel = BuyerModel(
        name: name,
        phoneNumber: phoneNumber,
        address: address,
        purpose: purpose,
        price: price,
        description: description,
        days: days,
        secondPartyMobile: secondPartyMobile,
        images: images,
        agree1: agree1,
        agree2: agree2,
        orderNumber: randomNumber,
        isAccepted: isAccepted,
        ayam: ayam,
        ayamNumber: ayamNumber,
        uid: uid,
      );
      await mishtriProduct.doc().set(buyerModel.toMap()).then((value) {
        Fluttertoast.showToast(
            textColor: Colors.white,
            msg: 'تم إرسال الطلب بنجاح',
            backgroundColor: BC.appColor);
        SmartDialog.dismiss();
        Get.back();
        // routes
      });
    } catch (e) {
      SmartDialog.dismiss();
      Fluttertoast.showToast(
          textColor: Colors.white,
          msg: 'Something went wrong !',
          backgroundColor: BC.appColor);
    }
  }

  Future<void> addServiceBeneficary({
    required String name,
    required String phoneNumber,
    required String address,
    required String purpose,
    required String price,
    required String description,
    required String days,
    required String secondPartyMobile,
    required bool agree1,
    required bool agree2,
  }) async {
    var random = Random();
    int randomNumber = random.nextInt(100000000);
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(
          text: 'بأنتظار تأكيد الطلب من قبل البائع',
        );
      },
    );
    try {
      ServiceBeneficaryModel buyerModel = ServiceBeneficaryModel(
        name: name,
        phoneNumber: phoneNumber,
        address: address,
        purpose: purpose,
        price: price,
        description: description,
        days: days,
        secondPartyMobile: secondPartyMobile,
        agree1: agree1,
        agree2: agree2,
        orderNumber: randomNumber,
        uid: FirebaseAuth.instance.currentUser!.uid,
      );
      await serviceBeneficary.doc().set(buyerModel.toMap()).then((value) {
        Fluttertoast.showToast(
            textColor: Colors.white,
            msg: 'تم إرسال الطلب بنجاح',
            backgroundColor: BC.appColor);
        SmartDialog.dismiss();
        Get.to(() => const PrivacyPolicy());

        // routes
      });
    } catch (e) {
      SmartDialog.dismiss();
      Fluttertoast.showToast(
          textColor: Colors.white,
          msg: 'Something went wrong !',
          backgroundColor: BC.appColor);
    }
  }

  Future<void> addSellerData({
    required String price,
    required String description,
    required String days,
    required String secondPartyMobile,
    required bool agree1,
    required bool agree2,
    required String images,
  }) async {
    var random = Random();
    int randomNumber = random.nextInt(100000000);
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(
          text: 'بأنتظار تأكيد الطلب من قبل المشتري',
        );
      },
    );
    try {
      SellerModel buyerModel = SellerModel(
        price: price,
        description: description,
        days: days,
        secondPartyMobile: secondPartyMobile,
        agree1: agree1,
        agree2: agree2,
        orderNumber: randomNumber,
        uid: FirebaseAuth.instance.currentUser!.uid,
        image: images,
      );
      await sellerProduct.doc().set(buyerModel.toMap()).then((value) {
        Fluttertoast.showToast(
            textColor: Colors.white,
            msg: 'تم إرسال الطلب بنجاح',
            backgroundColor: BC.appColor);
        SmartDialog.dismiss();
        Get.back();
        // routes
      });
    } catch (e) {
      SmartDialog.dismiss();
      Fluttertoast.showToast(
          textColor: Colors.white,
          msg: 'Something went wrong !',
          backgroundColor: BC.appColor);
    }
  }

  Future<void> addServiceProvider({
    required String price,
    required String description,
    required String days,
    required String secondPartyMobile,
    required bool agree1,
    required bool agree2,
  }) async {
    var random = Random();
    int randomNumber = random.nextInt(100000000);
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(
          text: 'بأنتظار تأكيد الطلب من قبل الممستفيد من الخدمة',
        );
      },
    );
    try {
      ServiceProviderModel serviceProviderModel = ServiceProviderModel(
        price: price,
        description: description,
        days: days,
        secondPartyMobile: secondPartyMobile,
        agree1: agree1,
        agree2: agree2,
        orderNumber: randomNumber,
        uid: FirebaseAuth.instance.currentUser!.uid,
      );
      await serviceProvider
          .doc()
          .set(serviceProviderModel.toMap())
          .then((value) {
        Fluttertoast.showToast(
            textColor: Colors.white,
            msg: 'تم إرسال الطلب بنجاح',
            backgroundColor: BC.appColor);
        SmartDialog.dismiss();
        Get.back();
        // routes
      });
    } catch (e) {
      SmartDialog.dismiss();
      Fluttertoast.showToast(
          textColor: Colors.white,
          msg: 'Something went wrong !',
          backgroundColor: BC.appColor);
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => Login());
    } catch (e) {
      Fluttertoast.showToast(
          textColor: Colors.white,
          msg: 'Something went wrong !',
          backgroundColor: BC.appColor);
    }
  }
}
