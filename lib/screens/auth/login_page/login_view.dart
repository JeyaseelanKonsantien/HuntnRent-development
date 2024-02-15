import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/auth/user_type_view.dart';
import 'package:hunt_and_rent/utils/validator.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';
import 'package:provider/provider.dart';

import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../resources/resources.dart';
import '../../../routes/app_routes.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailCT = TextEditingController();
  TextEditingController passCT = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          body: getPaddingWidget(
            EdgeInsets.all(FetchPixels.getPixelWidth(20)),
            Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    // Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: InkWell(
                    //         onTap: () {
                    //           Get.to(() => UserTypeView());
                    //         },
                    //         child: Icon(Icons.arrow_back_ios))),
                    // getVerSpace(FetchPixels.getPixelHeight(20)),
                    // getAssetImage(
                    //   R.images.logo01,
                    //   height: FetchPixels.getPixelHeight(150),
                    //   width: FetchPixels.getPixelWidth(150),
                    // ),
                    // getVerSpace(FetchPixels.getPixelHeight(20)),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 4),
                    //   decoration: BoxDecoration(
                    //       color: R.colors.containerBG,
                    //       borderRadius: BorderRadius.circular(50)),
                    //   child: ToggleButtons(
                    //       color: R.colors.theme,
                    //       borderRadius: BorderRadius.circular(50),
                    //       selectedBorderColor: R.colors.transparent,
                    //       renderBorder: false,
                    //       selectedColor: R.colors.whiteColor,
                    //       children: [
                    //         Padding(
                    //           padding:
                    //               const EdgeInsets.symmetric(horizontal: 4.0),
                    //           child: MyButton(
                    //             height: FetchPixels.getPixelHeight(30),
                    //             color: R.colors.whiteColor,
                    //             borderRadius: 50,
                    //             textSize: 12,
                    //             textColor: R.colors.blackColor,
                    //             width: FetchPixels.getPixelWidth(100),
                    //             buttonText: "Login",
                    //             onTap: () {
                    //               Get.toNamed(Routes.loginView);
                    //             },
                    //           ),
                    //         ),
                    //         Padding(
                    //           padding:
                    //               const EdgeInsets.symmetric(horizontal: 4.0),
                    //           child: MyButton(
                    //             height: FetchPixels.getPixelHeight(30),
                    //             color: R.colors.transparent,
                    //             borderRadius: 50,
                    //             textSize: 12,
                    //             textColor: R.colors.blackColor.withOpacity(0.6),
                    //             width: FetchPixels.getPixelWidth(100),
                    //             buttonText: "Sign Up",
                    //             onTap: () {
                    //               Get.toNamed(Routes.signUpView);
                    //             },
                    //           ),
                    //         )
                    //       ],
                    //       isSelected: [
                    //         true,
                    //         false
                    //       ]),
                    // ),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    TextFormField(
                      cursorColor: R.colors.theme,
                      controller: emailCT,
                      style: R.textStyle.mediumMetropolis().copyWith(
                          fontSize: FetchPixels.getPixelHeight(17),
                          color: R.colors.theme),
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          FieldValidator.validateUserName(value!),
                      decoration: R.decorations
                          .textFormFieldDecoration(
                            Icon(Icons.person_2_outlined),
                            "Email",
                          )
                          .copyWith(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      width: 2, color: R.colors.theme)),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: R.colors.fillColor,
                                ),
                                borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(50)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      width: 2, color: R.colors.fillColor)),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(50)),
                                borderSide: BorderSide(
                                    width: 2, color: R.colors.fillColor),
                              )),
                    ),
                    // getVerSpace(FetchPixels.getPixelHeight(20)),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     "Password",
                    //     style: R.textStyle
                    //         .regularMetropolis()
                    //         .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
                    //   ),
                    // ),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    TextFormField(
                      cursorColor: R.colors.theme,
                      controller: passCT,
                      style: R.textStyle.regularMetropolis().copyWith(
                          fontSize: FetchPixels.getPixelHeight(15),
                          color: R.colors.theme),
                      validator: (value) =>
                          FieldValidator.validatePassword(value!),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: auth.isPassVisible,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.done,
                      decoration: R.decorations
                          .textFormFieldDecoration(
                              Icon(Icons.lock_outline_rounded), "Password",
                              suffix: InkWell(
                                  onTap: () {
                                    auth.changePassVisible();
                                  },
                                  child: Icon(
                                    auth.isPassVisible == true
                                        ? Icons.visibility_off
                                        : Icons.remove_red_eye,
                                    color: R.colors.theme,
                                  )))
                          .copyWith(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      width: 2, color: R.colors.theme)),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: R.colors.fillColor,
                                ),
                                borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(50)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      width: 2, color: R.colors.fillColor)),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(50)),
                                borderSide: BorderSide(
                                    width: 2, color: R.colors.fillColor),
                              )),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.forgotPassword);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: R.textStyle.regularMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(14),
                              decoration: TextDecoration.underline,
                              color: R.colors.blackColor),
                        ),
                      ),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(80)),
                    auth.isLoading == true
                        ? Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 10,
                              color: R.colors.theme,
                            ),
                          )
                        : MyButton(
                            borderRadius: 50,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                auth.signInMethod(emailCT.text, passCT.text);
                              }
                            },
                            buttonText: "Login",
                          ),
                    getVerSpace(FetchPixels.getPixelHeight(60)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account?",
                          style: R.textStyle.regularMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(14)),
                        ),
                        getHorSpace(FetchPixels.getPixelWidth(10)),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.LoginSignup);
                          },
                          child: Text(
                            "SIGNUP",
                            style: R.textStyle
                                .semiBoldMetropolis()
                                .copyWith(color: R.colors.theme, fontSize: 14),
                          ),
                        ),
                        // MyButton(
                        //     textColor: R.colors.theme,
                        //     color: R.colors.transparent,
                        //     width: FetchPixels.getPixelWidth(50),
                        //     onTap: () {
                        //       Get.toNamed(Routes.signUpView);
                        //     },
                        //     buttonText: "SIGNUP")
                      ],
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(10)),

                    // tab design
                    // Container(
                    //   width: FetchPixels.getPixelWidth(250),
                    //   child: DefaultTabController(
                    //       animationDuration: Duration(milliseconds: 300),
                    //       length: 2,
                    //       child: TabBar(
                    //         dividerColor: Colors.transparent,
                    //         indicator: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(25),
                    //             color: R.colors.redColor),
                    //         tabs: [
                    //           Padding(
                    //             padding:
                    //                 const EdgeInsets.symmetric(horizontal: 4.0),
                    //             child: Text('LOG IN'),
                    //           ),
                    //           Padding(
                    //             padding:
                    //                 const EdgeInsets.symmetric(horizontal: 4.0),
                    //             child: Text('SIGN UP'),
                    //           )
                    //         ],
                    //       )),
                    // ),

                    ////
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
