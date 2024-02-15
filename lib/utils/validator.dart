
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../screens/auth/provider/auth_provider.dart';

class FieldValidator {
  AuthProvider auth = Provider.of<AuthProvider>(Get.context!, listen: false);
  static String? validateEmail(String value) {
    value = value.toLowerCase();
    if (value.isEmpty) {
      return "Email is required";
    }
    if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
            r"*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value.trim())) {
      return "Please enter a valid email address";
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) return 'Please enter password';
    if (value.length < 6) {
      return "Enter a combination of at least 6 numbers, \nalphabets & special characters";
    }
    if (!RegExp(r"^(?=.*?[0-9])").hasMatch(value)) {
      return 'Enter a combination of at least 6 numbers, \nalphabets & special characters';
    }
    if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value.trim())) {
      return 'Enter a combination of at least 6 numbers, \nalphabets & special characters';
    }
    return null;
  }

  static String? validatePasswordMatch(String value, String pass2) {
    if (value.isEmpty) return "Confirm password is required";
    if (value != pass2) {
      return "Password doesn't match";
    }
    return null;
  }

  static String? validateFirstName(String value) {
    if (value.isEmpty) return "First name is required";
    if (value.length <= 2) {
      return "First name is too short";
    }

    return null;
  }

  static String? validateDateOfBirth(String? value) {
    if (value!.isEmpty) {
      return "DOB is Required";
    }
    return null;
  }
  static String? validateEmptyField(String? value) {
    if (value!.isEmpty) {
      return "This Field is Required";
    }
    return null;
  }

  static String? validateStartDate(String? value) {
    if (value!.isEmpty) {
      return "Please Select Start Date";
    }
    return null;
  }
  static String? validateStartTime(String? value) {
    if (value!.isEmpty) {
      return "Please ";
    }
    return null;
  }
  static String? validateEndTime(String? value) {
    if (value!.isEmpty) {
      return "Please Select Start Time";
    }
    return null;
  }
  static String? validateAmount(String? value) {
    if (value!.isEmpty) {
      return "Amount is Required";
    }
    return null;
  }
  static String? validateEndDate(String? value) {
    if (value!.isEmpty) {
      return "Please Select Start Time";
    }
    return null;
  }
  static String? validateDescription(String? value) {
    if (value!.isEmpty) {
      return "Please Select Start Time";
    }
    return null;
  }

  static String? validateLastName(String value) {
    if (value.isEmpty) return "Last name is required";
    if (value.length <= 2) {
      return "Last name is too short";
    }

    return null;
  }


  static String? validateFullName(String value) {
    if (value.isEmpty) {
      return 'Please enter your full name';
    }

    if (value.length <= 3) {
      return 'Name must be grater than 3 characters';
    }

    if (!RegExp(r"^[A-Z a-z]{2,25}$").hasMatch(value)) {
      return 'Incorrect full name';
    }

    return null;
  }
  static String? validateItemName(String value) {
    if (value.isEmpty) {
      return 'Please enter your Item name';
    }

    if (value.length <= 3) {
      return 'Name must be grater than 3 characters';
    }

    if (!RegExp(r"^[A-Z a-z]{2,25}$").hasMatch(value)) {
      return 'Incorrect Item name';
    }

    return null;
  }


  static String? validateUserName(String value) {
    if (value.isEmpty) return "User name is required";
    if (value.length <= 1) {
      return "First name is too short";
    }

    return null;
  }
  static String? validateHeight(String value) {
    if (value.isEmpty) return "Height is required";
    return null;
  }
  static String? validateWidth(String value) {
    if (value.isEmpty) return "Width is required";
    return null;
  }
  static String? validateWeight(String value) {
    if (value.isEmpty) return "Weight is required";
    return null;
  }


  static String? validatePinCode(String? value) {
    if (value!.isEmpty) {
      return "Incorrect PINCODE";
    }
    return null;
  }

  static String? validatePhoneNumber(String value) {
    if (value.isEmpty) return "Phone number is required";
    Pattern pattern = r'(^(?:[+0]9)?[0-9]{9,20}$)';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value.trim())) {
      return "Please enter a valid phone number";
    }
    return null;
  }
}
