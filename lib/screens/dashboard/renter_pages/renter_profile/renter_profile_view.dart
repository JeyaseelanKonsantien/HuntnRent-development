import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/base/widget_utils.dart';
import 'package:hunt_and_rent/screens/auth/login_signup.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/dashboard_view.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/pages/about_hunt.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/pages/bank_details.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/pages/faqs_page.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/pages/notifications/notifications.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/pages/privacy_policy.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/pages/support.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/pages/terms_conditions.dart';
import 'package:hunt_and_rent/screens/dashboard/renter_pages/renter_home/earnings/earnings_view.dart';
import 'package:hunt_and_rent/screens/dashboard/renter_pages/renter_home/rentals_view/rentals_view.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../dialog/on_tap_dialog.dart';
import '../../../../resources/resources.dart';

class RenterProfileView extends StatelessWidget {
  RenterProfileView({super.key});

  List<String> images = [
    // R.images.orderHistory,
    R.images.notifications,
    // R.images.fav1,
    R.images.credit,
    R.images.supplier,
    R.images.performance,
    R.images.support,
    R.images.rate,
    R.images.share,
    R.images.share,
    R.images.about,
    R.images.terms,
    R.images.privacy,
    R.images.faqs,
  ];
  List<String> names = [
    // "My Home Page",
    "Notifications",
    // "Get Featured Now!",
    "Edit/Update Bank Account Details ",
    "My Performance",
    "My Rank",
    "My Rentals",
    "My Revenue",
    "Share",
    "My Ratings/Reviews",
    "About Hunt & Rent",
    "Terms & Conditions",
    "Privacy Policy",
    "FAQs",
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return ListView(
          padding:
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
          children: [
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Center(
              child: SizedBox(
                height: FetchPixels.getPixelHeight(80),
                width: FetchPixels.getPixelWidth(80),
                child: InkWell(
                  onTap: () {
                    auth.getImage1();
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
            ),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            Align(alignment: Alignment.center, child: Text("Edit Profile")),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Column(
              children: List.generate(images.length, (index) {
                return index == 2 || index == 7
                    ? Divider(
                        color: R.colors.fillColor,
                        indent: 15,
                        endIndent: 15,
                        height: FetchPixels.getPixelHeight(30),
                      )
                    : pagesNames(index);
              }),
            ),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Divider(),
            InkWell(
              onTap: () {
                Get.dialog(OnTapFunctionDialog(
                  headingText: " ",
                  onTap: () {
                    Get.offAll(LoginSignup());
                  },
                  text: "Are You Sure You Want to Logout?",
                ));
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: FetchPixels.getPixelHeight(5)),
                padding: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelWidth(15),
                    vertical: FetchPixels.getPixelHeight(15)),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: R.colors.transparent,
                        width: FetchPixels.getPixelHeight(1.2)),
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(9))),
                child: Row(
                  children: [
                    getAssetImage(R.images.logout,
                        scale: FetchPixels.getPixelHeight(3.8)),
                    getHorSpace(FetchPixels.getPixelWidth(15)),
                    Text(
                      "Logout",
                      style: R.textStyle.mediumMetropolis().copyWith(
                          fontSize: FetchPixels.getPixelHeight(
                            15,
                          ),
                          color: R.colors.redColor),
                    )
                  ],
                ),
              ),
            ),
            getVerSpace(FetchPixels.getPixelHeight(120)),
          ],
        );
      },
    );
  }

  pagesNames(index) {
    return GestureDetector(
      onTap: () {
        index == 0
            ? Get.to(NotificationsView())
            // : index == 0
            //     ? Get.to(NotificationsView())
            : index == 1
                ? Get.to(BankDetailsView())
                : index == 3
                    ? Get.offAll(DashboardView(
                        index: 2,
                      ))
                    : index == 4
                        ? Get.to(RentalsView())
                        : index == 5
                            ? Get.to(EarningsView())
                            : index == 6
                                ? Get.to(Share.share(
                                    'check out my website https://example.com',
                                    subject: 'Look what I made!'))
                                : index == 7
                                    ? Get.to(SupportView())
                                    : index == 8
                                        ? Get.to(AboutHunt())
                                        : index == 9
                                            ? Get.to(TermsConditions())
                                            : index == 10
                                                ? Get.to(PrivacyPolicy())
                                                : index == 11
                                                    ? Get.to(FAQs())
                                                    : null;

        // index == 7
        //     ? Get.bottomSheet(RatingsBottom())
        //     : index == 8
        //     ? Get.to(Share.share('check out my website https://example.com',
        //     subject: 'Look what I made!'))
        //     : Get.toNamed(index == 0
        //     ? Routes.orderHistory
        //     : index == 1
        //     ? Routes.notificationsView
        //     : index == 2
        //     ? Routes.wishList
        //     : index == 3
        //     ? Routes.performancePage
        //     : index == 10
        //     ? Routes.aboutHunt
        //     : index == 11
        //     ? Routes.termsConditions
        //     : index == 12
        //     ? Routes.privacyPolicy
        //     : Routes.fAQs);
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
