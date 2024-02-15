import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/resources.dart';

class AppTextStyle {
  ///textstyles///

  TextStyle regularMetropolis() {
    return TextStyle(
      fontSize: 12,
      fontFamily: 'Metropolis',
      letterSpacing: 0.05,

      color: R.colors.blackColor,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle regularPraise() {
    return TextStyle(
      fontSize: 12,
      fontFamily: 'Praise',
      letterSpacing: 0.05,
      color: R.colors.theme,
      fontWeight: FontWeight.w400,
    );
  }

    TextStyle OnboardingDamion() {
    return TextStyle(
      fontSize: 12,
      fontFamily: 'Damion',
      letterSpacing: 0.05,
      color: R.colors.theme,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle regularMetropolisItalic() {
    return TextStyle(
      fontSize: 12,
      fontFamily: 'Poppins',
      letterSpacing: 0.05,
      color: R.colors.blackColor,
      fontWeight: FontWeight.w400,
    );
  }

  // TextStyle mediumMetropolis() {
  //   return TextStyle(
  //     fontSize: 15,
  //     fontFamily: 'Poppins',
  //     letterSpacing: 0,
  //     color: R.colors.blackColor,
  //     fontWeight: FontWeight.w500,
  //   );
  // }
  TextStyle mediumMetropolis() {
    return TextStyle(
      fontSize: 15,
      fontFamily: 'Metropolis',
      letterSpacing: 0,
      color: R.colors.blackColor,
      fontWeight: FontWeight.w500,
    );
  }


  TextStyle semiBoldMetropolis() {
    return TextStyle(
      fontSize: 15,
      fontFamily: 'Metropolis',
      letterSpacing: 0,
      color: R.colors.blackColor,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle semiBoldMetropolisItalic() {
    return TextStyle(
      fontSize: 15,
      fontFamily: 'Poppins',
      letterSpacing: 0,
      color: R.colors.blackColor,
      fontWeight: FontWeight.w600,
    );
  }

  // TextStyle boldInter() {
  //   return TextStyle(
  //     fontSize: 15,
  //     fontFamily: 'Inter',
  //     letterSpacing: 0,
  //     color: R.colors.whiteColor,
  //     fontWeight: FontWeight.w700,
  //   );
  // }
  // TextStyle boldInterItalic() {
  //   return TextStyle(
  //     fontSize: 15,
  //     fontFamily: 'Inter',
  //     letterSpacing: 0,
  //     color: R.colors.whiteColor,
  //     fontWeight: FontWeight.w700,
  //   );
  // }
}
