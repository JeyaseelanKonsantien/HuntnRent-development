import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:hunt_and_rent/screens/dashboard/renter_pages/collections/widget/collection_widget.dart';
import 'package:provider/provider.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';
import '../../../../widgets/my_button.dart';
import '../../home/provider/product_provider.dart';
import 'add_product_form.dart';

class CollectionsView extends StatelessWidget {
  const CollectionsView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, AuthProvider>(
      builder: (context, product, auth, child) {
        return Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(vertical: 115),
            child: MyButton(
              textSize: 16,
              height: FetchPixels.getPixelHeight(40),
              borderRadius: 40,
              width: FetchPixels.getPixelWidth(250),
              onTap: () {
                Get.to(() => AddProductForm());
              },
              buttonText: "Add Collection",
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: Container(
            // margin: EdgeInsets.only(bottom: 250),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10), clipBehavior: Clip.antiAlias,
              // Wrap the entire body with SingleChildScrollView
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  product.products
                          .where((element) =>
                              element.email == auth.userModel.email)
                          .isEmpty
                      ? Center(
                          child: getAssetImage(
                            R.images.emptyCart,
                            height: FetchPixels.getPixelHeight(200),
                            width: FetchPixels.getPixelWidth(200),
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(
                            product.products
                                .where((element) =>
                                    element.email == auth.userModel.email)
                                .length,
                            (index) {
                              ProductModel model = product.products
                                  .where((element) =>
                                      element.email == auth.userModel.email)
                                  .toList()[index];
                              return CollectionWidget(
                                model: model,
                                index: index,
                              );
                              // Text('data');
                            },
                          ),
                        ),
                  getVerSpace(FetchPixels.getPixelHeight(150)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
