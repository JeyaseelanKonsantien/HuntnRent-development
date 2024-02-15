import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/forum/forum_page.dart';
import 'package:hunt_and_rent/screens/dashboard/dashboard_view.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../base/widget_utils.dart';
import '../../../../../resources/resources.dart';
import '../../../../auth/provider/auth_provider.dart';
import '../../../category/widgets/category_widget.dart';
import '../../../profile/pages/my_whish_list.dart';
import '../../../profile/pages/notifications/notifications.dart';
import '../../favrt_produects.dart';

class AbayasView extends StatelessWidget {
  String? productName;

  AbayasView({super.key, this.productName});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, product, child) {
        return Scaffold(
          // appBar: AppBar(
          //     leading: Center(
          //       child: InkWell(
          //         onTap: () {
          //           Get.back();
          //         },
          //         child: Container(
          //           height: FetchPixels.getPixelHeight(30),
          //           width: FetchPixels.getPixelWidth(30),
          //           decoration: BoxDecoration(
          //               shape: BoxShape.circle, color: R.colors.blackColor),
          //           child: Icon(
          //             Icons.arrow_back_ios_rounded,
          //             size: FetchPixels.getPixelHeight(18),
          //             color: R.colors.bgColor,
          //           ),
          //         ),
          //       ),
          //     ),
          //     actions: [
          //       Center(
          //         child: getAssetImage(R.images.selectedCart,
          //             color: R.colors.buttonText,
          //             scale: FetchPixels.getPixelHeight(4)),
          //       ),
          //       getHorSpace(FetchPixels.getPixelWidth(10)),
          //       Center(
          //         child: InkWell(
          //           onTap: () {
          //             Get.to(()=>FavrtProductsView());
          //           },
          //           child: getAssetImage(R.images.fav,
          //               color: R.colors.redColor,
          //               scale: FetchPixels.getPixelHeight(3.5)),
          //         ),
          //       ),
          //       getHorSpace(FetchPixels.getPixelWidth(20))
          //     ],
          //     iconTheme: IconThemeData(
          //       color: R.colors.whiteColor, //change your color here
          //     ),
          //     automaticallyImplyLeading: false,
          //     backgroundColor: R.colors.transparent,
          //     elevation: 0.0,
          //     centerTitle: true,
          //     title: getAssetImage(R.images.logo1,
          //         height: FetchPixels.getPixelHeight(60),
          //         width: FetchPixels.getPixelWidth(150))),
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                getVerSpace(FetchPixels.getPixelHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: FetchPixels.getPixelHeight(22),
                        color: R.colors.blackColor,
                      ),
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(30)),
                    Row(
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              productName == 'Abayas'
                                  ? "All Abayas "
                                  : "All Thobes",
                              style: R.textStyle.semiBoldMetropolis().copyWith(
                                  fontSize: FetchPixels.getPixelHeight(16)),
                            )),
                      ],
                    ),
                    // Container(
                    //   height: FetchPixels.getPixelHeight(40),
                    //   width: FetchPixels.getPixelWidth(180),
                    //   child: Padding(
                    //     padding: EdgeInsets.only(
                    //         left: FetchPixels.getPixelWidth(5),
                    //         right: FetchPixels.getPixelWidth(10)),
                    //     child: TextFormField(
                    //         // controller: searchController,
                    //         // onChanged: (value) {
                    //         //   searchQuery = value;
                    //         //   performSearch(product: product);
                    //         //   setState(() {});
                    //         // },
                    //         decoration: R.decorations.textFormFieldDecoration(
                    //             null, "Search",
                    //             suffix: Icon(Icons.search_rounded))),
                    //   ),
                    // ),

                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => ForumView());
                          },
                          child: getAssetImage(R.images.chatOutline,
                              // color: R.colors.buttonText,
                              scale: 4.5),
                        ),
                        getHorSpace(FetchPixels.getPixelWidth(10)),
                        InkWell(
                          onTap: () {
                            Get.to(() => WishList());
                          },
                          child: getAssetImage(R.images.favOutline,
                              // color: R.colors.buttonText,
                              scale: 4.5),
                        ),
                        getHorSpace(FetchPixels.getPixelWidth(10)),
                        InkWell(
                          onTap: () {
                            Get.to(() => NotificationsView());
                          },
                          child: getAssetImage(R.images.notificationOutline,
                              // color: R.colors.buttonText,
                              scale: 4.5),
                        ),
                        getHorSpace(FetchPixels.getPixelWidth(20)),
                      ],
                    ),
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                Text(
                  "Get Your Customized $productName & much more.",
                  style: R.textStyle
                      .regularMetropolis()
                      .copyWith(fontSize: FetchPixels.getPixelHeight(15)),
                ),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: FetchPixels.getPixelWidth(10),
                          mainAxisSpacing: FetchPixels.getPixelHeight(5)),
                      itemCount: product.products
                          .where((element) =>(
                              element.subCategoryName == productName) && element.productType == "custom")
                          .length,
                      itemBuilder: (BuildContext ctx, index) {
                        ProductModel model = product.products
                            .where((element) =>(
                            element.subCategoryName == productName) && element.productType == "custom")
                            .toList()[index];
                        return CateWidget(
                          model: model,
                          isSpecial: true,
                          index: index,
                        );
                      }),
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
              ]),
            ),
          ),
        );
      },
    );
  }
}
