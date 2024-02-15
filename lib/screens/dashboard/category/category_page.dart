import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/category/widgets/category_widget.dart';
import 'package:hunt_and_rent/screens/dashboard/dashboard_view.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/category_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:provider/provider.dart';

import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../forum/forum_page.dart';
import '../../../resources/resources.dart';
import '../home/provider/product_provider.dart';
import '../profile/pages/my_whish_list.dart';
import '../profile/pages/notifications/notifications.dart';

class CategoryView extends StatefulWidget {
  CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  List<ProductModel> searchResults1 = [];

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProductProvider>(
      builder: (context, auth, product, child) {
        return Column(
          children: [
            getVerSpace(FetchPixels.getPixelHeight(10)),
            getPaddingWidget(
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
              Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  // TextFormField(
                  //   controller: searchController,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       searchQuery = value;
                  //       performSearch(product: product);
                  //     });
                  //   },
                  //   decoration: R.decorations.textFormFieldDecoration(
                  //       Icon(Icons.search_rounded), "search"),
                  // ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.offAll(() => DashboardView(
                                  index: 0,
                                ));
                          },
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                          )),
                      getHorSpace(FetchPixels.getPixelWidth(20)),
                      Center(
                          child: Text(
                        "All Categories",
                        style: R.textStyle
                            .semiBoldMetropolis()
                            .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                      )),
                      Spacer(),
                      Spacer(),
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
                      getHorSpace(FetchPixels.getPixelWidth(10)),
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: FetchPixels.getPixelHeight(60),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: FetchPixels.getPixelWidth(10),
                              right: FetchPixels.getPixelWidth(10),
                              top: FetchPixels.getPixelHeight(
                                  10), // Adjust the top padding
                              bottom: FetchPixels.getPixelHeight(
                                  10), // Adjust the bottom padding
                            ),
                            child: TextFormField(
                              controller: searchController,
                              onChanged: (value) {
                                searchQuery = value;
                                performSearch(product: product);
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                label: Text("Search"),
                                labelStyle: R.textStyle
                                    .regularMetropolis()
                                    .copyWith(
                                        fontSize: 16,
                                        color: R.colors.fillColor),
                                // hintText: "Search...",
                                prefixIcon: searchController.text == ""
                                    ? Icon(Icons.search_rounded)
                                    : InkWell(
                                        onTap: () {
                                          searchController.clear();
                                          searchQuery = "";
                                          setState(() {});
                                        },
                                        child: Icon(Icons.clear),
                                      ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                // Adjust the vertical content padding
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: R.colors.theme,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // Row(
                  //   children: [
                  //
                  //     getHorSpace(FetchPixels.getPixelWidth(15)),
                  //     Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.only( right: FetchPixels.getPixelWidth(10)),
                  //         child: TextFormField(
                  //           controller: searchController,
                  //           onChanged: (value) {
                  //             searchQuery = value;
                  //             performSearch(product: product);
                  //             setState(() {});
                  //
                  //           },
                  //           decoration: R.decorations.textFormFieldDecoration(
                  //               null, "Search",suffix: Icon(Icons.search_rounded)),
                  //         ),
                  //       ),
                  //     ),
                  //     // getHorSpace(FetchPixels.getPixelWidth(10)),
                  //   ],
                  // ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  SizedBox(
                    height: FetchPixels.getPixelHeight(35),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              auth.isClicked = !auth.isClicked;
                              if (product.isSubClicked == true) {
                                print("sub clicked ${product.isSubClicked}");
                                product.isSubClicked = false;

                                product.update();
                              }
                              auth.update();
                            },
                            child: getAssetImage(R.images.lines,
                                scale: FetchPixels.getPixelHeight(4))),
                        getHorSpace(FetchPixels.getPixelWidth(10)),
                        Expanded(
                          child: ListView.builder(
                            itemCount: product.majorCatList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return categoryHeadings(
                                  context, index, auth, product);
                            },
                          ),
                        )
                      ],
                    ),
                  ),

                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  SizedBox(
                    height: FetchPixels.getPixelHeight(35),
                    child: ListView.builder(
                      itemCount: product.brandNames.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return brandsHeadings(context, index, auth, product);
                      },
                    ),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  auth.isClicked
                      ? Container(
                          // height: FetchPixels.getPixelHeight(600),
                          width: FetchPixels.getPixelWidth(100),
                          color: R.colors.whiteColor,
                          child: ListView.builder(
                            itemCount: (product.selectedCatName != 'All')
                                ? product.subCatList
                                    .where((element) =>
                                        element.categoryId ==
                                        product.selectedCatId)
                                    .length
                                : product.subCatList.length,
                            itemBuilder: (context, index) {
                              // CategoriesModel model = product.subCatList[index];
                              CategoriesModel model =
                                  (product.selectedCatName != 'All')
                                      ? product.subCatList
                                          .where((element) =>
                                              element.categoryId ==
                                              product.selectedCatId)
                                          .toList()[index]
                                      : product.subCatList[index];
                              return drawerText(
                                index,
                                auth,
                                model,
                                product,
                              );
                            },
                          ))
                      : SizedBox(),
                  Expanded(
                    child: searchController.text != ""
                        ? SizedBox(
                            height: FetchPixels.getPixelHeight(290),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 0.65,
                                      crossAxisSpacing:
                                          FetchPixels.getPixelWidth(10),
                                      mainAxisSpacing:
                                          FetchPixels.getPixelHeight(5)),
                              itemCount: searchController.text.isEmpty
                                  ? product.products
                                      .where((element) =>
                              (
                                  (element.productType ==
                                      ProductsTypes.rent.name)) && element.status!='pending' )
                                      .length
                                  : searchResults1.length,
                              itemBuilder: (context, index) {
                                ProductModel model =
                                    searchController.text.isEmpty
                                        ? product.products
                                            .where((element) =>
                                    (
                                        (element.productType ==
                                            ProductsTypes.rent.name)) && element.status!='pending' )
                                            .toList()[index]
                                        : searchResults1[index];
                                return getPaddingWidget(
                                  EdgeInsets.only(
                                      right: FetchPixels.getPixelWidth(10)),
                                  CateWidget(
                                    model: model,
                                    isSpecial: false,
                                    index: index,
                                  ),
                                );
                              },
                            ),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: FetchPixels.getPixelWidth(20)),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250,
                                    childAspectRatio:
                                        auth.isClicked ? 0.65 : 0.65,
                                    crossAxisSpacing:
                                        FetchPixels.getPixelWidth(10),
                                    mainAxisSpacing:
                                        FetchPixels.getPixelHeight(5)),
                            itemCount: product.isSubClicked != true
                                ? product.selectedCatName == "All"
                                    ? product.products
                                        .where((element) =>
                            (
                                (element.productType ==
                                    ProductsTypes.rent.name)) && element.status!='pending' )
                                        .length
                                    : product.products
                                        .where((element) =>
                                            element.categoryName ==
                                            product.selectedCatName)
                                        .where((element) =>
                            (
                                element.productType ==
                                                ProductsTypes.rent.name)&& element.status!='pending' )
                                        .length
                                : product.products
                                    .where((element) =>
                                        element.subCategoryName ==
                                        product.selectedSubCatName)
                                    .where((element) =>
                            (
                                        element.productType ==
                                            ProductsTypes.rent.name) && element.status!='pending' )
                                    .length,
                            itemBuilder: (BuildContext ctx, index) {
                              ProductModel model = product.isSubClicked != true
                                  ? product.selectedCatName == "All"
                                      ? product.products
                                          .where((element) =>
                              (
                                              element.productType ==
                                                  ProductsTypes.rent.name) && element.status!='pending' )
                                          .toList()[index]
                                      : product.products
                                          .where((element) =>
                                              element.categoryName ==
                                              product.selectedCatName)
                                          .where((element) =>
                              (
                                              element.productType ==
                                                  ProductsTypes.rent.name) && element.status!='pending' )
                                          .toList()[index]
                                  : product.products
                                      .where((element) =>
                                          element.subCategoryName ==
                                          product.selectedSubCatName)
                                      .where((element) =>
                              (
                                          element.productType ==
                                              ProductsTypes.rent.name) && element.status!='pending' )
                                      .toList()[index];
                              return CateWidget(
                                model: model,
                                isSpecial: false,
                                index: index,
                              );
                            }),
                  ),
                ],
              ),
            ),

            // Wrap(
            //   spacing: FetchPixels.getPixelWidth(10),
            //   runSpacing: FetchPixels.getPixelHeight(5),
            //   alignment: WrapAlignment.center,
            //   children: List.generate(10, (index) {
            //     return CateWidget();
            //   }),
            // ),
            getVerSpace(FetchPixels.getPixelHeight(100))
          ],
        );
      },
    );
  }

  drawerText(index, AuthProvider auth, CategoriesModel model,
      ProductProvider product) {
    return InkWell(
      onTap: () {
        auth.currentDrawerSelected = index;
        product.selectedSubCatName = model.categoryName ?? "";
        product.isSubClicked = true;
        auth.update();
      },
      child: Container(
        decoration: BoxDecoration(
          color: auth.currentDrawerSelected == index
              ? R.colors.blackColor
              : R.colors.whiteColor,
          border: Border(
              bottom: BorderSide(color: R.colors.blackColor.withOpacity(0.3))),
        ),
        padding: EdgeInsets.symmetric(
          vertical: FetchPixels.getPixelHeight(12),
        ),
        child: Center(
          child: Text(
            model.categoryName ?? "",
            style: R.textStyle.regularMetropolis().copyWith(
                fontSize: FetchPixels.getPixelHeight(15),
                color: auth.currentDrawerSelected == index
                    ? R.colors.whiteColor
                    : R.colors.blackColor),
          ),
        ),
      ),
    );
  }

  void performSearch({ProductProvider? product}) {
    if (searchQuery.isEmpty) {
      setState(() {
        searchResults1.clear();
      });
    } else {
      setState(() {
        searchResults1 = product!.products
            .where((element) =>

                element.productType == ProductsTypes.rent.name)
            .toList()
            .where((news) => news.productName!
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .toList();
      });
    }
  }

  categoryHeadings(context, index, AuthProvider auth, ProductProvider product) {
    return InkWell(
      onTap: () {
        auth.selectedCate = index;
        product.selectedCatId = product.majorCatList[index].docId ?? "";
        product.update();
        auth.update();
        product.selectedCatName = product.majorCatList[index].catName ?? "";
        product.update();
        auth.update();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(5)),
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelWidth(13),
            vertical: FetchPixels.getPixelHeight(3)),
        decoration: BoxDecoration(
          // color: auth.selectedCate == index
          //     ? R.colors.theme
          //     : R.colors.transparent,

          borderRadius: BorderRadius.circular(5),
          // border: Border.all(color: R.colors.theme),
        ),
        child: Center(
          child: Text(product.majorCatList[index].catName ?? "",
              textAlign: TextAlign.center,
              style: R.textStyle.mediumMetropolis().copyWith(
                    fontSize: FetchPixels.getPixelHeight(14),
                    color: auth.selectedCate == index
                        ? R.colors.theme
                        : R.colors.fillColor,
                    decoration: auth.selectedCate == index
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    decorationThickness: 5,
                    decorationColor: R.colors.theme,
                  )),
        ),
      ),
    );
  }

  brandsHeadings(context, index, AuthProvider auth, ProductProvider product) {
    return InkWell(
      onTap: () {
        auth.selectedBrand = index;
        auth.update();
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return DashboardView(
              index: 1,
            );
          },
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(5)),
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelWidth(13),
            vertical: FetchPixels.getPixelHeight(3)),
        decoration: BoxDecoration(
          color: auth.selectedBrand == index
              ? R.colors.theme
              : R.colors.transparent,
          border: Border.all(color: R.colors.fillColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            product.brandNames[index],
            style: R.textStyle.regularMetropolis().copyWith(
                  color: auth.selectedBrand == index
                      ? R.colors.whiteColor
                      : R.colors.fillColor,
                  fontSize: FetchPixels.getPixelHeight(14),
                ),
          ),
        ),
      ),
    );
  }
}
