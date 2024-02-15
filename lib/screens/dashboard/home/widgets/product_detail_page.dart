import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/screens/auth/model/user_model.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/dashboard_view.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';
import 'package:hunt_and_rent/widgets/table_calender.dart';

// import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../resources/resources.dart';
import '../model/product_model.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel model;
  bool? isCart;

  ProductDetails({super.key, required this.model, this.isCart});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<int> dates = [1, 3, 7, 14];

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProductProvider>(
      builder: (context, auth, pro, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: R.colors.transparent,
                expandedHeight: FetchPixels.getPixelHeight(320),
                pinned: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: CarouselSlider(
                    items: List.generate(
                      widget.model.productImage!.length,
                      (index) {
                        return Container(
                          width: FetchPixels.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                widget.model.productImage![index],
                                maxWidth: FetchPixels.width.toInt(),
                                // maxHeight: FetchPixels.getPixelHeight(350).toInt(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    options: CarouselOptions(
                      pageSnapping: true,
                      height: FetchPixels.getPixelHeight(350),
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.ease,
                      // enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      onPageChanged: (index, reason) {
                        // Timer(Duration(milliseconds: 22));
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: FetchPixels.getPixelWidth(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: FetchPixels.getPixelHeight(20)),
                          Row(
                            children: [
                              Text(
                                widget.model.productName ?? "Not found",
                                style: R.textStyle.mediumMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(18)),
                              ),
                            ],
                          ),
                          SizedBox(height: FetchPixels.getPixelHeight(10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: FetchPixels.getPixelHeight(10),
                                  horizontal: FetchPixels.getPixelWidth(10),
                                ),
                                decoration: BoxDecoration(
                                  color: R.colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(5),
                                  ),
                                ),
                                child: Text(
                                  widget.model.productBrand!,
                                  style: R.textStyle
                                      .regularMetropolis()
                                      .copyWith(
                                          fontSize:
                                              FetchPixels.getPixelHeight(12),
                                          color: R.colors.theme),
                                ),
                              ),
                              SizedBox(width: FetchPixels.getPixelWidth(10)),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: FetchPixels.getPixelHeight(10),
                                  horizontal: FetchPixels.getPixelWidth(10),
                                ),
                                decoration: BoxDecoration(
                                  color: R.colors.containerBG,
                                  borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(5),
                                  ),
                                ),
                                child: Text(
                                  widget.model.productType ?? "Party Wear",
                                  style: R.textStyle
                                      .semiBoldMetropolis()
                                      .copyWith(
                                          fontSize:
                                              FetchPixels.getPixelHeight(12),
                                          color: R.colors.blackColor),
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: FetchPixels.getPixelHeight(10),
                                  horizontal: FetchPixels.getPixelWidth(10),
                                ),
                                decoration: BoxDecoration(
                                  color: R.colors.containerBG,
                                  borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(5),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "${pro.earningsList.where((element) => element.productId == widget.model.docId).length}",
                                      style: R.textStyle
                                          .semiBoldMetropolis()
                                          .copyWith(
                                              fontSize:
                                                  FetchPixels.getPixelHeight(
                                                      12),
                                              color: R.colors.blackColor),
                                    ),
                                    SizedBox(
                                        width: FetchPixels.getPixelWidth(10)),
                                    Text(
                                      "Times Rented",
                                      style: R.textStyle
                                          .semiBoldMetropolis()
                                          .copyWith(
                                              fontSize:
                                                  FetchPixels.getPixelHeight(
                                                      12),
                                              color: R.colors.blackColor),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: FetchPixels.getPixelWidth(10)),
                            ],
                          ),
                          SizedBox(height: FetchPixels.getPixelHeight(20)),
                          SizedBox(
                            width: FetchPixels.getPixelWidth(150),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Price",
                                  style: R.textStyle
                                      .semiBoldMetropolis()
                                      .copyWith(
                                          fontSize:
                                              FetchPixels.getPixelHeight(14),
                                          color: R.colors.fillColor),
                                ),
                                SizedBox(
                                    height: FetchPixels.getPixelHeight(10)),
                                Text(
                                  "QR ${widget.model.productPrice!}",
                                  style: R.textStyle
                                      .semiBoldMetropolis()
                                      .copyWith(
                                          color: R.colors.theme,
                                          fontSize:
                                              FetchPixels.getPixelHeight(20)),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          SizedBox(height: FetchPixels.getPixelHeight(5)),
                          Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Select Colour",
                                    style: R.textStyle
                                        .mediumMetropolis()
                                        .copyWith(
                                            color: R.colors.fillColor,
                                            fontSize:
                                                FetchPixels.getPixelHeight(14)),
                                  ),
                                  SizedBox(
                                      height: FetchPixels.getPixelHeight(5)),
                                  Row(
                                    children: List.generate(
                                      widget.model.productColors!.length,
                                      (index) {
                                        return InkWell(
                                          onTap: () {
                                            auth.selectedColor = index;
                                            auth.update();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(
                                              FetchPixels.getPixelHeight(5),
                                            ),
                                            height:
                                                FetchPixels.getPixelHeight(28),
                                            width:
                                                FetchPixels.getPixelWidth(28),
                                            decoration: BoxDecoration(
                                              color: Color(int.parse(widget
                                                  .model
                                                  .productColors![index])),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.check,
                                                color:
                                                    auth.selectedColor == index
                                                        ? R.colors.whiteColor
                                                        : R.colors.transparent,
                                                size:
                                                    FetchPixels.getPixelHeight(
                                                        18),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select Size",
                                style: R.textStyle.mediumMetropolis().copyWith(
                                    color: R.colors.fillColor,
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                              SizedBox(
                                height: FetchPixels.getPixelHeight(50),
                                width: FetchPixels.getPixelWidth(200),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.model.productSize!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        auth.selectedSize = index;
                                        auth.update();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(
                                            FetchPixels.getPixelHeight(5)),
                                        height: FetchPixels.getPixelHeight(28),
                                        width: FetchPixels.getPixelWidth(28),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: R.colors.theme
                                                  .withOpacity(0.5)),
                                          shape: BoxShape.circle,
                                          color: auth.selectedSize == index
                                              ? R.colors.theme
                                              : R.colors.whiteColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            getInitials(widget
                                                .model.productSize![index]
                                                .toString()
                                                .toUpperCase()),
                                            style: R.textStyle
                                                .regularMetropolis()
                                                .copyWith(
                                                  fontSize: FetchPixels
                                                      .getPixelHeight(12),
                                                  color:
                                                      auth.selectedSize == index
                                                          ? R.colors.whiteColor
                                                          : R.colors.theme,
                                                ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          SizedBox(height: FetchPixels.getPixelHeight(5)),
                          Text(
                            "Description",
                            style: R.textStyle.mediumMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(18)),
                          ),
                          SizedBox(height: FetchPixels.getPixelHeight(5)),
                          Text(
                            widget.model.productDescription!,
                            style: R.textStyle.regularMetropolis().copyWith(
                                color: R.colors.blackColor.withOpacity(0.7),
                                fontSize: FetchPixels.getPixelHeight(14)),
                          ),
                          Divider(),
                          SizedBox(height: FetchPixels.getPixelHeight(5)),
                          Text(
                            "Additional Instructions",
                            style: R.textStyle.semiBoldMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(16)),
                          ),
                          SizedBox(height: FetchPixels.getPixelHeight(5)),
                          Text(
                            widget.model.additionalInstructions ??
                                "There is No Additional Instruction for this Order",
                            style: R.textStyle.regularMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(15)),
                          ),
                          Divider(),
                          SizedBox(height: FetchPixels.getPixelHeight(10)),
                          widget.isCart != null
                              ? SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.model.productType == "custom"
                                          ? ""
                                          : "Rental Days",
                                      style: R.textStyle
                                          .regularMetropolis()
                                          .copyWith(
                                              fontSize:
                                                  FetchPixels.getPixelHeight(
                                                      13),
                                              color: R.colors.blackColor
                                                  .withOpacity(0.62)),
                                    ),
                                    SizedBox(
                                        height: FetchPixels.getPixelHeight(5)),
                                    SizedBox(
                                      height: FetchPixels.getPixelHeight(60),
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          Row(
                                            children: List.generate(4, (index) {
                                              return InkWell(
                                                  onTap: () {
                                                    auth.selectedDays = index;
                                                    auth.datesTimes =
                                                        DateTime.now();
                                                    auth.update();
                                                    auth.datesTimes = auth
                                                        .datesTimes
                                                        .add(Duration(
                                                            days:
                                                                dates[index]));
                                                    auth.startDate =
                                                        DateTime.now();
                                                    auth.endDate =
                                                        auth.datesTimes;
                                                    auth.update();
                                                    print(
                                                        "This is the start date: ${auth.startDate}");
                                                    print(
                                                        "This is the end date: ${auth.endDate}");
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: FetchPixels
                                                            .getPixelWidth(15),
                                                        vertical: FetchPixels
                                                            .getPixelHeight(5)),
                                                    margin: EdgeInsets.all(
                                                        FetchPixels
                                                            .getPixelHeight(
                                                                10)),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: R.colors
                                                              .fillColor),
                                                      borderRadius: BorderRadius
                                                          .circular(FetchPixels
                                                              .getPixelHeight(
                                                                  25)),
                                                      color:
                                                          auth.selectedDays ==
                                                                  index
                                                              ? R.colors.theme
                                                              : R.colors
                                                                  .whiteColor,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "${dates[index]} Days",
                                                        style: R.textStyle
                                                            .mediumMetropolis()
                                                            .copyWith(
                                                              fontSize: FetchPixels
                                                                  .getPixelHeight(
                                                                      14),
                                                              color: auth
                                                                          .selectedDays ==
                                                                      index
                                                                  ? R.colors
                                                                      .whiteColor
                                                                  : R.colors
                                                                      .blackColor,
                                                            ),
                                                      ),
                                                    ),
                                                  ));
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        height: FetchPixels.getPixelHeight(10)),
                                    widget.model.productType == "custom"
                                        ? SizedBox()
                                        : SizedBox(
                                            height:
                                                FetchPixels.getPixelHeight(420),
                                            child: CalendarScreen()),
                                    Divider(),
                                    SizedBox(
                                        height: FetchPixels.getPixelHeight(10)),
                                    auth.isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(
                                                color: R.colors.theme))
                                        : MyButton(
                                            // isPrefixIcon: true,
                                            onTap: () async {
                                              print(auth.userModel.cart!
                                                  .map((e) => e.toJson()));
                                              if (auth.userModel.cart!
                                                  .where((element) =>
                                                      element.productId ==
                                                      widget.model.docId)
                                                  .toList()
                                                  .isNotEmpty) {
                                                Get.snackbar(
                                                    backgroundColor:
                                                        R.colors.whiteColor,
                                                    "",
                                                    "This Item is Already in Cart");
                                                auth.update();
                                              } else {
                                                UserCart userCart = UserCart(
                                                  startDate: Timestamp.fromDate(
                                                      auth.startDate ??
                                                          DateTime.now()),
                                                  endDate: Timestamp.fromDate(
                                                      auth.endDate ??
                                                          DateTime.now()),
                                                  productId: "${widget.model.docId}",
                                                );
                                                auth.userModel.cart!
                                                    .add(userCart);
                                                await auth
                                                    .updateUser(auth.userModel);
                                                Get.snackbar(
                                                    backgroundColor:
                                                        R.colors.whiteColor,
                                                    "",
                                                    icon: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green,
                                                    ),
                                                    "Your Item is Successfully Added in Cart");
                                                Get.to(() =>
                                                    DashboardView(index: 2));
                                                print(
                                                    "userCart Value ${auth.userModel.cart!.map((e) => e.toJson())}");
                                                auth.update();
                                              }
                                            },
                                            borderRadius: 50,
                                            buttonText: auth.userModel.cart!
                                                    .contains(widget.model)
                                                ? "Go To Cart"
                                                : "Add to Cart"),
                                    SizedBox(
                                        height: FetchPixels.getPixelHeight(20)),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

String getInitials(String bankAccountName) => bankAccountName.isNotEmpty
    ? bankAccountName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
    : '';
