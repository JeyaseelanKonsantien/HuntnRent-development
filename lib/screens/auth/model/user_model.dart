
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String? userName;
  String? fullName;
  String? qid;
  String? email;
  String? phoneNumber;
  bool? isRenter = false;
  String? userImage;
  String? accountNumber;
  String? iban;
  String? swiftCode;
  String? bankAddress;
  String? address;
  String? ibanImage;
  List<dynamic>? favrt = [];
  List<UserCart>? cart = [];

  UsersModel(
      {this.fullName,
      this.qid,
      this.email,
      this.phoneNumber,
      required this.favrt,
      this.isRenter,
      required this.cart,
      this.userImage,
      this.userName,
        this.accountNumber,
        this.iban,
        this.swiftCode,
        this.bankAddress,
        this.address,
        this.ibanImage,

      });

  UsersModel.fromJson(dynamic json) {
    fullName = json['fullName'];
    qid = json['qid'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    favrt = json['favrt'];
    isRenter = json['isRenter'];
    userImage = json['userImage'];
    userName = json['userName'];
    accountNumber = json['accountNumber'];
    iban = json['iban'];
    swiftCode = json['swiftCode'];
    bankAddress = json['bankAddress'];
    address = json['address'];
    ibanImage= json['ibanImage'];

    if (json['cart'] != null) {
      cart = [];
      json['cart'].forEach((v) {
        cart?.add(UserCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    map['qid'] = qid;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['favrt'] = favrt;
    map['isRenter'] = isRenter;
    map['userImage'] = userImage;
    map['userName'] = userName;
    map['accountNumber'] = accountNumber;
    map['iban'] = iban;
    map['swiftCode'] = swiftCode;
    map['bankAddress'] = bankAddress;
    map['address'] = address;
    map['ibanImage']= ibanImage;
    if (cart != null) {
      map['cart'] = cart?.map((v) => v.toJson()).toList();
    }

    return map;
  }
}

class UserCart{
  String? productId;
  Timestamp? startDate;
  Timestamp? endDate;

  UserCart({
    this.productId,
    this.startDate,
    this.endDate,
  });

  UserCart.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}