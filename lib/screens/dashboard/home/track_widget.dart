import 'dart:developer';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/base/widget_utils.dart';
import 'package:hunt_and_rent/resources/resources.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/category_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/pages/my_order_history/widget/my_order_history.dart';
import 'package:provider/provider.dart';

import '../../auth/provider/auth_provider.dart';

class TrackOrder extends StatefulWidget {
  ProductModel? model;
  ProductProvider product;
  int index01;

  TrackOrder({Key? key, required this.index01, this.model, required  this.product}) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  //

  // List<StepperData> stepperData = [
  //   StepperData(
  //     title: StepperText("Order Placed",
  //         textStyle: R.textStyle.mediumMetropolis().copyWith(fontSize: 14)),
  //     subtitle: StepperText("Your order has been placed",
  //         textStyle: R.textStyle
  //             .regularMetropolis()
  //             .copyWith(fontSize: 12, color: R.colors.fillColor)),
  //     // iconWidget: Container(
  //     //   padding: const EdgeInsets.all(8),
  //     //   decoration: const BoxDecoration(
  //     //       color: Color(0xFF460D54),
  //     //       borderRadius: BorderRadius.all(Radius.circular(30))),
  //     //   child: const Icon(Icons.check, color: Colors.white),
  //     // ),
  //   ),
  //   StepperData(
  //       title: StepperText("Preparing",
  //           textStyle: R.textStyle.mediumMetropolis().copyWith(fontSize: 14)),
  //       subtitle: StepperText("Your order is being prepared",
  //           textStyle: R.textStyle
  //               .regularMetropolis()
  //               .copyWith(fontSize: 12, color: R.colors.fillColor)),
  //       iconWidget: Icon(Icons.check)
  //       // iconWidget: status >= 2
  //       //     ? Container(
  //       //         padding: const EdgeInsets.all(8),
  //       //         decoration: const BoxDecoration(
  //       //             color: Color(0xFF460D54),
  //       //             borderRadius: BorderRadius.all(Radius.circular(30))),
  //       //         child: const Icon(Icons.check, color: Colors.white),
  //       //       )
  //       //     : null,
  //       ),
  //   StepperData(
  //     title: StepperText("Out for Delivery",
  //         textStyle: R.textStyle.mediumMetropolis().copyWith(fontSize: 14)),
  //     subtitle: StepperText(
  //       "Our delivery executive is on the way to deliver your item",
  //       textStyle: R.textStyle
  //           .regularMetropolis()
  //           .copyWith(fontSize: 12, color: R.colors.fillColor),
  //     ),
  //     iconWidget: Container(
  //       padding: const EdgeInsets.all(8),
  //       decoration: const BoxDecoration(
  //           color: Color(0xFF460D54),
  //           borderRadius: BorderRadius.all(Radius.circular(30))),
  //       child: const Icon(Icons.check, color: Colors.white),
  //     ),
  //   ),
  //   StepperData(
  //     title: StepperText("Delivered",
  //         textStyle: R.textStyle.mediumMetropolis().copyWith(fontSize: 14)),
  //     subtitle: StepperText(
  //       "Order Delivered",
  //       textStyle: R.textStyle
  //           .regularMetropolis()
  //           .copyWith(fontSize: 12, color: R.colors.fillColor),
  //     ),
  //     // iconWidget: Container(
  //     //   padding: const EdgeInsets.all(8),
  //     //   decoration: const BoxDecoration(
  //     //       color: Color(0xFF460D54),
  //     //       borderRadius: BorderRadius.all(Radius.circular(30))),
  //     //   child: const Icon(Icons.check, color: Colors.white),
  //     // ),
  //   ),
  // ];

  var total = 0;
  static var status = 2;




//
  @override
  Widget build(BuildContext context) {
    total= int.parse(widget.model!.productPrice!);
    return Consumer<ProductProvider>(builder: (context, pro, _) {
      var activeStep = 1;
      if(widget.product.earningsList[widget.index01].orderStatus=='Active'){
        activeStep = 1;
      }else if(widget.product.earningsList[widget.index01].orderStatus=='Preparing'){
        activeStep = 2;
      }else if(widget.product.earningsList[widget.index01].orderStatus=='Out for Delivery'){
        activeStep = 3;
      }else if(widget.product.earningsList[widget.index01].orderStatus=='Delivered'){
        activeStep = 4;
      }else{
        activeStep = 4;
      }

      return Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    getHorSpace(FetchPixels.getPixelWidth(20)),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: FetchPixels.getPixelWidth(18),
                      ),
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(70)),
                    Text(
                      "Track Your Order",
                      style: R.textStyle.semiBoldMetropolis().copyWith(
                          color: R.colors.blackColor,
                          fontSize: FetchPixels.getPixelHeight(18)),
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(20)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MyOrderWidgets(
                    model: widget.model!,
                    index: widget.index01,
                  ),
                ),
                // this package come in handy for managing order.. please check !
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      getVerSpace(FetchPixels.getPixelWidth(10)),
                      // AnotherStepper(
                      //   // inverted: true,
                      //   activeIndex: 2,
                      //   activeBarColor: Color(0xFF460D54),
                      //   verticalGap: 20,
                      //   stepperList: stepperData,
                      //   stepperDirection: Axis.vertical,
                      //   iconWidth: 40,
                      //   // Height that will be applied to all the stepper icons
                      //   iconHeight:
                      //       40, // Width that will be applied to all the stepper icons
                      // ),
                      //
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            EasyStepper(
                              activeStep: activeStep,
                              stepShape: StepShape.circle,
                              stepRadius: 20,
                              finishedStepBackgroundColor: R.colors.theme,
                              activeStepBackgroundColor: R.colors.fillColor,
                              padding: EdgeInsets.only(right: 20),
                              showLoadingAnimation: true,
                              steppingEnabled: true,
                              fitWidth: true,
                              lineStyle: LineStyle(
                                lineThickness: 3,
                                defaultLineColor: R.colors.fillColor,
                                finishedLineColor: R.colors.theme,
                                lineType: LineType.normal,
                              ),
                              showTitle: false,
                              direction: Axis.vertical,
                              steps: [
                                EasyStep(
                                  icon: Icon(Icons.check),
                                ),
                                EasyStep(
                                  icon: Icon(Icons.check),
                                ),
                                EasyStep(
                                  icon: Icon(Icons.check),
                                ),
                                EasyStep(
                                  icon: Icon(Icons.check),
                                ),

                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Order Placed",
                                    style: R.textStyle.mediumMetropolis().copyWith(fontSize: 14)),
                                getVerSpace(FetchPixels.getPixelWidth(10)),
                                Text(
                                  "Your order has been placed",
                                  style: R.textStyle.regularMetropolis().copyWith(
                                      fontSize: 12, color: R.colors.fillColor),
                                ),
                                getVerSpace(FetchPixels.getPixelWidth(35)),
                                Text("Preparing",
                                    style: R.textStyle.mediumMetropolis().copyWith(fontSize: 14)),
                                getVerSpace(FetchPixels.getPixelWidth(10)),
                                Text(
                                  "Your order is being prepared",
                                  style: R.textStyle.regularMetropolis().copyWith(
                                      fontSize: 12, color: R.colors.fillColor),
                                ),
                                getVerSpace(FetchPixels.getPixelWidth(35)),
                                Text("Out for Delivery",
                                    style: R.textStyle.mediumMetropolis().copyWith(fontSize: 14)),
                                getVerSpace(FetchPixels.getPixelWidth(10)),
                                Text(
                                  "Our delivery executive is on the way to deliver your item",
                                  style: R.textStyle.regularMetropolis().copyWith(
                                      fontSize: 12, color: R.colors.fillColor),
                                ),
                                getVerSpace(FetchPixels.getPixelWidth(35)),
                                Text("Delivered",
                                    style: R.textStyle.mediumMetropolis().copyWith(fontSize: 14)),
                                getVerSpace(FetchPixels.getPixelWidth(10)),
                                Text(
                                  "Order Delivered",
                                  style: R.textStyle.regularMetropolis().copyWith(
                                      fontSize: 12, color: R.colors.fillColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      getVerSpace(FetchPixels.getPixelWidth(10)),
                      //
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Location",
                          style: R.textStyle.mediumMetropolis().copyWith(
                              color: R.colors.blackColor,
                              fontSize: FetchPixels.getPixelHeight(16)),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: getAssetImage(R.images.locationIcon,
                            scale: FetchPixels.getPixelHeight(3)),
                        title: Text(
                          "My Home Address",
                          style: R.textStyle.mediumMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(16)),
                        ),
                        subtitle: Text(
                          "${widget.product.earningsList[widget.index01].deliveryAddress}",
                          style: R.textStyle.regularMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(12)),
                        ),
                      ),
                      Column(
                        children: [
                          getHorSpace(FetchPixels.getPixelWidth(20)),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Payment Summary".toUpperCase(),
                              style: R.textStyle.mediumMetropolis().copyWith(
                                  color: R.colors.blackColor,
                                  fontSize: FetchPixels.getPixelHeight(16)),
                            ),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Basket Total",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                              Text(
                                "QR $total.00",
                                style: R.textStyle.mediumMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                            ],
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Fee",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                              Text(
                                "QR 10.00",
                                style: R.textStyle.mediumMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(15)),
                              ),
                            ],
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Dry Cleaning Fee",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                              Text(
                                "QR 5.00",
                                style: R.textStyle.mediumMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                            ],
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(15)),
                          DottedLine(
                            dashLength: 10,
                            lineThickness: 2,
                            dashColor: R.colors.fillColor,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: FetchPixels.getPixelWidth(10)),
                            height: FetchPixels.getPixelHeight(50),
                            width: FetchPixels.width,
                            decoration: BoxDecoration(
                                color: R.colors.whiteColor,
                                borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(5))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Amount",
                                    style: R.textStyle
                                        .mediumMetropolis()
                                        .copyWith(
                                            fontSize:
                                                FetchPixels.getPixelHeight(16)),
                                  ),
                                  Text(
                                    "QR ${total + 15}.00",
                                    style: R.textStyle
                                        .mediumMetropolis()
                                        .copyWith(
                                            color: R.colors.theme,
                                            fontSize:
                                                FetchPixels.getPixelHeight(17)),
                                  ),
                                ]),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                //

                // Row(

                getVerSpace(FetchPixels.getPixelWidth(20)),

                getVerSpace(FetchPixels.getPixelWidth(20)),
              ],
            )
          ],
        ),
      );
    });
  }
}
