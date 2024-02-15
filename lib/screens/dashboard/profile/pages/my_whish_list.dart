import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/category_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';
import '../../../../widgets/my_button.dart';
import '../../dashboard_view.dart';
import '../../home/widgets/featured_product_widget.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, AuthProvider>(
      builder: (context, product, auth, child) {
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
                color: R.colors.whiteColor,
              ),
              automaticallyImplyLeading: false,
              backgroundColor: R.colors.transparent,
              elevation: 0.0,
              // centerTitle: true,
              title: Text(
                "My Wishlist",
                style: R.textStyle
                    .mediumMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
              )),
          body: getPaddingWidget(
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
            Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  product.products
                              .where((element) =>
                                  auth.userModel.favrt!.contains(element.docId))
                              .where((element) =>
                                  element.productType ==
                                      ProductsTypes.custom.name ||
                                  element.productType ==
                                      ProductsTypes.rent.name)
                              .length ==
                          0
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: MyButton(
                              color: R.colors.theme,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return DashboardView(
                                      index: 1,
                                    );
                                  },
                                ));
                              },
                              buttonText: "Hunt Now"),
                        )
                      : SizedBox(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: product.products
                          .where((element) =>
                              auth.userModel.favrt!.contains(element.docId))
                          .where((element) =>
                              element.productType == ProductsTypes.custom.name ||
                              element.productType == ProductsTypes.rent.name)
                          .length,
                      itemBuilder: (context, index) {
                        ProductModel model = product.products
                            .where((element) =>
                                auth.userModel.favrt!.contains(element.docId))
                            .where((element) =>
                                element.productType ==
                                    ProductsTypes.custom.name ||
                                element.productType == ProductsTypes.rent.name)
                            .toList()[index];
                        return product.products
                                .where((element) => auth.userModel.favrt!
                                    .contains(element.docId))
                                .where((element) =>
                                    element.productType ==
                                        ProductsTypes.custom.name ||
                                    element.productType ==
                                        ProductsTypes.rent.name)
                                .isEmpty
                            ? Center(
                                child: Text(
                                "0",
                                style: TextStyle(color: R.colors.theme),
                              ))
                            : FeaturedWidget(
                                model: model,
                                isCart: true,
                              );
                      },
                    ),
                  )
                ]),
          ),
        );
      },
    );
  }
}
