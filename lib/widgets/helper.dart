import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/resources.dart';

class Helper {
  /*
  * description: Show a message
  * input: a message string
  * output: a scaffold snackBar
  */
  // static void toast(String msg) {
  //   Fluttertoast.showToast(
  //       msg: msg,
  //       fontSize: 14,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER);
  // }

  static void inSnackBar(String title, String message) {
    Get.snackbar(title, message,
        icon: const Icon(Icons.info_rounded),
        backgroundColor: R.colors.theme,
        colorText: Colors.white);
  }

  /*
  * description: Change colors to material colors
  * input: Color
  * Output: material color
  */
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  static bool isKeyboardOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0.0;
  }
}
