import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/category_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/widgets/featured_product_widget.dart';
import 'package:provider/provider.dart';

import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../resources/resources.dart';
import '../category/widgets/category_widget.dart';

class FavrtProductsView extends StatelessWidget {
  const FavrtProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProductProvider>(
      builder: (context, auth, product, child) {
        return Scaffold(
          appBar: AppBar(
            leading: Center(
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: FetchPixels.getPixelHeight(30),
                  width: FetchPixels.getPixelWidth(30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: R.colors.blackColor,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: FetchPixels.getPixelHeight(18),
                    color: R.colors.bgColor,
                  ),
                ),
              ),
            ),
            iconTheme: IconThemeData(
              color: R.colors.whiteColor, // change your color here
            ),
            automaticallyImplyLeading: false,
            backgroundColor: R.colors.transparent,
            elevation: 0.0,
            centerTitle: true,
          ),
          body: auth.userModel.favrt == null || auth.userModel.favrt!.isEmpty
              ? Center(
                  child: Text(
                    "There is no Favourite Product in your List",
                    style: R.textStyle.semiBoldMetropolis().copyWith(
                      fontSize: FetchPixels.getPixelHeight(16),
                      color: R.colors.blackColor.withOpacity(0.5),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelWidth(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: FetchPixels.getPixelHeight(10)),
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
                                    element.productType ==
                                        ProductsTypes.rent.name)
                                .toList()[index];
                            return FeaturedWidget(
                              model: model,
                              isCart: false,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
