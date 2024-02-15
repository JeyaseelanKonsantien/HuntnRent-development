import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hunt_and_rent/screens/dashboard/renter_pages/renter_profile/ratings_page/widget/ratings_widget.dart';

import '../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../base/widget_utils.dart';
import '../../../../../resources/resources.dart';

class MyRatings extends StatelessWidget {
  const MyRatings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          title: Center(
            child: Text(
              "Reviews",
              style: R.textStyle
                  .mediumMetropolis()
                  .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
            ),
          )),
     
      body: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
          children: [
            Align(
                alignment: Alignment.center,
                child: Text("(5 reviews)",style: R.textStyle.semiBoldMetropolis().copyWith(fontSize: FetchPixels.getPixelHeight(15)),)),
         Column(children: List.generate(5, (index) {
           return RatingsWidget();
         }),),
          ]),
    );
  }
}
