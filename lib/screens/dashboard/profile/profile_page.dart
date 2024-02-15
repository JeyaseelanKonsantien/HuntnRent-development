import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/base/widget_utils.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/pages/edit_profile_view.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../dialog/on_tap_dialog.dart';
import '../../../resources/resources.dart';
import '../../../routes/app_routes.dart';
import '../dashboard_view.dart';
import 'bottom_sheet/ratings_bottoms.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<String> images = [
    R.images.orderHistory,
    R.images.notifications,
    R.images.fav1,
    R.images.performance,
    R.images.performance,
    R.images.support,
    R.images.rate,
    R.images.share,
    R.images.about,
    R.images.about,
    R.images.terms,
    R.images.privacy,
    R.images.faqs,
    R.images.faqs,
    R.images.logout,
  ];

  List<String> names = [
    "My Order History",
    "Notifications",
    "My Wishlist",
    "My Performance",
    "My Performance",
    "Support",
    "Rate",
    "Share",
    "About Hunt & Rent",
    "About Hunt & Rent",
    "Terms & Conditions",
    "Privacy Policy",
    "FAQs",
    "FAQs",
    "Logout",
  ];

  Future getMyOrdersDetails() async {
    var auth = Provider.of<AuthProvider>(context, listen: false);
    var product = Provider.of<ProductProvider>(context, listen: false);
    product.myList.clear();
    for (int i = 0;
        i <
            product.earningsList
                .where((element) => element.customerId == auth.userModel.email)
                .toList()
                .length;
        i++) {
      product.myList.add(product.earningsList
          .where((element) => element.customerId == auth.userModel.email)
          .toList()[i]
          .productId!);
      print("MyList.lenth ${product.myList.length}");
    }
    product.myOwnProducts.clear();
    for (int i = 0; i < product.myList.length; i++) {
      product.myOwnProducts.add(product.products
          .where((element) => element.docId == product.myList[i])
          .toList()[0]);
      print("MyOwnProducts.lenth ${product.myOwnProducts.length}");
    }
  }

  @override
  void initState() {
    getMyOrdersDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return ListView(
          padding:
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
          children: [
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Row(
              children: [
                getHorSpace(FetchPixels.getPixelWidth(10)),
                InkWell(
                    onTap: () {
                      Get.offAll(() => DashboardView(
                            index: 0,
                          ));
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                    )),
                getHorSpace(FetchPixels.getPixelWidth(20)),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      "My Profile",
                      style: R.textStyle
                          .semiBoldMetropolis()
                          .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                    )),
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Center(
              child: SizedBox(
                height: FetchPixels.getPixelHeight(100),
                width: FetchPixels.getPixelWidth(80),
                child: InkWell(
                  onTap: () {
                    Get.to(() => EditProfileView());
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
                            : getCircularNetworkImage(auth.userModel.userImage!,
                                boxFit: BoxFit.fill),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding:
                              EdgeInsets.all(FetchPixels.getPixelHeight(5)),
                          // height: FetchPixels.getPixelHeight(20),
                          // width: FetchPixels.getPixelWidth(20),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: R.colors.blackColor.withOpacity(0.2),
                                    spreadRadius: FetchPixels.getPixelHeight(2),
                                    blurRadius: FetchPixels.getPixelHeight(2))
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
            )
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Stack(
            //       children: [
            //         InkWell(
            //           onTap: () {
            //             Get.to(() => EditProfileView());
            //           },
            //           child: CircularProfileAvatar(
            //             "",
            //             radius: FetchPixels.getPixelWidth(40),
            //             child: auth.userModel.userImage == ""
            //                 ? auth.pickedImage == null
            //                     ? getAssetImage(R.images.profileImage,
            //                         boxFit: BoxFit.fill)
            //                     : Image.file(auth.pickedImage!,
            //                         fit: BoxFit.fill)
            //                 : getCircularNetworkImage(auth.userModel.userImage!,
            //                     boxFit: BoxFit.fill),
            //           ),
            //         ),
            //         Column(
            //           children: [
            //             Align(
            //               alignment: Alignment.center,
            //               child: Container(
            //                 padding:
            //                     EdgeInsets.all(FetchPixels.getPixelHeight(5)),
            //                 // height: FetchPixels.getPixelHeight(20),
            //                 // width: FetchPixels.getPixelWidth(20),
            //                 decoration: BoxDecoration(
            //                     boxShadow: [
            //                       BoxShadow(
            //                           color:
            //                               R.colors.blackColor.withOpacity(0.2),
            //                           spreadRadius:
            //                               FetchPixels.getPixelHeight(2),
            //                           blurRadius: FetchPixels.getPixelHeight(2))
            //                     ],
            //                     color: R.colors.whiteColor,
            //                     shape: BoxShape.circle),
            //                 child: InkWell(
            //                   onTap: () {
            //                     Get.to(() => EditProfileView());
            //                   },
            //                   child: Icon(
            //                     Icons.edit,
            //                     color: R.colors.blackColor,
            //                     size: FetchPixels.getPixelHeight(16),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         )
            //       ],
            //     ),
            //   ],
            // ),
            // getVerSpace(FetchPixels.getPixelHeight(10)),
            // InkWell(
            //   onTap: () {
            //     Get.to(() => EditProfileView());
            //   },
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: Text("Edit Profile"),
            //     // TextButton.icon(
            //     //   icon: Icon(Icons.edit),
            //     //   onPressed: () {},
            //     //   label: Text('Edit Profile'),
            //     // ),
            //   ),
            // ),
            ,
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Column(
              children: List.generate(images.length, (index) {
                return index == 4 || index == 8 || index == 13
                    ? Divider(
                        color: R.colors.fillColor,
                        indent: 15,
                        endIndent: 15,
                        height: FetchPixels.getPixelHeight(30),
                      )
                    : pagesNames(index, auth);
              }),
            ),
            getVerSpace(FetchPixels.getPixelHeight(120)),
          ],
        );
      },
    );
  }

  pagesNames(index, AuthProvider auth) {
    return GestureDetector(
      onTap: index == 14
          ? () {
              Get.dialog(OnTapFunctionDialog(
                headingText: "",
                onTap: () async {
                  await auth.signOutQuery();
                  auth.update();
                },
                text: "Are You Sure You Want To Logout?",
              ));
            }
          : () {
              index == 6
                  ? Get.bottomSheet(RatingsBottom())
                  : index == 7
                      ? Get.to(Share.share(
                          'check out my website https://example.com',
                          subject: 'Look what I made!'))
                      : Get.toNamed(index == 0
                          ? Routes.orderHistory
                          : index == 1
                              ? Routes.notificationsView
                              : index == 2
                                  ? Routes.wishList
                                  : index == 3
                                      ? Routes.performancePage
                                      : index == 5
                                          ? Routes.supportView
                                          : index == 9
                                              ? Routes.aboutHunt
                                              : index == 10
                                                  ? Routes.termsConditions
                                                  : index == 11
                                                      ? Routes.privacyPolicy
                                                      : index == 12
                                                          ? Routes.fAQs
                                                          : Routes.fAQs);
            },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(5)),
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelWidth(15),
            vertical: FetchPixels.getPixelHeight(15)),
        decoration: BoxDecoration(
            border: Border.all(
                color: R.colors.transparent,
                width: FetchPixels.getPixelHeight(1.2)),
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(9))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                getAssetImage(images[index],
                    scale: FetchPixels.getPixelHeight(3.8)),
                getHorSpace(FetchPixels.getPixelWidth(15)),
                Text(
                  names[index],
                  style: R.textStyle.mediumMetropolis().copyWith(
                      fontSize: FetchPixels.getPixelHeight(
                        15,
                      ),
                      color: index == 14 ? R.colors.redColor : R.colors.theme),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: R.colors.bottom,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
