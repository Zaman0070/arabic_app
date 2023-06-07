// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SellerModel {
  String? price;
  String? description;
  String? days;
  String? image;
  String? secondPartyMobile;
  bool? agree1;
  bool? agree2;
  int? orderNumber;
  String? uid;
  SellerModel({
    this.price,
    this.description,
    this.days,
    this.image,
    this.secondPartyMobile,
    this.agree1,
    this.agree2,
    this.orderNumber,
    this.uid,
  });

  SellerModel copyWith({
    String? price,
    String? description,
    String? days,
    String? image,
    String? secondPartyMobile,
    bool? agree1,
    bool? agree2,
    int? orderNumber,
    String? uid,
  }) {
    return SellerModel(
      price: price ?? this.price,
      description: description ?? this.description,
      days: days ?? this.days,
      image: image ?? this.image,
      secondPartyMobile: secondPartyMobile ?? this.secondPartyMobile,
      agree1: agree1 ?? this.agree1,
      agree2: agree2 ?? this.agree2,
      orderNumber: orderNumber ?? this.orderNumber,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'description': description,
      'days': days,
      'image': image,
      'secondPartyMobile': secondPartyMobile,
      'agree1': agree1,
      'agree2': agree2,
      'orderNumber': orderNumber,
      'uid': uid,
    };
  }

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
      price: map['price'] != null ? map['price'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      days: map['days'] != null ? map['days'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      secondPartyMobile: map['secondPartyMobile'] != null ? map['secondPartyMobile'] as String : null,
      agree1: map['agree1'] != null ? map['agree1'] as bool : null,
      agree2: map['agree2'] != null ? map['agree2'] as bool : null,
      orderNumber: map['orderNumber'] != null ? map['orderNumber'] as int : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerModel.fromJson(String source) => SellerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SellerModel(price: $price, description: $description, days: $days, image: $image, secondPartyMobile: $secondPartyMobile, agree1: $agree1, agree2: $agree2, orderNumber: $orderNumber, uid: $uid)';
  }

  @override
  bool operator ==(covariant SellerModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.price == price &&
      other.description == description &&
      other.days == days &&
      other.image == image &&
      other.secondPartyMobile == secondPartyMobile &&
      other.agree1 == agree1 &&
      other.agree2 == agree2 &&
      other.orderNumber == orderNumber &&
      other.uid == uid;
  }

  @override
  int get hashCode {
    return price.hashCode ^
      description.hashCode ^
      days.hashCode ^
      image.hashCode ^
      secondPartyMobile.hashCode ^
      agree1.hashCode ^
      agree2.hashCode ^
      orderNumber.hashCode ^
      uid.hashCode;
  }
}
