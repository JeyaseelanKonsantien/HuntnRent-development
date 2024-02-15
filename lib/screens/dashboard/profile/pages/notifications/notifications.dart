import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/pages/notifications/widget/notifications_widget.dart';

import '../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../base/widget_utils.dart';
import '../../../../../resources/resources.dart';
import '../../../../../widgets/my_button.dart';
import '../../../home/widgets/featured_product_widget.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

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
          title: Text(
            "Notifications",
            style: R.textStyle
                .mediumMetropolis()
                .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
          )),
     
      body: getPaddingWidget(
        EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
        ListView(children: [
          // getVerSpace(FetchPixels.getPixelHeight(10)),
          // Text("Today",style: R.textStyle.semiBoldMetropolis().copyWith(fontSize: FetchPixels.getPixelHeight(18)),),
          // getVerSpace(FetchPixels.getPixelHeight(10)),
          // Column(children: List.generate(2, (index) {
          //   return NotificationsWidget();
          // }),),
          // getVerSpace(FetchPixels.getPixelHeight(10)),
          // Text("Yesterday",style: R.textStyle.semiBoldMetropolis().copyWith(fontSize: FetchPixels.getPixelHeight(18)),),
          // getVerSpace(FetchPixels.getPixelHeight(10)),
          // Column(children: List.generate(4, (index) {
          //   return NotificationsWidget();
          // }),),
          // getVerSpace(FetchPixels.getPixelHeight(10)),
          // Text("Dec 22 2022",style: R.textStyle.semiBoldMetropolis().copyWith(fontSize: FetchPixels.getPixelHeight(18)),),
          // Column(children: List.generate(6, (index) {
          //   return NotificationsWidget();
          // }),)

        ]),
      ),
    );
  }
}
