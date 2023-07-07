// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class BuyerModel {
  String? name;
  String? phoneNumber;
  String? address;
  String? purpose;
  String? price;
  String? description;
  String? days;
  String? secondPartyMobile;
  String? images;
  bool? agree1;
  bool? agree2;
  int? orderNumber;
  String? isAccepted;
  List<dynamic>? uid;
  String? ayam;
  String? ayamNumber;
  String? formType;
  String? formfillby;
  String? review;
  BuyerModel({
    this.name,
    this.phoneNumber,
    this.address,
    this.purpose,
    this.price,
    this.description,
    this.days,
    this.secondPartyMobile,
    this.images,
    this.agree1,
    this.agree2,
    this.orderNumber,
    this.isAccepted,
    this.uid,
    this.ayam,
    this.ayamNumber,
    this.formType,
    this.formfillby,
    this.review,
  });

  BuyerModel copyWith({
    String? name,
    String? phoneNumber,
    String? address,
    String? purpose,
    String? price,
    String? description,
    String? days,
    String? secondPartyMobile,
    String? images,
    bool? agree1,
    bool? agree2,
    int? orderNumber,
    String? isAccepted,
    List<dynamic>? uid,
    String? ayam,
    String? ayamNumber,
    String? formType,
    String? formfillby,
    String? review,
  }) {
    return BuyerModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      purpose: purpose ?? this.purpose,
      price: price ?? this.price,
      description: description ?? this.description,
      days: days ?? this.days,
      secondPartyMobile: secondPartyMobile ?? this.secondPartyMobile,
      images: images ?? this.images,
      agree1: agree1 ?? this.agree1,
      agree2: agree2 ?? this.agree2,
      orderNumber: orderNumber ?? this.orderNumber,
      isAccepted: isAccepted ?? this.isAccepted,
      uid: uid ?? this.uid,
      ayam: ayam ?? this.ayam,
      ayamNumber: ayamNumber ?? this.ayamNumber,
      formType: formType ?? this.formType,
      formfillby: formfillby ?? this.formfillby,
      review: review ?? this.review,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'purpose': purpose,
      'price': price,
      'description': description,
      'days': days,
      'secondPartyMobile': secondPartyMobile,
      'images': images,
      'agree1': agree1,
      'agree2': agree2,
      'orderNumber': orderNumber,
      'isAccepted': isAccepted,
      'uid': uid,
      'ayam': ayam,
      'ayamNumber': ayamNumber,
      'formType': formType,
      'formfillby': formfillby,
      'review': review,
    };
  }

  factory BuyerModel.fromMap(Map<String, dynamic> map) {
    return BuyerModel(
      name: map['name'] != null ? map['name'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      purpose: map['purpose'] != null ? map['purpose'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      days: map['days'] != null ? map['days'] as String : null,
      secondPartyMobile: map['secondPartyMobile'] != null
          ? map['secondPartyMobile'] as String
          : null,
      images: map['images'] != null ? map['images'] as String : null,
      agree1: map['agree1'] != null ? map['agree1'] as bool : null,
      agree2: map['agree2'] != null ? map['agree2'] as bool : null,
      orderNumber:
          map['orderNumber'] != null ? map['orderNumber'] as int : null,
      isAccepted:
          map['isAccepted'] != null ? map['isAccepted'] as String : null,
      uid: map['uid'] != null
          ? List<dynamic>.from((map['uid'] as List<dynamic>))
          : null,
      ayam: map['ayam'] != null ? map['ayam'] as String : null,
      ayamNumber:
          map['ayamNumber'] != null ? map['ayamNumber'] as String : null,
      formType: map['formType'] != null ? map['formType'] as String : null,
      formfillby:
          map['formfillby'] != null ? map['formfillby'] as String : null,
      review: map['review'] != null ? map['review'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BuyerModel.fromJson(String source) =>
      BuyerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BuyerModel(name: $name,formType :$formType, phoneNumber: $phoneNumber, address: $address, purpose: $purpose, price: $price, description: $description, days: $days, secondPartyMobile: $secondPartyMobile, images: $images, agree1: $agree1, agree2: $agree2, orderNumber: $orderNumber, isAccepted: $isAccepted, uid: $uid, ayam: $ayam, ayamNumber: $ayamNumber, formfillby: $formfillby, review: $review)';
  }

  @override
  bool operator ==(covariant BuyerModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.address == address &&
        other.purpose == purpose &&
        other.price == price &&
        other.description == description &&
        other.days == days &&
        other.secondPartyMobile == secondPartyMobile &&
        other.images == images &&
        other.agree1 == agree1 &&
        other.agree2 == agree2 &&
        other.orderNumber == orderNumber &&
        other.isAccepted == isAccepted &&
        listEquals(other.uid, uid) &&
        other.ayam == ayam &&
        other.ayamNumber == ayamNumber &&
        other.formType == formType &&
        other.formfillby == formfillby&&
        other.review == review;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phoneNumber.hashCode ^
        address.hashCode ^
        purpose.hashCode ^
        price.hashCode ^
        description.hashCode ^
        days.hashCode ^
        secondPartyMobile.hashCode ^
        images.hashCode ^
        agree1.hashCode ^
        agree2.hashCode ^
        orderNumber.hashCode ^
        isAccepted.hashCode ^
        uid.hashCode ^
        ayam.hashCode ^
        ayamNumber.hashCode ^
        formType.hashCode ^
        formfillby.hashCode^
        review.hashCode;
  }
}
