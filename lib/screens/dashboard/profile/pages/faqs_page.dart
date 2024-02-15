import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hunt_and_rent/widgets/app_dropdown.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';
import '../../../../widgets/my_button.dart';

class FAQs extends StatefulWidget {
  FAQs({super.key});

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  ExpandableController expandCT = ExpandableController();
  ExpandableController expandCT2 = ExpandableController();
  ExpandableController expandCT3 = ExpandableController();

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
          elevation: 2.0,
          centerTitle: true,
          title: Text(
            "FAQ’s",
            style: R.textStyle
                .mediumMetropolis()
                .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
          )),
      body: getPaddingWidget(
        EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
        ListView(children: [
          // MyButton(color: R.colors.whiteColor,
          //     textColor: R.colors.blackColor,
          //     onTap: () {},
          //     buttonText: "Welcome Hunter to Hunt&Rent!"),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Welcome Hunter to Hunt&Rent!",
              style: R.textStyle
                  .semiBoldMetropolis()
                  .copyWith(color: R.colors.blackColor, fontSize: 20),
            ),
          ),

          getVerSpace(FetchPixels.getPixelHeight(10)),
          getPaddingWidget(
            EdgeInsets.only(left: FetchPixels.getPixelWidth(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropDownDynamicWidget2(
                  heading: "Select SubCategory",
                  selectedWord: "What is Hunt & Rent?",
                  dropDownItems: [
                    "Acceptance of Terms:",
                    "By accessing and uxsing the Hunt&Rent platform, you agree to be bound by these terms and conditions. If you do not agree to these terms, please refrain from using the platform.",
                  ],
                  controller: expandCT,
                  onSelect: (value) {},
                  onTap: () {
                    setState(() {});
                    expandCT.toggle();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                DropDownDynamicWidget2(
                  heading: "Select SubCategory",
                  selectedWord: "What is Rental Process?",
                  dropDownItems: [
                    "Rental Process:",
                    "The platform allows you to browse and rent clothing items from our inventory. You agree to use the rented items responsibly and return them in the specified condition and time frame",
                  ],
                  controller: expandCT2,
                  onSelect: (value) {},
                  onTap: () {
                    setState(() {});
                    expandCT2.toggle();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                DropDownDynamicWidget2(
                  heading: "Select SubCategory",
                  selectedWord: "How we deal with Rental Fees & Payments?",
                  dropDownItems: [
                    "Rental Fees and Payments:",
                    "Rental fees, including any applicable service charges, will be clearly communicated to you during the checkout process. Payment for rentals is due at the time of booking and can be made through the available payment methods on the platform.",
                  ],
                  controller: expandCT3,
                  onSelect: (value) {},
                  onTap: () {
                    setState(() {});
                    expandCT3.toggle();
                  },
                ),
                getVerSpace(FetchPixels.getPixelHeight(10)),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
