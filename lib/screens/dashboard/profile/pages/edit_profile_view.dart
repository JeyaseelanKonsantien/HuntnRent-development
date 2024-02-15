import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';
import 'package:provider/provider.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';

class EditProfileView extends StatefulWidget {
  EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController nameTC = TextEditingController();

  TextEditingController qidTC = TextEditingController();

  TextEditingController emailTC = TextEditingController();

  TextEditingController phoneNumberTC = TextEditingController();

  TextEditingController useraNameTC = TextEditingController();
  String? profileUrl;

  @override
  void initState() {
    var p = Provider.of<AuthProvider>(context, listen: false);
    nameTC.text = p.userModel.fullName ?? "";
    qidTC.text = p.userModel.qid ?? "";
    emailTC.text = p.userModel.email ?? "";
    profileUrl = p.userModel.userImage ?? "";
    phoneNumberTC.text = p.userModel.phoneNumber ?? "";
    useraNameTC.text = p.userModel.userName ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          appBar: AppBar(
              centerTitle: true,
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: FetchPixels.getPixelHeight(25),
                  color: R.colors.blackColor,
                ),
              ),
              iconTheme: IconThemeData(
                color: R.colors.whiteColor, //change your color here
              ),
              automaticallyImplyLeading: false,
              backgroundColor: R.colors.transparent,
              elevation: 0.0,
              // centerTitle: true,
              title: Text(
                "Edit Profile",
                style: R.textStyle
                    .mediumMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
              )),
          body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(20)),
              child: Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(40)),
                  Center(
                    child: SizedBox(
                      height: FetchPixels.getPixelHeight(80),
                      width: FetchPixels.getPixelWidth(80),
                      child: InkWell(
                        onTap: () {
                          auth.getImage1().then((value) async {
                            profileUrl = await (auth.uploadSingleFile(
                              file: auth.pickedImage,
                              userEmail: auth.userModel.email!,
                            ));
                          });
                        },
                        child: Stack(
                          children: [
                            CircularProfileAvatar(
                              "",
                              radius: FetchPixels.getPixelWidth(40),
                              child: auth.userModel.userImage == ""
                                  ? auth.pickedImage == null
                                      ? getAssetImage(R.images.profileImage,
                                          boxFit: BoxFit.fill)
                                      : Image.file(auth.pickedImage!,
                                          fit: BoxFit.fill)
                                  : getCircularNetworkImage(
                                      auth.userModel.userImage!,
                                      boxFit: BoxFit.fill),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: EdgeInsets.all(
                                    FetchPixels.getPixelHeight(5)),
                                // height: FetchPixels.getPixelHeight(20),
                                // width: FetchPixels.getPixelWidth(20),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: R.colors.blackColor
                                              .withOpacity(0.2),
                                          spreadRadius:
                                              FetchPixels.getPixelHeight(2),
                                          blurRadius:
                                              FetchPixels.getPixelHeight(2))
                                    ],
                                    color: R.colors.whiteColor,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.edit,
                                  color: R.colors.blackColor,
                                  size: FetchPixels.getPixelHeight(16),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('Full Name',
                          style: R.textStyle.regularMetropolis().copyWith(
                              color: R.colors.fillColor,
                              fontSize: FetchPixels.getPixelHeight(15)))),
                  TextFormField(
                    cursorColor: R.colors.blackColor,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: nameTC,
                    style: R.textStyle
                        .mediumMetropolis()
                        .copyWith(fontSize: FetchPixels.getPixelHeight(15)),
                    // decoration: InputDecoration(),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('QID',
                          style: R.textStyle.regularMetropolis().copyWith(
                              color: R.colors.fillColor,
                              fontSize: FetchPixels.getPixelHeight(15)))),
                  TextFormField(
                    cursorColor: R.colors.blackColor,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: qidTC,
                    style: R.textStyle
                        .mediumMetropolis()
                        .copyWith(fontSize: FetchPixels.getPixelHeight(15)),
                    // decoration:
                    //     R.decorations.textFormFieldDecoration(null, "QID"),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('Phone Number',
                          style: R.textStyle.regularMetropolis().copyWith(
                              color: R.colors.fillColor,
                              fontSize: FetchPixels.getPixelHeight(15)))),
                  TextFormField(
                    cursorColor: R.colors.blackColor,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: phoneNumberTC,
                    style: R.textStyle
                        .mediumMetropolis()
                        .copyWith(fontSize: FetchPixels.getPixelHeight(15)),
                    // decoration: R.decorations
                    //     .textFormFieldDecoration(null, "phone Number"),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('UserName',
                          style: R.textStyle.regularMetropolis().copyWith(
                              color: R.colors.fillColor,
                              fontSize: FetchPixels.getPixelHeight(15)))),
                  TextFormField(
                    cursorColor: R.colors.blackColor,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: useraNameTC,
                    style: R.textStyle
                        .mediumMetropolis()
                        .copyWith(fontSize: FetchPixels.getPixelHeight(15)),
                    // decoration:
                    //     R.decorations.textFormFieldDecoration(null, "userName"),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(60)),
                  auth.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: R.colors.theme,
                        ))
                      : MyButton(
                          borderRadius: 26,
                          onTap: () async {
                            if (profileUrl == "") {
                              Get.snackbar(
                                  backgroundColor: R.colors.theme,
                                  colorText: R.colors.whiteColor,
                                  "",
                                  "Please wait a second while picture is uploading");
                              return;
                            } else {
                              auth.startLoader();
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(auth.userModel.email)
                                  .update({
                                "fullName": nameTC.text,
                                "qid": qidTC.text,
                                "phoneNumber": phoneNumberTC.text,
                                "userName": useraNameTC.text,
                                "userImage": profileUrl,
                              }).then((value) {
                                auth.stopLoader();
                                Get.snackbar(
                                    backgroundColor: R.colors.theme,
                                    colorText: R.colors.whiteColor,
                                    "Done",
                                    "Your Profile is updated successfully");
                              });
                            }
                          },
                          buttonText: "UPDATE"),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                ],
              )),
        );
      },
    );
  }
}
