import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/custom_abaya_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/pages/my_order_history/widget/my_booking_order_history.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/pages/my_order_history/widget/my_order_history.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';
import 'package:provider/provider.dart';

import '../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../base/widget_utils.dart';
import '../../../../../resources/resources.dart';
import '../../../home/model/product_model.dart';
import '../../../home/widgets/featured_product_widget.dart';

class OrderHistory extends StatelessWidget {
  OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider,AuthProvider>(
      builder: (context, product,auth, child) {
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
                color: R.colors.whiteColor, //change your color here
              ),
              automaticallyImplyLeading: false,
              backgroundColor: R.colors.transparent,
              elevation: 0.0,
              // centerTitle: true,
              title: Text(
                "My Orders",
                style: R.textStyle
                    .mediumMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
              )),
          body: getPaddingWidget(
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
            Column(children: [
              Text('Rental Orders'),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              Expanded(
                child: ListView.builder(
                  itemCount: product.myOwnProducts.length,
                  itemBuilder: (context, index) {
                    ProductModel model = product.myOwnProducts[index];
                    return
                      // product.myList.contains(model.docId)?
                      MyOrderHistory(
                      model: model,
                        index: index,
                    );
                    // :SizedBox();
                  },
                ),
              ),
              Text('Special Tailory Orders'),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              Expanded(
                child: ListView.builder(
                  itemCount: product
                      .bookingsList
                      .where((element) =>
                  element.userId == auth.userModel.email)
                      .length,
                  itemBuilder: (context, index) {

                    CustomAbayaModel model = product.bookingsList
                        .where((element) =>
                    element.userId == auth.userModel.email)
                        .toList()[index];
                    return
                      // product.myList.contains(model.docId)?
                      MyBookingOrderHistory(
                        model: model,
                        index: index,
                      );
                    // :SizedBox();
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
