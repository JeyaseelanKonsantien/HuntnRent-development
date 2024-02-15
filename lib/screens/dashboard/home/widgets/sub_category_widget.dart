import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/category/widgets/category_widget.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/category_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';
import '../model/product_model.dart';

class SubCategoryWidget extends StatelessWidget {
  final CategoriesModel model;

  SubCategoryWidget({super.key, required this.model});

  List<String> subCategoriesImages = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CategoryFilter(
              model: model,
            ));
        // Get.offAll(DashboardView(
        //   index: 1,
        // ));
      },
      child: Column(
        children: [
          Container(
            height: FetchPixels.getPixelHeight(80),
            width: FetchPixels.getPixelWidth(80),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: R.colors.theme.withOpacity(0.1),
              // backgroundColor: Color.fromARGB(255, 0, 0, 0),
              child: Center(
                child: SvgPicture.network(
                  color: R.colors.theme,
                  model.categoryImage!,
                  // Replace with the actual URL of the SVG image
                  height: model.categoryName == 'Sneakers'
                      ? FetchPixels.getPixelHeight(23)
                      : FetchPixels.getPixelHeight(40),
                  // Adjust the height as needed
                  width: model.categoryName == 'Sneakers'
                      ? FetchPixels.getPixelHeight(23)
                      : FetchPixels.getPixelHeight(40),
                  // Adjust the width as needed
                  placeholderBuilder: (BuildContext context) =>
                      CircularProgressIndicator(
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          getVerSpace(FetchPixels.getPixelHeight(5)),
          Text(
            model.categoryName!,
            style: R.textStyle.regularMetropolis(),
          ),
        ],
      ),
    );
  }
}

class CategoryFilter extends StatelessWidget {
  final CategoriesModel model;

  CategoryFilter({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProductProvider>(
      builder: (context, auth, product, child) {
        return Scaffold(
          appBar: AppBar(
              title: Text(model.categoryName!),
              centerTitle: true,
              backgroundColor: R.colors.containerBG1,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios),
              )),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(10)),
                Container(
                  height: FetchPixels.getPixelHeight(50),
                  child: TextFormField(
                    decoration: R.decorations.textFormFieldDecoration(
                        Icon(Icons.search_rounded), "Search"),
                  ),
                ),
                getVerSpace(FetchPixels.getPixelHeight(15)),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: FetchPixels.getPixelWidth(10),
                          mainAxisSpacing: FetchPixels.getPixelHeight(5)),
                      itemCount: product.products
                          .where((element) => ((element.subCategoryName ==
                          model.categoryName) &&
                          (element.productType == ProductsTypes.custom.name ||
                              element.productType ==
                                  ProductsTypes.rent.name) && (element.status !=
                          "pending")))
                          .length,
                      itemBuilder: (BuildContext ctx, index) {
                        ProductModel model1 = product.products
                            .where((element) => ((element.subCategoryName ==
                            model.categoryName) &&
                            (element.productType == ProductsTypes.custom.name ||
                                element.productType ==
                                    ProductsTypes.rent.name) && (element.status !=
                            "pending")))
                            .toList()[index];
                        return CateWidget(
                          model: model1,
                          isSpecial: false,
                          index: index,
                        );
                      }),
                  // ListView.builder(
                  //   itemCount: product.products.where((element) => element.subCategoryName == model.categoryName).length,
                  //   scrollDirection: Axis.horizontal,
                  //   itemBuilder: (context, index) {
                  //     ProductModel model1 = product.products.where((element) => element.subCategoryName == model.categoryName).toList()[index];
                  //     return getPaddingWidget(
                  //       EdgeInsets.only(right: FetchPixels.getPixelWidth(10)),
                  //       CateWidget(
                  //         model: model1,
                  //         isSpecial: false,
                  //         index: index,
                  //       ),
                  //     );
                  //   },
                  // ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
