import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:hunt_and_rent/screens/auth/login_signup.dart';
import 'package:hunt_and_rent/screens/dashboard/dashboard_view.dart';
import 'package:image_picker/image_picker.dart';

import '../../../dialog/congrats_dialog.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/fb_collection.dart';
import '../../../utils/show_message.dart';
import '../../dashboard/home/model/product_model.dart';
import '../login_page/login_view.dart';
import '../model/user_model.dart';

class AuthProvider extends ChangeNotifier {
  update() {
    notifyListeners();
  }

  bool isLoading = false;

  startLoader() {
    isLoading = true;
    notifyListeners();
  }

  stopLoader() {
    isLoading = false;
    notifyListeners();
  }

  DateTime datesTimes = DateTime.now();
  DateTime datesTimes1 = DateTime.now();

  bool isPassVisible = true;

  changePassVisible() {
    isPassVisible = !isPassVisible;
    notifyListeners();
  }

  UsersModel userModel = UsersModel(cart: [], favrt: []);
  BaseAuth? baseAuth = Auth();

  /// Home Page Indexes ///
  int selectedCategory = 0;
  int selectedBrand = -1;

  /// Product Details Page ///
  int selectedColor = 0;
  int selectedSize = 0;
  int selectedDays = 0;

  /// Category Page ///
  bool isClicked = false;
  int currentDrawerSelected = 0;
  int selectedCate = 0;
  int selectedBrandCate = 0;
  String selectedCategoryName = "";

  List<String> drawerTexts = [
    "Just for You",
    "New Arrival",
    "Dresses",
    "Tops",
    "Pants",
    "Skirts",
    "Suits",
    "Bags",
    "Jewelery",
  ];

  DateTime? startDate;
  DateTime? endDate;
  List<String> cartDocList = [];

  /// Special Tailory Page ///
  int selectedGender = 0;

  getAllProductDoc() async {
    cartDocList.clear();
    for (var i = 0; i < userModel.cart!.length; i++) {
      cartDocList.add(userModel.cart![i].productId!);
      print("cartDocList $cartDocList");
    }
  }

  /// Signin Method ///
  Future signInMethod(String email, String password) async {
    startLoader();
    baseAuth?.signInQuery(email, password).then((Value) async {
      log("sign in response....$Value");
      if (Value.toString() == "0") {
        stopLoader();
      } else if (Value.toString() == "1") {
        ShowMessage.inSnackBar(
          "Verification Error",
          "please verify your email through link",
        );
        stopLoader();
      } else {
        await CheckSigninMethod(email: email);
      }
    });
  }

  /// Get Current User ///
  Future<void> getCurrentUser() async {
    var user = await baseAuth?.CurrentUserQuery();
    if (user != null) {
      var userData = await getUserFromDB(user.email!);
      if (userData != null) {
        CheckSigninMethod(email: user.email, isSplash: true);
      } else {
        await baseAuth!.signOutQuery();
        await Get.offAll(LoginView());
      }
    } else {
      await baseAuth!.signOutQuery();
      await Get.toNamed(Routes.landingScreens);
    }
  }

  /// UpdateUser Method ///
  Future updateUser(UsersModel userModel1) async {
    print("Enter in Update User!");
    startLoader();
    await FBCollections.users
        .doc(userModel1.email)
        .update(userModel1.toJson())
        .then((value) async {
      userModel = (await getUserFromDB(userModel.email!))!;
      update();
      stopLoader();
    });
  }

  Future<void> CheckSigninMethod({String? email, bool isSplash = false}) async {
    startLoader();
    userModel = (await getUserFromDB(email!))!;
    await updateFcm(email);
    log("user found = ${userModel?.toJson()}");
    Get.offAllNamed(Routes.dashboardView);

    // if (_userModel?.status == UserStatus.active.index) {
    //   stopLoader();
    //
    // } else {
    //   if (isSplash) {
    //     stopLoader();
    //     Get.offAll(const LoginPage());
    //   }
    //   ShowMessage.inSnackBar("Blocked", "User is blocked and cannot sign in");
    // }
  }

  Future<void> updateFcm(String docID) async {
    var fcm = await FBCollections.users
        .doc(docID)
        .update({"fcm_id": AppUtils.myFcmToken});

    return fcm;
  }

  /// RegisterUser ///
  Future<void> registerUser(UsersModel userModel, String password) async {
    startLoader();
    DocumentSnapshot userDocument =
        await FBCollections.users.doc(userModel.email).get();

    if (userDocument.exists) {
      stopLoader();
      log("user exist");
      ShowMessage.inSnackBar("Error", "User already exists");
    } else {
      log("user does not exist");
      log("email:${userModel.email!} password $password ");
      baseAuth
          ?.createUserWithEmailAndPassword(userModel.email!, password)
          .then((value) async {
        log("create user returned value $value");

        if (value != "0" && value != "1") {
          await FBCollections.users
              .doc(userModel.email)
              .set(userModel.toJson())
              .then((value) async {
            userModel = (await getUserFromDB(userModel.email!))!;
            // stopLoader();
            Timer(const Duration(seconds: 2), () {
              Get.dialog(CongratsDialog(
                onTap: () {
                  Get.offAll(LoginSignup());
                },
                text:
                    "You Have Successfully Signed up!\nPlease Verify Your Email!",
              ));
            });
          });
        } else {
          stopLoader();
        }
      });
    }
  }

  Future<UsersModel?> getUserFromDB(String docId) async {
    startLoader();
    DocumentSnapshot doc = await FBCollections.users.doc(docId).get();
    stopLoader();
    if (!doc.exists) {
      return null;
    }
    UsersModel user = UsersModel.fromJson(doc.data() as Map<String, dynamic>);
    return user;
  }

  void changePassword(
      {required String newPassword, required String oldPassword}) async {
    startLoader();
    try {
      startLoader();
      User? user = FirebaseAuth.instance.currentUser;
      var authResult = await user!
          .reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        ),
      )
          .catchError((error) {
        stopLoader();
        var er = error.toString();
        print("error:$er");
        if (er.contains("wrong-password")) {
          ShowMessage.toast("Wrong old Password");
        } else {
          ShowMessage.toast(er);
        }
      });
      authResult.user!.updatePassword(newPassword).then((value) {
        stopLoader();
        Get.dialog(CongratsDialog(
          onTap: () {
            Get.offAll(LoginView());
          },
          // image: R.images.logo,
          text: "Your Password is Updated\nPlease Login Again",
        ));
      });
    } catch (e) {
      stopLoader();
      ShowMessage.toast(e.toString());
      print(e.toString());
    }
  }

  Future<void> signOutQuery() async {
    await baseAuth?.signOutQuery();
    Get.offAllNamed(Routes.LoginSignup);
  }

  Future<void> sendResetPassEmail(String email) async {
    startLoader();
    FirebaseAuth.instance.sendPasswordResetEmail(email: '$email').then((value) {
      startLoader();
      // Get.to(confirmSendEmail());
      Get.dialog(CongratsDialog(
        onTap: () {
          Get.offAll(LoginView());
        },
        text:
            "The Password Reset Has Been Sent on Your Provided Email\nPlease Check Your Email!",
      ));
      stopLoader();
    }).catchError((e) {
      String error = e.toString();
      print(error);

      if (error.contains('user-not-found')) {
        ShowMessage.toast('Email not registered');
      } else {
        print(e.toString());

        isLoading = false;
        // ShowMessage.toast(e.toString());
      }
      stopLoader();
    });
  }

  File? pickedImage;

  var height, width;
  final picker = ImagePicker();

  Future getImage1() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
    } else {
      // ShowMessage.toast("Nothing selected");
    }
    notifyListeners();
  }

  File? pickedIbanImage;
  final ibanImagePicker = ImagePicker();

  Future getIbanImage() async {
    final pickedIbanFile = await ibanImagePicker.pickImage(source: ImageSource.gallery);

    if (pickedIbanFile != null) {
      pickedIbanImage = File(pickedIbanFile.path);
    } else {
      // ShowMessage.toast("Nothing selected");
    }
    notifyListeners();
  }




  File? productImages;
  List<XFile> listOfImages = [];
  List<XFile> pickedImages1 = [];
  final productList = ImagePicker();

  Future getListImages() async {
    listOfImages.clear();
    startLoader();
    update();
    List<XFile> pickedImages1 = await productList.pickMultiImage();

    listOfImages = pickedImages1;
    stopLoader();
    update();

    print("${listOfImages.first.name}");

    // if (pickedImages1!.length < 3 || pickedImages1!.length > 5) {
    //   return Get.snackbar(" ", "Selected Images Should Be 3 to 5");
    // }
    // productImages!.forEach();
    // for (int i = 0; i <= pickedImages1.length; i++) {
    //   listOfImages.add(pickedImages1[i]);
    //   print("${listOfImages[i].name}");
    //   update();
    // }
    // listOfImages = File(pickedImages.path);
  }

  Future<List<String>?> uploadMultiFiles(
      {String bucketName = 'bucket',
      String? userEmail,
      List<XFile>? images}) async {
    List<String> docsURL = [];
    for (int i = 0; i <= images!.length; i++) {
      String url = await uploadSingleFile(
          bucketName: bucketName,
          userEmail: userEmail,
          file: File(images[i].path));
      docsURL.add(url);
      if (i == images.length - 1) {
        return docsURL;
      }
    }
    return null;
  }

  Future<String> uploadSingleFile(
      {String bucketName = 'bucket', File? file, String? userEmail}) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref()
        .child("$bucketName/$userEmail/${DateTime.now().toString()}");
    UploadTask uploadTask = ref.putFile(file!);
    TaskSnapshot res = await uploadTask;
    String imageUrl = await res.ref.getDownloadURL();
    log("uploaded = $imageUrl");
    return imageUrl;
  }

  List<int> favrtProducts = [];

  Future saveProduct({ProductModel? productModel}) async {
    var timestamp =(DateTime.now().toUtc().millisecondsSinceEpoch);

    isLoading = true;
    update();
    await FirebaseFirestore.instance
        .collection("products")
        .doc('$timestamp')
        .set(productModel!.toJson())
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("products")
          .doc('$timestamp')
          .update({"doc_id": timestamp});
      isLoading = false;
      update();
      Get.snackbar("Success", "Listing sent for review Successfully!");
      Get.offAll(DashboardView(
        index: 1,
      ));
    });
  }



  Future updateProduct({ProductModel? productModel, String? productId}) async {

    isLoading = true;
    update();
    await FirebaseFirestore.instance
        .collection("products")
        .doc('$productId')
        .set(productModel!.toJson())
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("products")
          .doc('$productId')
          .update({"doc_id": productId});
      isLoading = false;
      update();
      Get.snackbar("Success", "Listing sent for review Successfully!");
      Get.offAll(DashboardView(
        index: 1,
      ));
    });
  }


}
