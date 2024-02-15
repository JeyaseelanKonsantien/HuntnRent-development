import 'package:flutter/material.dart';
import 'package:hunt_and_rent/screens/auth/sign_up_page/sign_up_view.dart';

import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../../resources/resources.dart';
import 'login_page/login_view.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({Key? key}) : super(key: key);

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.red,
          toolbarHeight: 200,
          centerTitle: true,
          title: getAssetImage(
            R.images.logo01,
            height: FetchPixels.getPixelHeight(150),
            width: FetchPixels.getPixelWidth(150),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.zero,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Material(
                borderRadius: BorderRadius.circular(50),
                color: R.colors.theme.withOpacity(0.2),
                child: TabBar(
                  indicatorPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  // indicatorWeight: 5,
                  // overlayColor: MaterialStateProperty.resolveWith(
                  //     (states) => R.colors.fillColor),
                  // padding: EdgeInsets.symmetric(horizontal: 40),
                  splashBorderRadius: BorderRadius.circular(50),
                  labelColor: R.colors.blackColor,
                  labelPadding: EdgeInsets.symmetric(vertical: 5),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerHeight: 0,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: R.colors.whiteColor,
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        "Login",
                        style: R.textStyle
                            .mediumMetropolis()
                            .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Sign Up",
                        style: R.textStyle
                            .mediumMetropolis()
                            .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: LoginView(),
            ),
            Center(
              child: SignUpView(),
            ),
          ],
        ),
      ),
    );
  }
}
