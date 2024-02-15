import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? categoryImage;
  String? categoryName;
  Timestamp? createdAt;
  String? categoryID;
  int? status;

  CategoryModel({
    this.categoryName,
    this.categoryImage,
    this.categoryID,
    this.createdAt,
    this.status,
  });

  CategoryModel.fromJason(dynamic json) {
    categoryName = json["categoryName"];
    categoryImage = json["categoryImage"];
    categoryID = json["categoryID"];
    createdAt = json["createdAt"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryName'] = categoryName;
    map['categoryImage'] = categoryImage;
    map['categoryID'] = categoryID;
    map['createdAt'] = createdAt;
    map['status'] = status;
    return map;
  }
}
