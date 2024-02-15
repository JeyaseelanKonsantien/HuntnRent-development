import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/base/widget_utils.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/renter_pages/renter_home/rentals_view/rentals_view.dart';
import 'package:provider/provider.dart';

import '../../../../../resources/resources.dart';
import '../bookings/bookings_view.dart';
import '../earnings/earnings_view.dart';

class SummaryWidget extends StatefulWidget {
  final index;

  SummaryWidget({super.key, this.index});

  @override
  State<SummaryWidget> createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {
  List<String> images = [
    R.images.earnings,
    R.images.bookings,
    R.images.rentals,
  ];

  List<String> names = [
    "Earnings",
    "Bookings",
    "Rentals",
  ];

  @override
  void initState() {
    var p = Provider.of<ProductProvider>(context, listen: false);
    p.getEarningRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.index == 0
            ? Get.to(() => EarningsView())
            : widget.index == 1
                ? Get.to(() => BookingsView())
                : Get.to(() => RentalsView());
      },
      child: Container(
        // height: FetchPixels.getPixelHeight(120),
        // width: FetchPixels.getPixelWidth(150),
        decoration: BoxDecoration(
            border: Border.all(color: R.colors.theme),
            color: R.colors.whiteColor,
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(8))),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          getAssetImage(
            images[widget.index],
            scale: FetchPixels.getPixelHeight(4),
          ),
          Text(
            names[widget.index],
            style: R.textStyle.mediumMetropolis().copyWith(
                  fontSize: FetchPixels.getPixelHeight(18),
                ),
          )
        ]),
      ),
    );
  }
}
