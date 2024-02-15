import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../resources/resources.dart';
import '../../../widgets/my_button.dart';
import '../../auth/provider/auth_provider.dart';
import '../dashboard_view.dart';
import '../home/provider/product_provider.dart';
import '../home/special_tailory/special_tailory_form.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage( {Key? key, required this.total, required this.payment_method, required this.timestamp}) : super(key: key);
  final String total;
  final String payment_method;
  final String timestamp;
  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.to(() => DashboardView(
                    index: 0,
                  ));
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
          centerTitle: true,
          title: Text(
            "Booking Confirmation",
            style: R.textStyle
                .semiBoldMetropolis()
                .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
          )),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          R.colors.whiteColor,
          R.colors.whiteColor,
          // R.colors.whiteColor,
          // R.colors.whiteColor,
          R.colors.whiteColor,
          R.colors.containerBG1
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: getPaddingWidget(
          EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(30)),
                Container(
                  child: getAssetImage(
                    boxFit: BoxFit.fill,
                    R.images.done,
                    scale: FetchPixels.getPixelHeight(3),
                  ),
                ),
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(30)),
            Text("Booking Payment Successful",
                textAlign: TextAlign.center,
                style: R.textStyle
                    .semiBoldMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(16))),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Text(
                "Your payment has been processed? Details of transaction are included below",
                textAlign: TextAlign.center,
                style: R.textStyle.regularMetropolis().copyWith(
                    color: R.colors.blackColor.withOpacity(0.5),
                    fontSize: FetchPixels.getPixelHeight(16))),
            getVerSpace(FetchPixels.getPixelHeight(30)),
            Container(
              decoration: BoxDecoration(
                  // color: R.colors.goldenColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16)),
              padding: EdgeInsets.all(16),
              width: double.maxFinite,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Amount Paid",
                          style: R.textStyle.mediumMetropolis().copyWith(
                              color: R.colors.blackColor.withOpacity(0.5),
                              fontSize: FetchPixels.getPixelHeight(14))),
                      Text("QR ${widget.total}.00",
                          style: R.textStyle.semiBoldMetropolis().copyWith(
                              color: R.colors.blackColor.withOpacity(0.5),
                              fontSize: FetchPixels.getPixelHeight(14))),
                    ],
                  ),
                  Divider(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Paid with",
                          style: R.textStyle.mediumMetropolis().copyWith(
                              color: R.colors.blackColor.withOpacity(0.5),
                              fontSize: FetchPixels.getPixelHeight(14))),
                      Text("${widget.payment_method}",
                          style: R.textStyle.semiBoldMetropolis().copyWith(
                              color: R.colors.blackColor.withOpacity(0.5),
                              fontSize: FetchPixels.getPixelHeight(14))),
                    ],
                  ),
                  Divider(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Transaction Date ",
                          style: R.textStyle.mediumMetropolis().copyWith(
                              color: R.colors.blackColor.withOpacity(0.5),
                              fontSize: FetchPixels.getPixelHeight(14))),
                      Text(DateTime.now().toString(),
                          style: R.textStyle.semiBoldMetropolis().copyWith(
                              color: R.colors.blackColor.withOpacity(0.5),
                              fontSize: FetchPixels.getPixelHeight(14))),
                    ],
                  ),
                  Divider(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Transaction Number",
                          style: R.textStyle.mediumMetropolis().copyWith(
                              color: R.colors.blackColor.withOpacity(0.5),
                              fontSize: FetchPixels.getPixelHeight(14))),
                      Text("${widget.timestamp}",
                          style: R.textStyle.semiBoldMetropolis().copyWith(
                              color: R.colors.blackColor.withOpacity(0.5),
                              fontSize: FetchPixels.getPixelHeight(14))),
                    ],
                  )
                ],
              ),
            ),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            MyButton(
                borderRadius: 50,
                onTap: () {
                  Get.to(DashboardView());
                },
                buttonText: "Okay")
          ]),
        ),
      ),
    );
  }


}
