import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/base/widget_utils.dart';
import 'package:hunt_and_rent/screens/auth/login_signup.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';
import 'package:provider/provider.dart';

import '../../resources/resources.dart';

class UserTypeView extends StatelessWidget {
  const UserTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          body: getPaddingWidget(
            EdgeInsets.symmetric(
                horizontal: FetchPixels.getPixelWidth(60),
                vertical: FetchPixels.getPixelHeight(60)),
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              // getAssetImage(R.images.logo1, scale: FetchPixels.getPixelHeight(12)),
              // getVerSpace(FetchPixels.getPixelHeight(160)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60.0),
                child: getAssetImage(
                  R.images.logo01,
                  height: FetchPixels.getPixelHeight(200),
                  width: FetchPixels.getPixelWidth(200),
                ),
              ),

              Text(
                "Would you like to be a",
                style: R.textStyle
                    .mediumMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
              ),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              MyButton(
                  onTap: () {
                    auth.userModel.isRenter = false;
                    Get.to(() => LoginSignup());
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => LoginSignup(),
                    // ));
                    auth.update();
                  },
                  buttonText: "HUNTER"),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              Text(
                "or",
                style: R.textStyle
                    .regularMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
              ),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              MyButton(
                  onTap: () {
                    auth.userModel.isRenter = true;
                    Get.to(LoginSignup());
                    auth.update();
                  },
                  buttonText: "RENTER"),
            ]),
          ),
        );
      },
    );
  }
}
