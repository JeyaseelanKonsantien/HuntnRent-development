import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class FBCollections {
  static CollectionReference users = db.collection('users');
  static CollectionReference products = db.collection('products');
  static CollectionReference subCat = db.collection('categories');
  static CollectionReference majorCat = db.collection('Category');



  
}