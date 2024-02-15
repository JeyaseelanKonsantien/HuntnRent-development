import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/utils/validator.dart';
import 'package:provider/provider.dart';

import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../resources/resources.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/my_button.dart';
import '../model/user_model.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailCT = TextEditingController();
  TextEditingController userNameCT = TextEditingController();
  TextEditingController passCT = TextEditingController();
  TextEditingController fullNameCT = TextEditingController();
  TextEditingController qidCT = TextEditingController();
  TextEditingController phoneCT = TextEditingController();
  TextEditingController confirmPassCT = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          body: getPaddingWidget(
            EdgeInsets.all(FetchPixels.getPixelWidth(20)),
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // getVerSpace(FetchPixels.getPixelHeight(20)),
                      // Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: InkWell(
                      //         onTap: () {
                      //           Get.back();
                      //         },
                      //         child: Icon(Icons.arrow_back_ios))),
                      // getVerSpace(FetchPixels.getPixelHeight(10)),
                      // getAssetImage(
                      //   R.images.logo01,
                      //   height: FetchPixels.getPixelHeight(150),
                      //   width: FetchPixels.getPixelWidth(150),
                      // ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 4),
                      //   decoration: BoxDecoration(
                      //       color: R.colors.containerBG,
                      //       borderRadius: BorderRadius.circular(50)),
                      //   child: ToggleButtons(
                      //       color: R.colors.theme,
                      //       borderRadius: BorderRadius.circular(50),
                      //       selectedBorderColor: R.colors.bgColor,
                      //       renderBorder: false,
                      //       selectedColor: R.colors.whiteColor,
                      //       children: [
                      //         Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(horizontal: 4.0),
                      //           child: MyButton(
                      //             height: FetchPixels.getPixelHeight(30),
                      //             color: R.colors.transparent,
                      //             borderRadius: 50,
                      //             textSize: 12,
                      //             textColor:
                      //                 R.colors.blackColor.withOpacity(0.6),
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
                      //             color: R.colors.whiteColor,
                      //             borderRadius: 50,
                      //             textSize: 12,
                      //             textColor: R.colors.blackColor,
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

                      // getAssetImage(R.images.logo1,
                      //     scale: FetchPixels.getPixelHeight(18)),

                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     "Full Name",
                      //     style: R.textStyle.regularMetropolis().copyWith(
                      //         fontSize: FetchPixels.getPixelHeight(16)),
                      //   ),
                      // ),
                      getVerSpace(FetchPixels.getPixelHeight(20)),
                      TextFormField(
                        cursorColor: R.colors.theme,
                        controller: fullNameCT,
                        style: R.textStyle.mediumMetropolis().copyWith(
                            fontSize: FetchPixels.getPixelHeight(17),
                            color: R.colors.theme),
                        keyboardType: TextInputType.name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            FieldValidator.validateFullName(value!),
                        decoration: R.decorations
                            .textFormFieldDecoration(null, "Full name"),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     "QID",
                      //     style: R.textStyle.regularMetropolis().copyWith(
                      //         fontSize: FetchPixels.getPixelHeight(16)),
                      //   ),
                      // ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      TextFormField(
                        controller: qidCT,
                        style: R.textStyle.mediumMetropolis().copyWith(
                            fontSize: FetchPixels.getPixelHeight(17),
                            color: R.colors.theme),
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            FieldValidator.validateEmptyField(value!),
                        decoration:
                            R.decorations.textFormFieldDecoration(null, "QID"),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     "Email",
                      //     style: R.textStyle.regularMetropolis().copyWith(
                      //         fontSize: FetchPixels.getPixelHeight(16)),
                      //   ),
                      // ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      TextFormField(
                        controller: emailCT,
                        style: R.textStyle.mediumMetropolis().copyWith(
                            fontSize: FetchPixels.getPixelHeight(17),
                            color: R.colors.theme),
                        validator: (value) =>
                            FieldValidator.validateEmail(value!),
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        decoration: R.decorations
                            .textFormFieldDecoration(null, "Email"),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     "Phone #",
                      //     style: R.textStyle.regularMetropolis().copyWith(
                      //         fontSize: FetchPixels.getPixelHeight(16)),
                      //   ),
                      // ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      TextFormField(
                        controller: phoneCT,
                        style: R.textStyle.mediumMetropolis().copyWith(
                            fontSize: FetchPixels.getPixelHeight(17),
                            color: R.colors.theme),
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            FieldValidator.validatePhoneNumber(value!),
                        decoration: R.decorations
                            .textFormFieldDecoration(null, "Phone number"),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     "Username",
                      //     style: R.textStyle.regularMetropolis().copyWith(
                      //         fontSize: FetchPixels.getPixelHeight(16)),
                      //   ),
                      // ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      TextFormField(
                        controller: userNameCT,
                        style: R.textStyle.mediumMetropolis().copyWith(
                            fontSize: FetchPixels.getPixelHeight(17),
                            color: R.colors.theme),
                        keyboardType: TextInputType.name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            FieldValidator.validateUserName(value!),
                        decoration: R.decorations
                            .textFormFieldDecoration(null, "Username"),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     "Password",
                      //     style: R.textStyle.regularMetropolis().copyWith(
                      //         fontSize: FetchPixels.getPixelHeight(16)),
                      //   ),
                      // ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      TextFormField(
                        controller: passCT,
                        style: R.textStyle.mediumMetropolis().copyWith(
                            fontSize: FetchPixels.getPixelHeight(17),
                            color: R.colors.theme),
                        keyboardType: TextInputType.visiblePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            FieldValidator.validatePassword(value!),
                        decoration: R.decorations
                            .textFormFieldDecoration(null, "Password"),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     "Confirm Password",
                      //     style: R.textStyle.regularMetropolis().copyWith(
                      //         fontSize: FetchPixels.getPixelHeight(16)),
                      //   ),
                      // ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      TextFormField(
                        controller: confirmPassCT,
                        style: R.textStyle.mediumMetropolis().copyWith(
                            fontSize: FetchPixels.getPixelHeight(17),
                            color: R.colors.theme),
                        keyboardType: TextInputType.visiblePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.done,
                        validator: (value) =>
                            FieldValidator.validatePasswordMatch(
                                passCT.text, value!),
                        decoration: R.decorations
                            .textFormFieldDecoration(null, "Confirm Password"),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(40)),
                      auth.isLoading == true
                          ? Center(
                              child: CircularProgressIndicator(
                              strokeWidth: 10,
                              color: R.colors.theme,
                            ))
                          : MyButton(
                              borderRadius: 50,
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  auth.startLoader();
                                  UsersModel userModel = UsersModel(
                                    cart: [],
                                    favrt: [],
                                    fullName: fullNameCT.text,
                                    email: emailCT.text,
                                    phoneNumber: phoneCT.text,
                                    isRenter: auth.userModel.isRenter,
                                    userImage: "",
                                    userName: userNameCT.text,
                                    qid: qidCT.text,
                                    accountNumber: "",
                                    iban: "",
                                    swiftCode: "",
                                    bankAddress: "",
                                    address: "",

                                  );
                                  await auth.registerUser(
                                      userModel, confirmPassCT.text);
                                  auth.stopLoader();
                                }
                              },
                              buttonText: "Sign up",
                            ),

                      getVerSpace(FetchPixels.getPixelHeight(20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: R.textStyle.regularMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(14)),
                          ),
                          getHorSpace(FetchPixels.getPixelWidth(10)),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.LoginSignup);
                            },
                            child: Text(
                              "LOGIN",
                              style: R.textStyle.semiBoldMetropolis().copyWith(
                                  color: R.colors.theme, fontSize: 14),
                            ),
                          )
                        ],
                      ),

                      // MyButton(
                      //     borderRadius: 50,
                      //     textColor: R.colors.theme,
                      //     width: FetchPixels.getPixelWidth(200),
                      //     color: R.colors.transparent,
                      //     onTap: () {
                      //       Get.toNamed(Routes.loginView);
                      //     },
                      //     buttonText: "LOGIN"),
                      getVerSpace(FetchPixels.getPixelHeight(20)),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
