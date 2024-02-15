import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/widgets/product_detail_page.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';
import 'package:provider/provider.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';

class FeaturedWidget extends StatelessWidget {
  final ProductModel model;
  final bool isCart;
  final bool isOrderHistory;
  int? index1;

  FeaturedWidget(
      {super.key,
      required this.model,
      required this.isCart,
      this.index1,
      this.isOrderHistory = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return InkWell(
          onTap: () {
            Get.to(() => ProductDetails(
                  model: model,
                  isCart: null,
                ));
          },
          child: Container(
            padding: EdgeInsets.all(FetchPixels.getPixelHeight(10)),
            margin:
                EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(1)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: R.colors.transparent),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: FetchPixels.getPixelHeight(170),
                  width: FetchPixels.getPixelWidth(130),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(10)),
                      image: getDecorationNetworkImage(
                          context, model.productImage!.first,
                          fit: BoxFit.cover),
                      color: R.colors.blackColor),
                ),
                getHorSpace(FetchPixels.getPixelWidth(15)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // getVerSpace(FetchPixels.getPixelHeight(15)),
                      Text(model.productName!,
                          style: R.textStyle.mediumMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(16))),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Container(
                          //   padding: EdgeInsets.symmetric(
                          //       vertical: FetchPixels.getPixelHeight(5),
                          //       horizontal: FetchPixels.getPixelWidth(10)),
                          //   decoration: BoxDecoration(
                          //       color: R.colors.containerBG,
                          //       borderRadius: BorderRadius.circular(
                          //           FetchPixels.getPixelHeight(5))),
                          //   child: Row(children: [
                          //     model.productType == "custom"
                          //         ? SizedBox()
                          //         : Text(
                          //             "6x",
                          //             style: R.textStyle
                          //                 .mediumMetropolis()
                          //                 .copyWith(
                          //                     fontSize:
                          //                         FetchPixels.getPixelHeight(
                          //                             12)),
                          //           ),
                          //     model.productType == "custom"
                          //         ? SizedBox()
                          //         : getHorSpace(FetchPixels.getPixelWidth(20)),
                          //     Text(
                          //       model.productType == "custom"
                          //           ? model.productType ?? ""
                          //           : "Rented",
                          //       style: R.textStyle.mediumMetropolis().copyWith(
                          //           fontSize: FetchPixels.getPixelHeight(12)),
                          //     ),
                          //   ]),
                          // ),
                          // getHorSpace(FetchPixels.getPixelWidth(10)),
                          getAssetImage(R.images.star,
                              scale: FetchPixels.getPixelWidth(3)),
                          getHorSpace(FetchPixels.getPixelWidth(5)),
                          Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(children: [
                                TextSpan(
                                    text: "4.4",
                                    style: R.textStyle
                                        .mediumMetropolis()
                                        .copyWith(
                                            color: R.colors.blackColor
                                                .withOpacity(0.7),
                                            fontSize:
                                                FetchPixels.getPixelHeight(
                                                    14))),
                                TextSpan(
                                    text: "(5)",
                                    style:
                                        R.textStyle
                                            .regularMetropolis()
                                            .copyWith(
                                                color: R.colors.blackColor
                                                    .withOpacity(0.6),
                                                fontSize:
                                                    FetchPixels.getPixelHeight(
                                                        14))),
                              ])),
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: model.productType == "custom"
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.start,
                              children: [
                                model.productType == "custom"
                                    ? Text("Retail Price",
                                        style: R.textStyle
                                            .regularMetropolis()
                                            .copyWith(
                                                fontSize:
                                                    FetchPixels.getPixelHeight(
                                                        12)))
                                    : Text("Rental Price",
                                        style: R.textStyle
                                            .regularMetropolis()
                                            .copyWith(
                                                fontSize:
                                                    FetchPixels.getPixelHeight(
                                                        12))),
                                getVerSpace(FetchPixels.getPixelWidth(5)),
                                Text("QR ${model.productPrice!}",
                                    style: R.textStyle
                                        .semiBoldMetropolis()
                                        .copyWith(
                                            color: R.colors.theme,
                                            fontSize:
                                                FetchPixels.getPixelHeight(16)))
                              ],
                            ),
                          ),
                          // Expanded( flex: 1,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //     Text("Rental\nPrice",
                          //         style: R.textStyle
                          //             .regularMetropolis()
                          //             .copyWith(fontSize: FetchPixels.getPixelHeight(10))),
                          //     getVerSpace(FetchPixels.getPixelWidth(5)),
                          //     Text("QR${model.productPrice!}",
                          //         style: R.textStyle
                          //             .semiBoldMetropolis()
                          //             .copyWith(fontSize: FetchPixels.getPixelHeight(9)))
                          //   ],),
                          // ),
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyButton(
                            borderRadius: 10,
                            textColor: R.colors.whiteColor,
                            color: R.colors.theme,
                            textSize: FetchPixels.getPixelHeight(14),
                            width: FetchPixels.getPixelWidth(150),
                            height: FetchPixels.getPixelHeight(35),
                            onTap: () {
                              if (isCart == false &&
                                  auth.userModel.cart!.contains(model.docId)) {
                                auth.userModel.cart!.remove(model.docId);
                                auth.updateUser(auth.userModel);
                                auth.update();
                              }
                            },
                            buttonText: auth.userModel.cart!.contains(model)
                                ? "Remove"
                                : "Add To Card"),
                      ),
                    ],
                  ),
                ),
                auth.isLoading
                    ? CircularProgressIndicator(
                        color: R.colors.theme,
                      )
                    : InkWell(
                        onTap: () async {
                          auth.userModel.favrt!.contains(model.docId)
                              ? auth.userModel.favrt!.remove(model.docId)
                              : auth.userModel.favrt!.add(model.docId);
                          await auth.updateUser(auth.userModel);
                          auth.update();
                        },
                        // onTap: () async {
                        //   if (isCart == true) {
                        //     auth.userModel.cart!.removeAt(index1!);
                        //     print("This: ${auth.userModel.cart!.length}");
                        //     await auth.updateUser(auth.userModel);
                        //   } else {
                        //     print("Enter in Else");
                        //     auth.userModel.favrt!.contains(model.docId)
                        //         ? auth.userModel.favrt!.remove(model.docId)
                        //         : auth.userModel.favrt!.add(model.docId);
                        //     await auth.updateUser(auth.userModel);
                        //   }
                        //   Get.snackbar(
                        //       backgroundColor: R.colors.whiteColor,
                        //       " ",
                        //       icon: Icon(
                        //         Icons.check_circle,
                        //         color: Colors.green,
                        //       ),
                        //       "Your Item is Successfully removed");
                        //   auth.update();
                        // },
                        child: Icon(
                          Icons.cancel,
                          color: R.colors.fillColor,
                        )),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FeaturedWidget1 extends StatelessWidget {
  final ProductModel model;
  final bool isCart;
  final bool isOrderHistory;
  int? index1;

  FeaturedWidget1(
      {super.key,
      required this.model,
      required this.isCart,
      this.index1,
      this.isOrderHistory = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return InkWell(
          onTap: () {
            Get.to(() => ProductDetails(
                  model: model,
                  isCart: true,
                ));
          },
          child: Container(
            padding: EdgeInsets.all(FetchPixels.getPixelHeight(10)),
            margin:
                EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(1)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: R.colors.transparent),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: FetchPixels.getPixelHeight(140),
                  width: FetchPixels.getPixelWidth(130),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(10)),
                      image: getDecorationNetworkImage(
                          context, model.productImage!.first,
                          fit: BoxFit.cover),
                      color: R.colors.blackColor),
                ),
                getHorSpace(FetchPixels.getPixelWidth(15)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // getVerSpace(FetchPixels.getPixelHeight(15)),
                      Text(model.productName!,
                          style: R.textStyle.mediumMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(16))),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Container(
                          //   padding: EdgeInsets.symmetric(
                          //       vertical: FetchPixels.getPixelHeight(5),
                          //       horizontal: FetchPixels.getPixelWidth(10)),
                          //   decoration: BoxDecoration(
                          //       color: R.colors.containerBG,
                          //       borderRadius: BorderRadius.circular(
                          //           FetchPixels.getPixelHeight(5))),
                          //   child: Row(children: [
                          //     model.productType == "sell"
                          //         ? SizedBox()
                          //         : Text(
                          //             "6x",
                          //             style: R.textStyle
                          //                 .mediumMetropolis()
                          //                 .copyWith(
                          //                     fontSize:
                          //                         FetchPixels.getPixelHeight(
                          //                             12)),
                          //           ),
                          //     model.productType == "sell"
                          //         ? SizedBox()
                          //         : getHorSpace(FetchPixels.getPixelWidth(20)),
                          //     Text(
                          //       model.productType == "sell"
                          //           ? model.productType ?? ""
                          //           : "Rented",
                          //       style: R.textStyle.mediumMetropolis().copyWith(
                          //           fontSize: FetchPixels.getPixelHeight(12)),
                          //     ),
                          //   ]),
                          // ),
                          // getHorSpace(FetchPixels.getPixelWidth(10)),
                          getAssetImage(R.images.star,
                              scale: FetchPixels.getPixelWidth(3)),
                          getHorSpace(FetchPixels.getPixelWidth(5)),
                          Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(children: [
                                TextSpan(
                                    text: "4.4",
                                    style: R.textStyle
                                        .mediumMetropolis()
                                        .copyWith(
                                            color: R.colors.blackColor
                                                .withOpacity(0.7),
                                            fontSize:
                                                FetchPixels.getPixelHeight(
                                                    14))),
                                TextSpan(
                                    text: "(5)",
                                    style:
                                        R.textStyle
                                            .regularMetropolis()
                                            .copyWith(
                                                color: R.colors.blackColor
                                                    .withOpacity(0.6),
                                                fontSize:
                                                    FetchPixels.getPixelHeight(
                                                        14))),
                              ])),
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: model.productType == "custom"
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.start,
                              children: [
                                model.productType == "custom"
                                    ? Text("Retail Price",
                                        style: R.textStyle
                                            .regularMetropolis()
                                            .copyWith(
                                                fontSize:
                                                    FetchPixels.getPixelHeight(
                                                        12)))
                                    : Text("Rental Price",
                                        style: R.textStyle
                                            .regularMetropolis()
                                            .copyWith(
                                                fontSize:
                                                    FetchPixels.getPixelHeight(
                                                        12))),
                                getVerSpace(FetchPixels.getPixelWidth(5)),
                                Text("QR ${model.productPrice!}",
                                    style: R.textStyle
                                        .semiBoldMetropolis()
                                        .copyWith(
                                            color: R.colors.theme,
                                            fontSize:
                                                FetchPixels.getPixelHeight(16)))
                              ],
                            ),
                          ),
                          // Expanded( flex: 1,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //     Text("Rental\nPrice",
                          //         style: R.textStyle
                          //             .regularMetropolis()
                          //             .copyWith(fontSize: FetchPixels.getPixelHeight(10))),
                          //     getVerSpace(FetchPixels.getPixelWidth(5)),
                          //     Text("QR${model.productPrice!}",
                          //         style: R.textStyle
                          //             .semiBoldMetropolis()
                          //             .copyWith(fontSize: FetchPixels.getPixelHeight(9)))
                          //   ],),
                          // ),
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: MyButton(
                      //       borderRadius: 10,
                      //       textColor: R.colors.whiteColor,
                      //       color: R.colors.theme,
                      //       textSize: FetchPixels.getPixelHeight(14),
                      //       width: FetchPixels.getPixelWidth(150),
                      //       height: FetchPixels.getPixelHeight(35),
                      //       onTap: () {
                      //         if (isCart == false &&
                      //             auth.userModel.cart!.contains(model.docId)) {
                      //           auth.userModel.cart!.remove(model.docId);
                      //           auth.updateUser(auth.userModel);
                      //           auth.update();
                      //         }
                      //       },
                      //       buttonText: auth.userModel.cart!.contains(model)
                      //           ? "Remove"
                      //           : "Add To Card"),
                      // ),
                    ],
                  ),
                ),
                auth.isLoading
                    ? CircularProgressIndicator(
                        color: R.colors.theme,
                      )
                    : InkWell(
                        onTap: () async {
                          if (isCart == true) {
                            auth.userModel.cart!.removeAt(index1!);
                            print("This: ${auth.userModel.cart!.length}");
                            await auth.updateUser(auth.userModel);
                          } else {
                            print("Enter in Else");
                            auth.userModel.favrt!.contains(model.docId)
                                ? auth.userModel.favrt!.remove(model.docId)
                                : auth.userModel.favrt!.add(model.docId);
                            await auth.updateUser(auth.userModel);
                          }
                          Get.snackbar(
                              backgroundColor: R.colors.whiteColor,
                              " ",
                              icon: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              "Your Item is Successfully removed");
                          // auth.update();
                        },
                        child: Icon(
                          Icons.cancel,
                          color: R.colors.fillColor,
                        )),
              ],
            ),
          ),
        );
      },
    );
  }
}
