import 'dart:async';

import 'package:hunt_and_rent/screens/dashboard/home/model/category_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';

import '../utils/fb_collection.dart';

class ProductService {

  static Future<Stream<List<ProductModel>>> products() async {
    var ref = FBCollections.products
      //  .orderBy('created_at', descending: true)
        .snapshots()
        .asBroadcastStream();
    var x = ref.map((event) => event.docs
        .map((e) => ProductModel.fromJson(e.data() as Map<String, dynamic>))
        .toList());
    return x;
  }

  static Future<Stream<List<MajorCategory>>> majCat() async {
    var ref = FBCollections.majorCat
    //  .orderBy('created_at', descending: true)
        .snapshots()
        .asBroadcastStream();
    var x = ref.map((event) => event.docs
        .map((e) => MajorCategory.fromJson(e.data() as Map<String, dynamic>))
        .toList());
    return x;
  }

  static Future<Stream<List<CategoriesModel>>> subCat() async {
    var ref = FBCollections.subCat
    //  .orderBy('created_at', descending: true)
        .snapshots()
        .asBroadcastStream();
    var x = ref.map((event) => event.docs
        .map((e) => CategoriesModel.fromJson(e.data() as Map<String, dynamic>))
        .toList());
    return x;
  }


}