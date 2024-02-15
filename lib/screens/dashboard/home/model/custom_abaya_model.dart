import 'package:cloud_firestore/cloud_firestore.dart';

class CustomAbayaModel {
  int? docId;
  String? productId;
  String? productName;
  String? productType;
  String? productDescription;
  String? productTailor;
  String? productGender;
  String? userNeck;
  String? userShoulder;
  String? userChest;
  String? userWaist;
  String? userHips;
  String? userArmLength;
  String? userArmWidth;
  String? userId;
  String? vendarId;
  String? userHeight;
  Timestamp? tailorBookingDate;
  String? price;
  String? deliveryAddress;
  String? state;
  String? zipCode;
  String? orderStatus;

  String? customerName;

  // Constructor
  CustomAbayaModel({
    this.docId,
    this.vendarId,
    this.userId,
    this.productId,
    this.productName,
    this.productType,
    this.productDescription,
    this.productTailor,
    this.productGender,
    this.userNeck,
    this.userShoulder,
    this.userChest,
    this.userWaist,
    this.userHips,
    this.userArmLength,
    this.userArmWidth,
    this.userHeight,
    this.tailorBookingDate, this.price, this.deliveryAddress, this.state, this.zipCode,this.orderStatus, this.customerName
  });

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'vendarId': vendarId,
      'userId': userId,
      'productId': productId,
      'productName': productName,
      'productType': productType,
      'productDescription': productDescription,
      'productTailor': productTailor,
      'productGender': productGender,
      'userNeck': userNeck,
      'userShoulder': userShoulder,
      'userChest': userChest,
      'userWaist': userWaist,
      'userHips': userHips,
      'userArmLength': userArmLength,
      'userArmWidth': userArmWidth,
      'userHeight': userHeight,
      'tailorBookingDate': tailorBookingDate,
    'deliveryAddress': deliveryAddress,
    'state': state,
      'price':price,
    'zipCode': zipCode, 'orderStatus':orderStatus
      , 'customerName':customerName
    };
  }

  // Create an instance from a JSON map
  factory CustomAbayaModel.fromJson(Map<String, dynamic> json) {
    return CustomAbayaModel(
      docId: json['docId'],
      vendarId: json['vendarId'],
      userId: json['userId'],
      productId: json['productId'],
      productName: json['productName'],
      productType: json['productType'],
      productDescription: json['productDescription'],
      productTailor: json['productTailor'],
      productGender: json['productGender'],
      userNeck: json['userNeck'],
      userShoulder: json['userShoulder'],
      userChest: json['userChest'],
      userWaist: json['userWaist'],
      userHips: json['userHips'],
      userArmLength: json['userArmLength'],
      userArmWidth: json['userArmWidth'],
      userHeight: json['userHeight'],
      tailorBookingDate: json['tailorBookingDate'],
      deliveryAddress: json['deliveryAddress'],
      state: json['state'],
      price:json['price'],
      zipCode: json['zipCode'],
        orderStatus:json['orderStatus'],
      customerName:json['customerName'],


    );
  }
}
