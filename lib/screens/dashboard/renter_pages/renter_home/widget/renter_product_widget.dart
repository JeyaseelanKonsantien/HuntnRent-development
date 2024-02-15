import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/base/widget_utils.dart';
import 'package:hunt_and_rent/screens/dashboard/cart/model/cart_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/widgets/product_detail_page.dart';

import '../../../../../resources/resources.dart';
import '../../../home/widgets/rental_order_detail_page.dart';

class RenterProductWidget extends StatelessWidget {
  final ProductModel model;

  const RenterProductWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetails(
              model: model,
              isCart: true,
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(5)),
        padding: EdgeInsets.all(FetchPixels.getPixelHeight(10)),
        decoration: BoxDecoration(
            color: R.colors.containerBG,
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(16))),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: FetchPixels.getPixelHeight(200),
            width: FetchPixels.getPixelWidth(150),
            decoration: BoxDecoration(
                image: getDecorationNetworkImage(
                    context, model.productImage!.first, fit: BoxFit.cover),
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(10))),
          ),
          getHorSpace(FetchPixels.getPixelWidth(10)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: FetchPixels.getPixelHeight(30),
                ),
                Text(
                  model.productName ?? "",
                  style: R.textStyle
                      .semiBoldMetropolis()
                      .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                ),



                getVerSpace(FetchPixels.getPixelHeight(5)),
                Container(
                  padding: EdgeInsets.all(FetchPixels.getPixelHeight(5)),
                  decoration: BoxDecoration(
                      color: R.colors.whiteColor,
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(4))),
                  child: Text("Customer Name"),
                ),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                Row(
                  children: [
                    getAssetImage(R.images.clock,
                        scale: FetchPixels.getPixelHeight(6)),
                    getHorSpace(FetchPixels.getPixelWidth(10)),
                    Text(
                      "1 Day",
                      style: R.textStyle
                          .mediumMetropolis()
                          .copyWith(fontSize: FetchPixels.getPixelHeight(12)),
                    ),
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Retail Price:",
                          style: R.textStyle.mediumMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(13)),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(5)),
                        Text(
                          "\QR ${model.productPrice ?? ""}",
                          style: R.textStyle.mediumMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(13)),
                        ),
                      ],
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(20)),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       "Rental Price:",
                    //       style: R.textStyle
                    //           .mediumMetropolis()
                    //           .copyWith(fontSize: FetchPixels.getPixelHeight(13)),
                    //     ),
                    //     getVerSpace(FetchPixels.getPixelHeight(5)),
                    //     Text(
                    //       "\$85.00",
                    //       style: R.textStyle
                    //           .mediumMetropolis()
                    //           .copyWith(fontSize: FetchPixels.getPixelHeight(13)),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                Row(
                  children: [
                    getAssetImage(R.images.star,
                        scale: FetchPixels.getPixelHeight(3.5)),
                    getHorSpace(FetchPixels.getPixelWidth(10)),
                    Text(
                      "4.4",
                      style: R.textStyle
                          .mediumMetropolis()
                          .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: FetchPixels.getPixelHeight(30),
            width: FetchPixels.getPixelWidth(60),
            decoration: BoxDecoration(
                color: R.colors.whiteColor,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(10))),
            child: Center(
              child: Text(
                model.productType ?? "",
                style: R.textStyle
                    .mediumMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class RenterProductWidget1 extends StatelessWidget {
  final CartModel model;
  final ProductModel product;

  const RenterProductWidget1({super.key, required this.model, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => RentalOrderDetails(
          product: product,
              model: model,
              isCart: true,
            ));
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: R.colors.containerBG),
            color: R.colors.whiteColor.withOpacity(0.5)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                height: FetchPixels.getPixelHeight(180),
                decoration: BoxDecoration(
                    image: getDecorationNetworkImage(
                        context, product.productImage!.first, fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      Text(
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        product.productName ?? "",
                        style: R.textStyle
                            .mediumMetropolis()
                            .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      Row(
                        children: [
                          getAssetImage(R.images.clock,
                              scale: FetchPixels.getPixelHeight(6)),
                          getHorSpace(FetchPixels.getPixelWidth(10)),
                          Text(
                            "${(model.endDate?.toDate().difference(model.startDate!.toDate()).inDays)!+1} days",
                            style: R.textStyle.regularMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(12)),
                          ),
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      // Row(
                      //   children: [
                      //     getAssetImage(R.images.star,
                      //         scale: FetchPixels.getPixelHeight(3.5)),
                      //     getHorSpace(FetchPixels.getPixelWidth(10)),
                      //     Text(
                      //       "4.4",
                      //       style: R.textStyle.regularMetropolis().copyWith(
                      //           fontSize: FetchPixels.getPixelHeight(12)),
                      //     ),
                      //   ],
                      // ),
                      //
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      Container(
                        decoration: BoxDecoration(
                            color: R.colors.whiteColor,
                            borderRadius: BorderRadius.circular(
                                FetchPixels.getPixelHeight(4))),
                        child: Text(
                          "${model.customerName}",
                          style: R.textStyle.regularMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(14)),
                        ),
                      ),
                      // getVerSpace(FetchPixels.getPixelHeight(5)),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Retail Price:",
                      //       style: R.textStyle.mediumMetropolis().copyWith(
                      //           fontSize: FetchPixels.getPixelHeight(13)),
                      //     ),
                      //     getHorSpace(FetchPixels.getPixelWidth(10)),
                      //     Text(
                      //       "\QR ${model.productPrice ?? ""}",
                      //       style: R.textStyle.mediumMetropolis().copyWith(
                      //           fontSize: FetchPixels.getPixelHeight(13)),
                      //     ),
                      //     // Column(
                      //     //   crossAxisAlignment: CrossAxisAlignment.start,
                      //     //   children: [
                      //     //     Text(
                      //     //       "Rental Price:",
                      //     //       style: R.textStyle
                      //     //           .mediumMetropolis()
                      //     //           .copyWith(fontSize: FetchPixels.getPixelHeight(13)),
                      //     //     ),
                      //     //     getVerSpace(FetchPixels.getPixelHeight(5)),
                      //     //     Text(
                      //     //       "\$85.00",
                      //     //       style: R.textStyle
                      //     //           .mediumMetropolis()
                      //     //           .copyWith(fontSize: FetchPixels.getPixelHeight(13)),
                      //     //     ),
                      //     //   ],
                      //     // ),
                      //   ],
                      // ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: R.colors.theme),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Total Price:",
                        style: R.textStyle.mediumMetropolis().copyWith(
                            color: R.colors.whiteColor,
                            fontSize: FetchPixels.getPixelHeight(13)),
                      ),
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(10)),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "\QR ${model.productPrice ?? ""}",
                        style: R.textStyle.mediumMetropolis().copyWith(
                            color: R.colors.whiteColor,
                            fontSize: FetchPixels.getPixelHeight(14)),
                      ),
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
