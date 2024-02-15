import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/category_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/widgets/product_detail_page.dart';
import 'package:provider/provider.dart';

import '../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../base/widget_utils.dart';
import '../../../../../resources/resources.dart';
import '../../../../../widgets/my_button.dart';
import '../../../home/model/product_model.dart';
import '../add_product_form.dart';
import '../edit_product_form.dart';

class CollectionWidget extends StatelessWidget {
  final ProductModel model;
  int? index;

  CollectionWidget({super.key, required this.model, this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, pro, _) {
      return InkWell(
        onTap: () {
          model.status=='pending'?
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              width: FetchPixels.width,
              height: FetchPixels.getPixelHeight(350),
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Text(
                    "Approval Status",
                    style: R.textStyle.semiBoldMetropolis().copyWith(
                        fontSize: FetchPixels.getPixelHeight(18)),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "Admin Review: ",
                      style: R.textStyle.regularMetropolis().copyWith(
                          fontSize: FetchPixels.getPixelHeight(14)),
                    ),
                    TextSpan(
                      text:
                      model.admin_review!=''?"${model.admin_review}":"No Reviews Yet",
                      style: R.textStyle.regularMetropolis().copyWith(
                          fontSize: FetchPixels.getPixelHeight(14), color: R.colors.goldenColor),
                    ),
                  ])),
                  Spacer(),
                  Center(
                    child:   ElevatedButton(

                      onPressed: () async {
                        Navigator.pop(context);
                        Get.to(() => EditProductForm(model:model));

                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(R.colors.theme1), // Change the color here
                      ),
                      child: Text('Edit Listing', style: TextStyle(color: R.colors.whiteColor),),
                    ),
                  )

                ],
              ),
            ),

          ):
          Get.to(() => ProductDetails(
                model: model,
                isCart: true,
              ));

                 
        },
        child: Container(

          padding: EdgeInsets.all(FetchPixels.getPixelHeight(10)),
          margin: EdgeInsets.symmetric(
              horizontal: FetchPixels.getPixelHeight(10),
              vertical: FetchPixels.getPixelHeight(10)),
          // height: FetchPixels.getPixelHeight(200),

          decoration: BoxDecoration(
              border: Border.all(color: R.colors.fillColor),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(16)),
              color: R.colors.containerBG1.withOpacity(0.7)),
          child: Row(children: [
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
            getHorSpace(FetchPixels.getPixelWidth(20)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(model.productName ?? "",
                            style: R.textStyle.mediumMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(16))),
                      ),
                      // getHorSpace(10),
                      // Container(
                      //   height: FetchPixels.getPixelHeight(30),
                      //   width: FetchPixels.getPixelWidth(60),
                      //   decoration: BoxDecoration(
                      //       color: R.colors.containerBG,
                      //       borderRadius: BorderRadius.circular(
                      //           FetchPixels.getPixelHeight(10))),
                      //   child: Center(
                      //     child: Text(
                      //       model.productType ?? "",
                      //       style: R.textStyle.mediumMetropolis().copyWith(
                      //           fontSize: FetchPixels.getPixelHeight(14)),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(5)),
                  // Row(
                  //   // crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Retail Price: ",
                  //       style: R.textStyle.semiBoldMetropolis().copyWith(
                  //           color: R.colors.blackColor.withOpacity(0.6),
                  //           fontSize: FetchPixels.getPixelHeight(10)),
                  //     ),
                  //     getHorSpace(FetchPixels.getPixelHeight(10)),
                  //     Text(
                  //       "\QR ${model.productPrice ?? ""}",
                  //       style: R.textStyle.semiBoldMetropolis().copyWith(
                  //           color: R.colors.blackColor.withOpacity(0.6),
                  //           fontSize: FetchPixels.getPixelHeight(12)),
                  //     ),
                  //   ],
                  // ),
                  getVerSpace(FetchPixels.getPixelHeight(5)),

                  model.productType == ProductsTypes.rent.name ||
                          model.productType == ProductsTypes.rented.name
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Icon(
                                  //   Icons.star,
                                  //   size: 16,
                                  //   color: R.colors.goldenColor,
                                  // ),
                                  // Text(
                                  //   "  4.4",
                                  //   style: R.textStyle
                                  //       .regularMetropolis()
                                  //       .copyWith(
                                  //           color: R.colors.blackColor,
                                  //           fontSize:
                                  //               FetchPixels.getPixelHeight(12)),
                                  // ),
                                  // Text(
                                  //   "(5)  - ",
                                  //   style: R.textStyle
                                  //       .regularMetropolis()
                                  //       .copyWith(
                                  //           color: R.colors.blackColor,
                                  //           fontSize:
                                  //               FetchPixels.getPixelHeight(12)),
                                  // ),

                                  Text(
                                    "${pro.earningsList.where((element) => element.productId == model.docId).length}x",
                                    style: R.textStyle
                                        .mediumMetropolis()
                                        .copyWith(
                                            color: R.colors.g1,
                                            fontSize:
                                                FetchPixels.getPixelHeight(12)),
                                  ),
                                  Text(
                                    " Rented",
                                    style: R.textStyle
                                        .mediumMetropolis()
                                        .copyWith(
                                            color: R.colors.g1,
                                            fontSize:
                                                FetchPixels.getPixelHeight(12)),
                                  ),
                                  // Text(
                                  //   "\QAR ${model.productPrice ?? ""}",
                                  //   style: R.textStyle
                                  //       .mediumMetropolis()
                                  //       .copyWith(
                                  //           fontSize:
                                  //               FetchPixels.getPixelHeight(13)),
                                  // ),

                                ]),
                            // getHorSpace(FetchPixels.getPixelWidth(10)),
                            // getVerSpace(FetchPixels.getPixelHeight(10)),
                          ],
                        )
                      : SizedBox(),
                  // getVerSpace(FetchPixels.getPixelHeight(10)),
                  getVerSpace(FetchPixels.getPixelHeight(5)),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rental Price  ",
                        style: R.textStyle.semiBoldMetropolis().copyWith(
                            color: R.colors.blackColor.withOpacity(0.7),
                            fontSize: FetchPixels.getPixelHeight(10)),
                      ),
                      getHorSpace(FetchPixels.getPixelHeight(10)),
                      Text(
                        "\QAR ${model.productPrice ?? ""}",
                        style: R.textStyle.semiBoldMetropolis().copyWith(
                            color: R.colors.theme,
                            fontSize: FetchPixels.getPixelHeight(14)),
                      ),
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  //     MyButton(
                  //       textSize: 12,
                  //       borderRadius: 10,
                  //       height: FetchPixels.getPixelWidth(30),
                  //       width: FetchPixels.getPixelWidth(150),
                  //       onTap: () {
                  //         Get.to(() => AddProductForm());
                  //       },
                  //       buttonText: "GET FEATURED NOW",
                  //     ),
                      model.status=='pending'?
                      Container(
                        decoration: BoxDecoration(
                            color: R.colors.goldenColor,
                            borderRadius: BorderRadius.circular(
                                FetchPixels.getPixelHeight(
                                    10))),
                        margin: EdgeInsets.symmetric(
                            horizontal:
                            FetchPixels.getPixelWidth(5)),
                        padding: EdgeInsets.symmetric(
                          vertical:
                          FetchPixels.getPixelHeight(5),
                          horizontal:
                          FetchPixels.getPixelWidth(20),
                        ),
                        child: Center(
                            child: Text(
                              "Pending Approval",
                              style: R.textStyle
                                  .regularMetropolis()
                                  .copyWith(
                                  fontSize: FetchPixels
                                      .getPixelHeight(14),
                                  color: R.colors.blackColor),
                            )),
                      ):SizedBox(),

                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  // model.productType == ProductsTypes.sell.name ||
                  //         model.productType == ProductsTypes.sold.name ||
                  //         model.productType == ProductsTypes.rent.name
                  //     ? SizedBox()
                  //     : pro.isLoading == true
                  //         ? CircularProgressIndicator(
                  //             color: R.colors.theme,
                  //           )
                  //         : Align(
                  //             alignment: Alignment.centerRight,
                  //             child: MyButton(
                  //                 width: FetchPixels.getPixelWidth(180),
                  //                 height: FetchPixels.getPixelHeight(35),
                  //                 onTap: () async {
                  //                   pro.startLoader();
                  //                   var data = pro.earningsList
                  //                       .where((element) =>
                  //                           element.productId == model.docId)
                  //                       .first;
                  //                   if (data.submitStatus ==
                  //                       SubmitStatus.Yes.name) {
                  //                     model.productType =
                  //                         ProductsTypes.rent.name;
                  //                     await FirebaseFirestore.instance
                  //                         .collection("products")
                  //                         .doc(model.docId)
                  //                         .update(model.toJson());
                  //                   }
                  //                   pro.stopLoader();
                  //                 },
                  //                 buttonText: pro.earningsList
                  //                             .where((element) =>
                  //                                 element.productId ==
                  //                                 model.docId)
                  //                             .first
                  //                             .submitStatus
                  //                             .toString() ==
                  //                         SubmitStatus.No.name
                  //                     ? "Pending"
                  //                     : "Received"),
                  //           ),
                ],
              ),
            ),
          ]),
        ),
      );
    });
  }
}
