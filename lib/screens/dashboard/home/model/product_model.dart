import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  List<dynamic>? productImage;
  String? productName;
  String? categoryName;
  String? categoryId;
  String? subCategoryName;
  String? productBrand;
  String? productType;
  String? email;
  String? docId;
  List<dynamic>? productSize;
  List<dynamic>? productColors;
  String? productPrice;
  String? productEndDate;
  String? productDescription;
  String? additionalInstructions;
  Timestamp? startDate;
  Timestamp? endDate;
  String? status;
  String? admin_review;


  ProductModel(
      {this.productImage,
      this.productName,
      this.categoryName,
      this.subCategoryName,
      this.productBrand,
      this.productType,
      this.productSize,
      this.productColors,
      this.productPrice,
      this.productEndDate,
      this.productDescription,
      this.additionalInstructions,
      this.categoryId,
      this.docId,
      this.email,
      this.startDate,
      this.endDate,
      this.status,
        this.admin_review
      });


  ProductModel.fromJson(Map<String, dynamic> json) {
    productImage = json['product_image'];
    productName = json['product_name'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
    productBrand = json['product_brand'];
    productType = json['product_type'];
    productSize = json['product_size'];
    productColors = json['product_colors'];
    productPrice = json['product_price'];
    productEndDate = json['product_end_date'];
    productDescription = json['product_description'];
    additionalInstructions = json['additional_instructions'];
    categoryId = json['category_id'];
    docId = json['doc_id'].toString();
    email = json['email'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    admin_review = json['admin_review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_image'] = productImage;
    data['product_name'] = productName;
    data['category_name'] = categoryName;
    data['sub_category_name'] = subCategoryName;
    data['product_brand'] = productBrand;
    data['product_type'] = productType;
    data['product_size'] = productSize;
    data['product_colors'] = productColors;
    data['product_price'] = productPrice;
    data['product_end_date'] = productEndDate;
    data['product_description'] = productDescription;
    data['additional_instructions'] = additionalInstructions;
    data['category_id'] = categoryId;
    data['doc_id'] = docId;
    data['email'] = email;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    data['admin_review'] = admin_review;
    return data;
  }

}
