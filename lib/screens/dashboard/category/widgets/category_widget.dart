import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/widgets/product_detail_page.dart';
import 'package:provider/provider.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';
import '../../home/model/product_model.dart';
import '../../home/special_tailory/special_tailory_form.dart';

class CateWidget extends StatelessWidget {
  final bool isSpecial;
  final ProductModel model;
  final int index;

  CateWidget(
      {super.key,
      required this.model,
      required this.isSpecial,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProductProvider>(
      builder: (context, auth, pro, child) {
        return InkWell(
          onTap: () {
            isSpecial
                ? Get.to(() => SpecialTailoryForm(
                      productModel: model,
                    ))
                : Get.to(() => ProductDetails(model: model));
          },
          child: Container(
            width: FetchPixels.getPixelWidth(160),
            height: FetchPixels.getPixelHeight(240),

            // padding: EdgeInsets.all(FetchPixels.getPixelHeight(10)),
            // margin: EdgeInsets.symmetric(
            //   vertical: FetchPixels.getPixelHeight(5),
            // ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: R.colors.containerBG1),
                color: R.colors.whiteColor.withOpacity(0.5)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: FetchPixels.getPixelHeight(250),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                              color: R.colors.blackColor),
                          child: getNetworkImage(model.productImage!.first,
                              height: FetchPixels.getPixelHeight(
                                  auth.isClicked ? 250 : 250),
                              width: FetchPixels.width,
                              boxFit: BoxFit.cover),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () async {
                                auth.userModel.favrt!.contains(model.docId)
                                    ? auth.userModel.favrt!.remove(model.docId)
                                    : auth.userModel.favrt!.add(model.docId);
                                await auth.updateUser(auth.userModel);
                                auth.update();
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: R.colors.whiteColor,
                                    shape: BoxShape.circle),
                                child: getPaddingWidget(
                                  EdgeInsets.symmetric(
                                      horizontal: FetchPixels.getPixelWidth(5),
                                      vertical: FetchPixels.getPixelHeight(5)),
                                  getAssetImage(
                                      height: FetchPixels.getPixelHeight(15),
                                      boxFit: BoxFit.cover,
                                      auth.userModel.favrt!
                                              .contains(model.docId)
                                          ? R.images.fav
                                          : R.images.fav1,
                                      color: auth.userModel.favrt!
                                              .contains(model.docId)
                                          ? R.colors.theme
                                          : R.colors.theme,
                                      scale: FetchPixels.getPixelHeight(
                                          auth.isClicked == true ? 7 : 5.5)),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  getVerSpace(FetchPixels.getPixelWidth(10)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getHorSpace(FetchPixels.getPixelWidth(10)),
                      Expanded(
                        child: Text(
                          model.productName ?? "not found",
                          style: R.textStyle.semiBoldMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(14),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelWidth(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getHorSpace(FetchPixels.getPixelWidth(10)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: model.productType == "custom"
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              "QR ${model.productPrice!}",
                              style: R.textStyle.semiBoldMetropolis().copyWith(
                                    color: R.colors.g1,
                                    fontSize: FetchPixels.getPixelHeight(16),
                                  ),
                            )
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //           "SIZE ${replaceShortLetters(model.productSize)}",
                      //           style: R.textStyle
                      //               .semiBoldMetropolis()
                      //               .copyWith(
                      //                   color: Colors.grey,
                      //                   fontSize:
                      //                       FetchPixels.getPixelHeight(12)))
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelWidth(10)),
                ]),
          ),
        );
      },
    );
  }
}

String? replaceShortLetters(List<dynamic>? sizes) {
  Map<String, String> sizeMapping = {
    'Small': 'S',
    'Medium': 'M',
    'Large': 'L',
    'Extra Large': 'XL',
    // Add more mappings as needed
  };

  String? sizeText = sizes?.map((size) {
    if (size is String) {
      for (var shortLetter in sizeMapping.keys) {
        // Replace short letters when they are standalone words
        if (size == shortLetter) {
          return sizeMapping[shortLetter];
        }
      }
      return size;
    }
    return size?.toString() ??
        ''; // Handle null or non-string values with the null-safe operator
  }).join(", ");

  return sizeText;
}

class CateWidget1 extends StatelessWidget {
  final bool isSpecial;
  final ProductModel model;
  final int index;

  CateWidget1(
      {super.key,
      required this.model,
      required this.isSpecial,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return InkWell(
          onTap: () {
            isSpecial
                ? Get.to(() => SpecialTailoryForm(
                      productModel: model,
                    ))
                : Get.to(() => ProductDetails(model: model));
          },
          child: Container(
            width: FetchPixels.getPixelWidth(160),
            // height: FetchPixels.getPixelHeight(100),

            padding: EdgeInsets.all(FetchPixels.getPixelHeight(10)),
            margin: EdgeInsets.symmetric(
              vertical: FetchPixels.getPixelHeight(5),
            ),
            // width: FetchPixels.getPixelWidth(auth.isClicked?120: 160),
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(50),
                color: R.colors.containerBG),
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: R.colors.blackColor),
                          child: getNetworkImage(
                            model.productImage!.first,
                            boxFit: BoxFit.cover,
                            height: FetchPixels.getPixelHeight(
                                auth.isClicked ? 100 : 160),
                            width: FetchPixels.width,
                          ),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () async {
                                auth.userModel.favrt!.contains(model.docId)
                                    ? auth.userModel.favrt!.remove(model.docId)
                                    : auth.userModel.favrt!.add(model.docId);
                                await auth.updateUser(auth.userModel);
                                // if (auth.userModel.favrt.add(e)) {
                                //   auth.favrtProducts.remove(index);
                                // } else {
                                //   auth.favrtProducts.add(index);
                                // }
                                auth.update();
                              },
                              child: getPaddingWidget(
                                EdgeInsets.symmetric(
                                    horizontal: FetchPixels.getPixelWidth(10),
                                    vertical: FetchPixels.getPixelHeight(10)),
                                getAssetImage(R.images.fav,
                                    color: auth.userModel.favrt!
                                            .contains(model.docId)
                                        ? R.colors.redColor
                                        : R.colors.whiteColor,
                                    scale: FetchPixels.getPixelHeight(
                                        auth.isClicked == true ? 7 : 5.5)),
                              ),
                            )),
                      ],
                    ),
                  ),
                  getVerSpace(FetchPixels.getPixelWidth(5)),
                  Text(model.productName ?? "not found",
                      style: R.textStyle
                          .semiBoldMetropolis()
                          .copyWith(fontSize: FetchPixels.getPixelHeight(15))),
                  getVerSpace(FetchPixels.getPixelWidth(5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Container(
                      //   padding: EdgeInsets.symmetric(
                      //       vertical:
                      //       FetchPixels.getPixelHeight(auth.isClicked ? 2 : 5),
                      //       horizontal:
                      //       FetchPixels.getPixelWidth(auth.isClicked ? 2 : 5)),
                      //   decoration: BoxDecoration(
                      //       color: R.colors.whiteColor,
                      //       borderRadius: BorderRadius.circular(
                      //           FetchPixels.getPixelHeight(5))),
                      //   child: Row(children: [
                      //     Text(
                      //       "6x",
                      //       style: R.textStyle.mediumMetropolis().copyWith(
                      //           fontSize: FetchPixels.getPixelHeight(
                      //               auth.isClicked ? 6 : 10)),
                      //     ),
                      //     getHorSpace(
                      //         FetchPixels.getPixelWidth(auth.isClicked ? 1 : 5)),
                      //     Text(
                      //       isSpecial ? "Sold" : "Rented",
                      //       style: R.textStyle.mediumMetropolis().copyWith(
                      //           fontSize: FetchPixels.getPixelHeight(
                      //               auth.isClicked ? 6 : 10)),
                      //     ),
                      //   ]),
                      // ),
                      // getHorSpace(
                      //     FetchPixels.getPixelWidth(auth.isClicked ? 1 : 10)),
                      // getAssetImage(R.images.star,
                      //     scale:
                      //     FetchPixels.getPixelWidth(auth.isClicked ? 6 : 4.5)),
                      // Text.rich(
                      //     textAlign: TextAlign.center,
                      //     TextSpan(children: [
                      //       TextSpan(
                      //           text: "4.4",
                      //           style: R.textStyle.mediumMetropolis().copyWith(
                      //               fontSize: FetchPixels.getPixelHeight(
                      //                   auth.isClicked ? 6 : 8))),
                      //       TextSpan(
                      //           text: "(5 reviews)",
                      //           style: R.textStyle.regularMetropolis().copyWith(
                      //               fontSize: FetchPixels.getPixelHeight(
                      //                   auth.isClicked ? 6 : 8))),
                      //     ])),
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelWidth(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Retail\nPrice",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14))),
                            getVerSpace(FetchPixels.getPixelWidth(5)),
                            Text("QR${model.productPrice!}",
                                style: R.textStyle
                                    .semiBoldMetropolis()
                                    .copyWith(
                                        fontSize:
                                            FetchPixels.getPixelHeight(12)))
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
                  )
                ]),
          ),
        );
      },
    );
  }
}
