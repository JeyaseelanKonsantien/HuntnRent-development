import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';
import 'package:provider/provider.dart';

import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../resources/resources.dart';
import '../../../utils/validator.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailCT = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          appBar: AppBar(
              leading: Center(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: R.colors.blackColor,
                  ),
                ),
              ),
              iconTheme: IconThemeData(
                color: R.colors.whiteColor, //change your color here
              ),
              automaticallyImplyLeading: false,
              backgroundColor: R.colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                "Reset Password",
                style: R.textStyle.semiBoldMetropolis().copyWith(
                      fontSize: FetchPixels.getPixelHeight(18),
                    ),
              )),
          body: getPaddingWidget(
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getVerSpace(FetchPixels.getPixelHeight(50)),
                      Text(
                        "Enter your email so we can share with you a password reset link:",
                        textAlign: TextAlign.start,
                        style: R.textStyle
                            .regularMetropolis()
                            .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(150)),
                      // Text(
                      //   "Email",
                      //   textAlign: TextAlign.center,
                      //   style: R.textStyle
                      //       .regularMetropolis()
                      //       .copyWith(fontSize: FetchPixels.getPixelHeight(17)),
                      // ),
                      TextFormField(
                        cursorColor: R.colors.theme.withOpacity(0.3),
                        controller: emailCT,
                        style: R.textStyle.mediumMetropolis().copyWith(
                            fontSize: FetchPixels.getPixelHeight(14),
                            color: R.colors.theme),
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            FieldValidator.validateEmail(value!),
                        decoration: R.decorations
                            .textFormFieldDecoration(null, "Email"),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(50)),
                      Align(
                          alignment: Alignment.center,
                          child: MyButton(
                              borderRadius: 50,
                              textSize: 16,
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  await auth.sendResetPassEmail(emailCT.text);
                                }
                              },
                              buttonText: "SEND LINK")),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
