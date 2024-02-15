class CategoriesModel{
  String? categoryName;
  String? categoryImage;
  String? categoryId;
  String? docId;

  CategoriesModel({this.categoryImage, this.categoryId, this.categoryName,this.docId});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    categoryId = json['category_id'];
    docId = json['doc_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_name'] = categoryName;
    data['category_image'] = categoryImage;
    data['category_id'] = categoryId;
    data['doc_id'] = docId;
    return data;
  }

}

class MajorCategory{
  String? catName;
  String? docId;

  MajorCategory({this.catName,this.docId});

  MajorCategory.fromJson(Map<String, dynamic> json) {
    catName = json['cat_name'];
    docId = json['doc_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_name'] = catName;
    data['doc_id'] = docId;
    return data;
  }
}

enum ProductsTypes { custom, sold, rent, rented, }

enum OrderStatus{Active,Inactive,Completed,Cancelled,Expired,}

enum SubmitStatus{Yes,No,Done}
