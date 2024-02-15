import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/base/widget_utils.dart';
import 'package:hunt_and_rent/forum/forum_page.dart';
import 'package:hunt_and_rent/screens/dashboard/category/model/category_model.dart';
import 'package:hunt_and_rent/screens/dashboard/dashboard_view.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/category_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/special_tailory/special_tailory_view.dart';
import 'package:hunt_and_rent/screens/dashboard/home/widgets/sub_category_widget.dart';
import 'package:hunt_and_rent/screens/dashboard/home/widgets/video_player_class.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/pages/notifications/notifications.dart';
import 'package:provider/provider.dart';

import '../../../resources/resources.dart';
import '../../auth/provider/auth_provider.dart';
import '../category/widgets/category_widget.dart';
import '../profile/pages/my_whish_list.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> trending = [
    "Black Gown",
    "Under 150 QR",
    "Green Jalabiya",
    "Black Gown",
    "Under 150 QR",
    "Green Jalabiya",
    "Black Gown",
    "Under 150 QR",
    "Green Jalabiya",
  ];

  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  bool isSizeFilter = false;
  bool isOccFilter = false;
  bool isSizeCheck = false;
  bool isOccCheck = false;

  List<ProductModel> searchResults1 = [];

  @override
  void initState() {
    var product = Provider.of<ProductProvider>(context, listen: false);
    product.selections = List.generate(product.sizesNames.length, (_) => false);
    product.selectionsOcc =
        List.generate(product.occasionNames.length, (_) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProductProvider>(
      builder: (context, auth, product, child) {
        return Column(
          children: [
            // AppBar(leading: Icon(Icons.construction),),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            Row(
              children: [
                Expanded(
                  child: getAssetImage(R.images.logo01,
                      // color: R.colors.buttonText,
                      height: 55,
                      boxFit: BoxFit.fitHeight),
                ),
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
                getHorSpace(FetchPixels.getPixelWidth(20)),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: FetchPixels.getPixelHeight(60),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: FetchPixels.getPixelWidth(20),
                        right: FetchPixels.getPixelWidth(20),
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
                          label: Text(
                            "Search",
                            style: R.textStyle.regularMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(14),
                                color: R.colors.blackColor.withOpacity(0.5)),
                          ),
                          labelStyle: R.textStyle.regularMetropolis().copyWith(
                              fontSize: 15,
                              color: R.colors.blackColor.withOpacity(0.5)),
                          // hintText: "Search...",
                          prefixIcon: searchController.text == ""
                              ? Icon(
                                  Icons.search_rounded,
                                  size: FetchPixels.getPixelHeight(18),
                                )
                              : InkWell(
                                  onTap: () {
                                    searchController.clear();
                                    searchQuery = "";
                                    setState(() {});
                                  },
                                  child: Icon(Icons.clear),
                                ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
            Divider(
              color: R.colors.containerBG1,
              thickness: 5,
            ),

            getVerSpace(FetchPixels.getPixelHeight(10)),

            Expanded(
              child: searchController.text != ""
                  ? SizedBox(
                      height: FetchPixels.getPixelHeight(290),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: FetchPixels.getPixelWidth(10),
                            mainAxisSpacing: FetchPixels.getPixelHeight(5)),
                        itemCount: searchController.text.isEmpty
                            ? product.products
                                .where((element) =>
                                    element.productType ==
                                        ProductsTypes.custom.name ||
                                    element.productType ==
                                        ProductsTypes.rent.name)
                                .length
                            : searchResults1.length,
                        itemBuilder: (context, index) {
                          ProductModel model = searchController.text.isEmpty
                              ? product.products
                                  .where((element) =>
                                      element.productType ==
                                          ProductsTypes.custom.name ||
                                      element.productType ==
                                          ProductsTypes.rent.name)
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
                  : ListView(
                      children: [
                        Stack(
                          children: [

                            CarouselSlider(
                                items: List.generate(4, (index) {
                                  CategoriesModel model = CategoriesModel();
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) {
                                          return DashboardView(
                                            index: 1,
                                          );
                                        }));

                                      },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: getDecorationAssetImage(
                                            context, R.images.bannerImageNew,
                                            fit: BoxFit.fill)),
                                    width: FetchPixels.width,
                                  ));
                                }),
                                options: CarouselOptions(
                                  pageSnapping: true,
                                  height: FetchPixels.getPixelHeight(200),
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 0.9,
                                  enlargeFactor: 0.5,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.ease,
                                  enlargeCenterPage: true,
                                  onPageChanged: (index, reason) {
                                    // Timer(Duration(milliseconds: 22));
                                  },
                                  scrollDirection: Axis.horizontal,
                                )),

                            // Layer 2: Content aligned to the bottom with a gap
                            // Positioned(
                            //   bottom:
                            //       20, // Adjust the value for the desired gap
                            //   left: 20,
                            //   right: 20,
                            //   child: Container(
                            //     height: FetchPixels.getPixelHeight(50),
                            //     width: FetchPixels.width,
                            //     color: R.colors.whiteColor,
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceEvenly,
                            //       children: [
                            //         InkWell(
                            //           onTap: () {
                            //             Get.dialog(SelectSizeDialog(
                            //               onTap: () {
                            //                 Get.back();
                            //               },
                            //             ));
                            //           },
                            //           child: Text(
                            //             "SIZE",
                            //             style: R.textStyle
                            //                 .regularMetropolis()
                            //                 .copyWith(
                            //                     fontSize:
                            //                         FetchPixels.getPixelHeight(
                            //                             15)),
                            //           ),
                            //         ),
                            //         Container(
                            //           height: FetchPixels.getPixelHeight(30),
                            //           width: FetchPixels.getPixelWidth(1.5),
                            //           color: R.colors.blackColor,
                            //         ),
                            //         InkWell(
                            //           onTap: () {
                            //             Get.dialog(SelectOccasionDialog(
                            //               onTap: () {
                            //                 Get.back();
                            //               },
                            //             ));
                            //           },
                            //           child: Text(
                            //             "OCCASION",
                            //             style: R.textStyle
                            //                 .regularMetropolis()
                            //                 .copyWith(
                            //                     fontSize:
                            //                         FetchPixels.getPixelHeight(
                            //                             15)),
                            //           ),
                            //         ),
                            //         Container(
                            //           height: FetchPixels.getPixelHeight(30),
                            //           width: FetchPixels.getPixelWidth(1.5),
                            //           color: R.colors.blackColor,
                            //         ),
                            //         InkWell(
                            //           onTap: () {
                            //             ScaffoldMessenger.of(context)
                            //                 .showSnackBar(
                            //               SnackBar(
                            //                 content: Text("No Record Found!"),
                            //               ),
                            //             );
                            //           },
                            //           child: SizedBox(
                            //             height: FetchPixels.getPixelHeight(15),
                            //             width: FetchPixels.getPixelWidth(70),
                            //             child: Text(
                            //               "SEARCH",
                            //               style: R.textStyle
                            //                   .regularMetropolis()
                            //                   .copyWith(
                            //                       fontSize: FetchPixels
                            //                           .getPixelHeight(15)),
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Divider(
                          color: R.colors.containerBG1,
                          thickness: 5,
                          height: FetchPixels.getPixelHeight(30),
                        ),
                        getPaddingWidget(
                          EdgeInsets.symmetric(
                              horizontal: FetchPixels.getPixelWidth(20)),
                          Column(
                            children: [
                              SizedBox(
                                height: FetchPixels.getPixelHeight(30),
                                child: ListView.builder(
                                  itemCount: product.majorCatList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return categoryHeadings(
                                        context, index, auth, product);
                                  },
                                ),
                              ),
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                              SizedBox(
                                height: FetchPixels.getPixelHeight(30),
                                child: ListView.builder(
                                  itemCount: product.brandNames.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return brandsHeadings(
                                        context, index, auth, product);
                                  },
                                ),
                              ),
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                            ],
                          ),
                        ),
                        getPaddingWidget(
                          EdgeInsets.symmetric(
                              horizontal: FetchPixels.getPixelWidth(20)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                              Text("New Arrivals",
                                  style: R.textStyle
                                      .mediumMetropolis()
                                      .copyWith(
                                          fontSize:
                                              FetchPixels.getPixelHeight(16))),
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                              SizedBox(
                                height: FetchPixels.getPixelHeight(290),
                                child: ListView.builder(
                                  itemCount: product.products
                                      .where((element) =>
                                  (
                                      (element.productType ==
                                              ProductsTypes.rent.name)) && element.status!='pending' )
                                      .length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    ProductModel model = product.products
                                        .where((element) =>
                                    (
                                        (element.productType ==
                                            ProductsTypes.rent.name)) && element.status!='pending' )
                                        .toList()[index];
                                    return getPaddingWidget(
                                      EdgeInsets.all(10),
                                      CateWidget(
                                        model: model,
                                        isSpecial: false,
                                        index: index,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                            ],
                          ),
                        ),
                        Container(
                          color: R.colors.containerBG1,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: SizedBox(
                            child: InkWell(
                              onTap: () {
                                Get.to(() => SpecialTailoryView());
                              },
                              child: Container(
                                // margin: EdgeInsets.symmetric(horizontal: 100),
                                height: FetchPixels.getPixelHeight(100),
                                decoration: BoxDecoration(
                                    color: R.colors.containerBG1,
                                    image: getDecorationAssetImage(
                                        context, R.images.specialTailory,
                                        fit: BoxFit.fill)),
                              ),
                            ),
                          ),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(20)),
                        // getPaddingWidget(
                        //   EdgeInsets.symmetric(
                        //       horizontal: FetchPixels.getPixelWidth(20)),
                        //   Wrap(
                        //     spacing: FetchPixels.getPixelWidth(10),
                        //     runSpacing: FetchPixels.getPixelHeight(20),
                        //     alignment: WrapAlignment.spaceAround,
                        //     children: List.generate(product.subCatList.length,
                        //         (index) {
                        //       CategoriesModel model = product.subCatList[index];
                        //       return SubCategoryWidget(
                        //         model: model,
                        //       );
                        //     }),
                        //   ),
                        // ),

                        getPaddingWidget(
                          EdgeInsets.symmetric(
                              horizontal: FetchPixels.getPixelWidth(20)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                              Text("Explore Cartegory",
                                  style: R.textStyle
                                      .mediumMetropolis()
                                      .copyWith(
                                          fontSize:
                                              FetchPixels.getPixelHeight(16))),
                              getVerSpace(FetchPixels.getPixelHeight(20)),
                            ],
                          ),
                        ),
                        getPaddingWidget(
                          EdgeInsets.symmetric(
                              horizontal: FetchPixels.getPixelWidth(20)),
                          Container(
                            height: FetchPixels.getPixelHeight(230),
                            child: GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10,
                                      // mainAxisSpacing: 5,
                                      childAspectRatio: 9 / 12,
                                      crossAxisCount: 4),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // scrollDirection: Axis.vertical,
                              children: List.generate(product.subCatList.length,
                                  (index) {
                                CategoriesModel model =
                                    product.subCatList[index];
                                return SubCategoryWidget(
                                  model: model,
                                );
                              }),
                            ),
                          ),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(20)),
                        getPaddingWidget(
                          EdgeInsets.symmetric(
                              horizontal: FetchPixels.getPixelWidth(20)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                              Text("Recently Viewed",
                                  style: R.textStyle
                                      .mediumMetropolis()
                                      .copyWith(
                                          fontSize:
                                              FetchPixels.getPixelHeight(16))),
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                              SizedBox(
                                height: FetchPixels.getPixelHeight(290),
                                child: ListView.builder(
                                  itemCount: product.products
                                      .where((element) =>
                                  (
                                      (element.productType ==
                                          ProductsTypes.rent.name)) && element.status!='pending' )
                                      .length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    ProductModel model = product.products
                                        .where((element) =>
                                    (
                                        (element.productType ==
                                            ProductsTypes.rent.name)) && element.status!='pending' )
                                        .toList()[index];
                                    return getPaddingWidget(
                                      EdgeInsets.all(10),
                                      // EdgeInsets.only(
                                      //     right: FetchPixels.getPixelWidth(10)),
                                      CateWidget(
                                        model: model,
                                        isSpecial: false,
                                        index: index,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                              Text("Trending Searches",
                                  style: R.textStyle
                                      .mediumMetropolis()
                                      .copyWith(
                                          fontSize:
                                              FetchPixels.getPixelHeight(16))),
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                              SizedBox(
                                height: FetchPixels.getPixelHeight(40),
                                child: ListView.builder(
                                  itemCount: product.products
                                      .where((element) =>
                                          element.productType ==
                                              ProductsTypes.custom.name ||
                                          element.productType ==
                                              ProductsTypes.rent.name)
                                      .length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    ProductModel model = product.products
                                        .where((element) =>
                                            element.productType ==
                                                ProductsTypes.custom.name ||
                                            element.productType ==
                                                ProductsTypes.rent.name)
                                        .toList()[index];
                                    return InkWell(
                                      onTap: () {
                                        searchController.text =
                                            model.productName ?? "";
                                        searchQuery = searchController.text;
                                        performSearch(product: product);
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: R.colors.containerBG1,
                                            borderRadius: BorderRadius.circular(
                                                FetchPixels.getPixelHeight(
                                                    20))),
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
                                          model.productName ?? "",
                                          style: R.textStyle
                                              .regularMetropolis()
                                              .copyWith(
                                                  fontSize: FetchPixels
                                                      .getPixelHeight(14),
                                                  color: R.colors.blackColor),
                                        )),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                            ],
                          ),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(10)),
                        (product.featuredAd.length==0)?Center(
                          child: CircularProgressIndicator(
                            color: Colors.black87,
                          ),)
                        :AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 9),
                                // padding: EdgeInsets.all(10),
                                // width: FetchPixels.getPixelWidth(160),
                                height: FetchPixels.getHeightPercentSize(26),
                                // margin: EdgeInsets.symmetric(horizontal: 15),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: R.colors.whiteColor),
                                    borderRadius: BorderRadius.circular(25)),
                                child:
                                VideoPlayerView(video_url:product.featuredAd[0].toJson()['video_url'])
                            )),

                        getVerSpace(FetchPixels.getPixelHeight(10)),
                        getPaddingWidget(
                          EdgeInsets.symmetric(
                              horizontal: FetchPixels.getPixelWidth(20)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${product.featuredAd[0].toJson()['title']}',
                                  style: R.textStyle
                                      .regularMetropolis()
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: R.colors.g1,
                                          fontSize:
                                              FetchPixels.getPixelHeight(20))),
                              getVerSpace(FetchPixels.getPixelHeight(15)),
                              Text(
                                  "${product.featuredAd[0].toJson()['description']}",
                                  textAlign: TextAlign.start,
                                  style: R.textStyle
                                      .regularMetropolis()
                                      .copyWith(
                                          fontSize: FetchPixels.getPixelHeight(
                                              13.5))),
                              getVerSpace(FetchPixels.getPixelHeight(15)),
                            ],
                          ),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(100))
                      ],
                    ),
            ),
          ],
        );
      },
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
                element.productType == ProductsTypes.custom.name ||
                element.productType == ProductsTypes.rent.name)
            .toList()
            .where((news) => news.productName!
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .toList();
      });
    }
  }
}

categoryHeadings(context, index, AuthProvider auth, ProductProvider product) {
  return InkWell(
    onTap: () {
      auth.selectedCate = index;
      product.selectedCatId = product.majorCatList[index].docId ?? "";
      product.update();
      auth.update();

      print(product.selectedCatId);
      product.selectedCatName = product.majorCatList[index].catName ?? "";
      product.update();
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
        color: auth.selectedCate == index
            ? R.colors.transparent
            : R.colors.transparent,
        borderRadius: BorderRadius.circular(5),
        // border: BorderDirectional(bottom: BorderSide(color: R.colors.theme))
      ),
      child: Center(
        child: Text(
          product.majorCatList[index].catName ?? "",
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
              ),
        ),
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
        color:
            auth.selectedBrand == index ? R.colors.theme : R.colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: auth.selectedBrand == index
            ? Border.all(color: R.colors.fillColor)
            : Border.all(color: R.colors.fillColor),
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
