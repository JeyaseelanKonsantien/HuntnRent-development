import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/show_message.dart';

abstract class BaseAuth {
  Future<void> signOutQuery();
  Future<void> sendResetPassEmail(String email);
  Future<User?> CurrentUserQuery();
  Future<String> signInQuery(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      var user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      await user?.sendEmailVerification();
      return user!.uid;
    } catch (e) {
      if (kDebugMode) {
        print("Creating user Error \n\n\n $e");
      }
      if (e.toString().contains("email-already-in-use")) {
        ShowMessage.inSnackBar("Error", e.toString());
        return "0";
      } else {
        ShowMessage.inSnackBar("Error", e.toString());
        return "1";
      }
    }
  }

  @override
  Future<String> signInQuery(String email, String password) async {
    try {
      var user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user!.emailVerified) {
        return user!.uid;
      } else {
        return "1";
      }
    } catch (e) {
      String error = e.toString();
      print("sign in error $e");
      if (error.contains("wrong-password")) {
        Get.snackbar("Wrong Password or Email", "ENTER CORRECT PASSWORD",
            colorText: Colors.white,
            backgroundColor: Colors.redAccent[700],
            margin: EdgeInsets.symmetric(
                vertical: Get.height * 0.02, horizontal: Get.width * 0.03));
      } else if (error.contains("user-not-found")) {
        Get.snackbar(
            "Wrong Email",
            "No User found against this email.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            margin: EdgeInsets.symmetric(
              vertical: Get.height * 0.02,
              horizontal: Get.width * 0.03,
            ));
      }
      return "0";
    }
  }

  @override
  Future<User?> CurrentUserQuery() async {
    var user = _firebaseAuth.currentUser;
    return user;
  }

  @override
  Future<void> signOutQuery() async {
    var user = _firebaseAuth.signOut();
    return user;
  }

  @override
  Future<void> sendResetPassEmail(String email) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: '$email').then((value) {
      print("success");
      ShowMessage.inSnackBar('success',
          "Password reset link sent Successfully,\n Please check your mail box");
    }).catchError((e) {
      String error = e.toString();
      print(error);

      if (error.contains('USER_NOT_FOUND')) {
        ShowMessage.toast('Email not registered');
      } else {
        print(e.toString());
        ShowMessage.toast(e.toString());
      }
    });
  }
}
