// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? name;
  String? email;
  String? phoneNumber;
  String? location;
  String? profileImage;
  String? uid;
  String? token;
  int? walletBalance;
  UserModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.location,
    this.profileImage,
    this.uid,
    this.token,
    this.walletBalance,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? location,
    String? profileImage,
    String? uid,
    String? token,
    int? walletBalance,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      profileImage: profileImage ?? this.profileImage,
      uid: uid ?? this.uid,
      token: token ?? this.token,
      walletBalance: walletBalance ?? this.walletBalance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'location': location,
      'profileImage': profileImage,
      'uid': uid,
      'token': token,
      'walletBalance': walletBalance,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      walletBalance:
          map['walletBalance'] != null ? map['walletBalance'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, phoneNumber: $phoneNumber, location: $location, profileImage: $profileImage, uid: $uid, token: $token, walletBalance: $walletBalance)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.location == location &&
        other.profileImage == profileImage &&
        other.uid == uid &&
        other.token == token &&
        other.walletBalance == walletBalance;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        location.hashCode ^
        profileImage.hashCode ^
        uid.hashCode ^
        token.hashCode ^
        walletBalance.hashCode;
  }
}
