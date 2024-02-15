import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/cart/model/cart_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/category_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../base/widget_utils.dart';
import '../../../../../resources/resources.dart';
import '../../../home/model/product_model.dart';
import '../widget/renter_product_widget.dart';

class RentalsView extends StatelessWidget {
  const RentalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, AuthProvider>(
      builder: (context, product, auth, child) {
        return Scaffold(
          appBar: AppBar(
              leading: Center(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: FetchPixels.getPixelHeight(22),
                    color: R.colors.whiteColor,
                  ),
                ),
              ),
              iconTheme: IconThemeData(
                color: R.colors.whiteColor, //change your color here
              ),
              automaticallyImplyLeading: false,
              backgroundColor: R.colors.theme,
              elevation: 0.0,
              title: Center(
                  child: Text(
                "Rental Orders",
                style: R.textStyle.semiBoldMetropolis().copyWith(
                    color: R.colors.whiteColor,
                    fontSize: FetchPixels.getPixelHeight(20)),
              ))),
          body: Column(
            children: [
              // Expanded(
              //     child: ListView.builder(
              //   itemCount: product.products
              //       .where((element) =>
              //           element.email == auth.userModel.email &&
              //           element.productType == ProductsTypes.rent.name)
              //       .length,
              //   padding: EdgeInsets.symmetric(
              //       horizontal: FetchPixels.getPixelWidth(20)),
              //   itemBuilder: (context, index) {
              //     ProductModel model = product.products
              //         .where((element) =>
              //             element.email == auth.userModel.email &&
              //             element.productType == ProductsTypes.rent.name)
              //         .toList()[index];
              //     return RenterProductWidget(
              //       model: model,
              //     );
              //   },
              // )),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              product.earningsList
                      .where((element) =>
                          element.vendorId == auth.userModel.email )
                      .isEmpty
                  ? Center(
                      child: getAssetImage(
                      R.images.emptyRentals,
                      height: FetchPixels.getPixelHeight(250),
                      width: FetchPixels.getPixelWidth(250),
                    ))
                  : Expanded(
                      child: GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          scrollDirection: Axis.vertical,
                          itemCount: product.earningsList
                              .where((element) =>
                          element.vendorId == auth.userModel.email )
                              .length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250,
                                  childAspectRatio: 0.55,
                                  crossAxisSpacing:
                                      FetchPixels.getPixelWidth(20),
                                  mainAxisSpacing:
                                      FetchPixels.getPixelHeight(15)),
                          itemBuilder: (context, index) {
                            CartModel rentalmodel = product.earningsList
                                .where((element) =>
                            element.vendorId == auth.userModel.email )
                                .toList()[index];

                            ProductModel pro = product.products
                                .where((element) =>
                            element.docId==rentalmodel.productId)
                                .toList()[0];
                            return RenterProductWidget1(
                              product: pro,
                              model: rentalmodel,
                            );
                          })),
            ],
          ),
        );
      },
    );
  }
}
