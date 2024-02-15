import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  int totalBookings = 0;
  int thisMonthBookings = 0;
  int previousMonthBookings = 0;
  int totalRevenue = 0;

  @override
  void initState() {
    getTotalBookings();
    getThisMonthBookings();
    getPreviousMonthBookings();
    getRevenue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, product, child) {
      return getPaddingWidget(
        EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
        ListView(children: [
          getVerSpace(FetchPixels.getPixelHeight(10)),
          Center(
            child: LinearPercentIndicator(
              barRadius: Radius.circular(FetchPixels.getPixelHeight(30)),
              width: FetchPixels.getPixelWidth(350),
              backgroundColor: R.colors.containerBG,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2000,
              percent: totalBookings <= 10 ? totalBookings / 10 : 0.5,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: R.colors.goldenColor,
            ),
          ),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          Center(
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Rental Performance: ",
                  style: R.textStyle
                      .regularMetropolis()
                      .copyWith(fontSize: FetchPixels.getPixelHeight(17))),
              TextSpan(
                  text: "Very Good",
                  style: R.textStyle.mediumMetropolis().copyWith(
                      fontSize: FetchPixels.getPixelHeight(17),
                      color: R.colors.theme)),
            ])),
          ),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          Center(
            child: getAssetImage(R.images.starImage,
                scale: FetchPixels.getPixelHeight(7)),
          ),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          Center(
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Rank :  ",
                  style: R.textStyle
                      .mediumMetropolis()
                      .copyWith(fontSize: FetchPixels.getPixelHeight(20))),
              TextSpan(
                  text: "Gold",
                  style: R.textStyle.semiBoldMetropolis().copyWith(
                      fontSize: FetchPixels.getPixelHeight(22),
                      color: R.colors.goldenColor)),
            ])),
          ),
          getVerSpace(FetchPixels.getPixelHeight(15)),
          InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$totalBookings",
                    style: R.textStyle.mediumMetropolis().copyWith(
                        color: R.colors.theme,
                        fontSize: FetchPixels.getPixelHeight(17))),
                Text(
                  "Total Bookings:",
                  style: R.textStyle.mediumMetropolis().copyWith(
                      color: R.colors.theme,
                      fontSize: FetchPixels.getPixelHeight(17)),
                ),
              ],
            ),
          ),
          getVerSpace(FetchPixels.getPixelHeight(15)),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getHorSpace(FetchPixels.getPixelWidth(10)),
              // Icon(
              //   Icons.circle,
              //   size: FetchPixels.getPixelHeight(8),
              // ),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              Text(
                "Bookings this Month:",
                style: R.textStyle
                    .regularMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
              ),
              Spacer(),
              Text("$thisMonthBookings",
                  style: R.textStyle
                      .mediumMetropolis()
                      .copyWith(fontSize: FetchPixels.getPixelHeight(16))),
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(15)),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getHorSpace(FetchPixels.getPixelWidth(10)),
              // Icon(
              //   Icons.circle,
              //   size: FetchPixels.getPixelHeight(8),
              // ),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              Text(
                "Previous Month:",
                style: R.textStyle
                    .regularMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
              ),
              Spacer(),
              Text("$previousMonthBookings",
                  style: R.textStyle
                      .mediumMetropolis()
                      .copyWith(fontSize: FetchPixels.getPixelHeight(16))),
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(15)),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getHorSpace(FetchPixels.getPixelWidth(20)),
              // Icon(
              //   Icons.circle,
              //   size: FetchPixels.getPixelHeight(8),
              // ),
              // getHorSpace(FetchPixels.getPixelWidth(10)),
              Text(
                "Bookings Fulfilled:",
                style: R.textStyle
                    .regularMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
              ),
              Spacer(),
              Text("$totalBookings",
                  style: R.textStyle
                      .mediumMetropolis()
                      .copyWith(fontSize: FetchPixels.getPixelHeight(16))),
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getHorSpace(FetchPixels.getPixelWidth(20)),
              Text(
                "Average Ratings:",
                style: R.textStyle
                    .regularMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
              ),
              Spacer(),
              getAssetImage(R.images.star,
                  scale: FetchPixels.getPixelHeight(3)),
              getHorSpace(FetchPixels.getPixelWidth(5)),
              Text("4.8",
                  style: R.textStyle
                      .mediumMetropolis()
                      .copyWith(fontSize: FetchPixels.getPixelHeight(16))),
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getHorSpace(FetchPixels.getPixelWidth(20)),
              Text(
                "Revenue:",
                style: R.textStyle
                    .semiBoldMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
              ),
              Spacer(),
              Text("QR $totalRevenue",
                  style: R.textStyle
                      .semiBoldMetropolis()
                      .copyWith(fontSize: FetchPixels.getPixelHeight(16))),
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          Divider()
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Amount Withdrawn:",
          //       style: R.textStyle
          //           .regularMetropolis()
          //           .copyWith(fontSize: FetchPixels.getPixelHeight(17)),
          //     ),
          //
          //     getHorSpace(FetchPixels.getPixelWidth(5)),
          //     Text("QR 200",
          //         style: R.textStyle
          //             .mediumMetropolis()
          //             .copyWith(fontSize: FetchPixels.getPixelHeight(17))),
          //   ],
          // ),
          // getVerSpace(FetchPixels.getPixelHeight(10)),
          // Text(
          //   "Top Performing Items: [List of Items]",
          //   textAlign: TextAlign.center,
          //   style: R.textStyle
          //       .regularMetropolis()
          //       .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
          // ),
          // getVerSpace(FetchPixels.getPixelHeight(10)),
          //
          // Text(
          //   "Popular Rental Categories:",
          //   textAlign: TextAlign.center,
          //   style: R.textStyle
          //       .regularMetropolis()
          //       .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
          // ),

          // MyButton(
          //     onTap: () {
          //       Get.to(DashboardView());
          //     },
          //     buttonText: "Go to Dashboard")
        ]),
      );
    });
  }

  getTotalBookings() async {
    var provider = Provider.of<ProductProvider>(context, listen: false);
    totalBookings = provider.earningsList
        .where((element) =>
            element.vendorId == FirebaseAuth.instance.currentUser!.email)
        .length;
    setState(() {});
  }

  getThisMonthBookings() async {
    var provider = Provider.of<ProductProvider>(context, listen: false);
    var now = DateTime.now();
    thisMonthBookings = provider.earningsList
        .where((element) =>
            element.vendorId == FirebaseAuth.instance.currentUser!.email)
        .where((element) => element.endDate!.toDate().month == now.month)
        .length;
    print("thisMonthBookings $thisMonthBookings");
    setState(() {});
  }

  getPreviousMonthBookings() async {
    var provider = Provider.of<ProductProvider>(context, listen: false);
    var now = DateTime.now();
    previousMonthBookings = provider.earningsList
        .where((element) =>
            element.vendorId == FirebaseAuth.instance.currentUser!.email)
        .where((element) => element.endDate!.toDate().month == now.month - 1)
        .length;
    print("previousMonthBookings $previousMonthBookings");
    setState(() {});
  }

  getRevenue() async {
    var provider = Provider.of<ProductProvider>(context, listen: false);
    totalRevenue = provider.earningsList
        .where((element) =>
            element.vendorId == FirebaseAuth.instance.currentUser!.email)
        .map((e) => int.parse(e.productPrice!))
        .reduce((value, element) => value + element);
    print("totalRevenue $totalRevenue");
    setState(() {});
  }
}
