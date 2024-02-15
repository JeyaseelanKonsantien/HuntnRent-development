import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/screens/auth/model/user_model.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/cart/model/cart_model.dart';
import 'package:hunt_and_rent/screens/dashboard/dashboard_view.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';
import 'package:hunt_and_rent/widgets/table_calender.dart';
import 'package:intl/intl.dart';

// import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';
import '../model/product_model.dart';

class RentalOrderDetails extends StatefulWidget {
  final CartModel model;
  bool? isCart;

  final ProductModel product;

  RentalOrderDetails({super.key, required this.model, this.isCart, required this.product});

  @override
  State<RentalOrderDetails> createState() => _RentalOrderDetailsState();
}

class _RentalOrderDetailsState extends State<RentalOrderDetails> {
  List<int> dates = [1, 3, 7, 14];

  @override
  Widget build(BuildContext context) {
    var delivery_status = "";
    if(widget.model.orderStatus=='Active'){
      delivery_status = "Order Placed";
    }else if(widget.model.orderStatus=='Preparing'){
      delivery_status = "Preparing";
    }else if(widget.model.orderStatus=='Out for Delivery'){
      delivery_status = "Out for Delivery";
    }else if(widget.model.orderStatus=='Delivered'){
      delivery_status = "Delivered";
    }else{
      delivery_status = "Returned";
    }

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
                      widget.product.productImage!.length,
                          (index) {
                        return Container(
                          width: FetchPixels.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                widget.product.productImage![index],
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
                                widget.product.productName ?? "Not found",
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
                                  widget.product.productBrand!,
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
                                  widget.product.productType ?? "Party Wear",
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
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Order Date: ",
                                  style: R.textStyle.regularMetropolis().copyWith(
                                    color: R.colors.blackColor.withOpacity(1),
                                    fontSize: FetchPixels.getPixelHeight(15),
                                  ),
                                ),
                                TextSpan(
                                  text:  DateFormat('MMM dd yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.model.docId!)).toLocal()),
                                  style: R.textStyle.regularMetropolis().copyWith(
                                    color: R.colors.theme1.withOpacity(0.7),
                                    fontSize: FetchPixels.getPixelHeight(14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: FetchPixels.getPixelHeight(10)),
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
                          Text(
                            "Order Details",
                            style: R.textStyle.mediumMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(18)),
                          ),
                          SizedBox(height: FetchPixels.getPixelHeight(5)),
                          Row(
                            children: [
                              Text(
                                "Selected Colour",
                                style: R.textStyle
                                    .mediumMetropolis()
                                    .copyWith(
                                    color: R.colors.fillColor,
                                    fontSize:
                                    FetchPixels.getPixelHeight(14)),
                              ),
                              SizedBox(
                                  height: FetchPixels.getPixelHeight(5)),

                              Container(
                                margin: EdgeInsets.all(
                                  FetchPixels.getPixelHeight(5),
                                ),
                                height:
                                FetchPixels.getPixelHeight(28),
                                width:
                                FetchPixels.getPixelWidth(28),
                                decoration: BoxDecoration(
                                  color: Color(int.parse(widget.model.color.toString())),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    color:
                                    Colors.amber,
                                    size:
                                    FetchPixels.getPixelHeight(
                                        18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: FetchPixels.getPixelHeight(5)),
                          Row(
                            children: [
                              Text(
                                "Selected Size: " ,
                                style: R.textStyle
                                    .mediumMetropolis()
                                    .copyWith(
                                    color: R.colors.fillColor,
                                    fontSize:
                                    FetchPixels.getPixelHeight(14)),
                              ),
                              Text(
                                widget.model.size.toString(),
                                style: R.textStyle
                                    .mediumMetropolis()
                                    .copyWith(

                                    fontSize:
                                    FetchPixels.getPixelHeight(14)),
                              ),
                            ],
                          ),

                          SizedBox(height: FetchPixels.getPixelHeight(20)),
                          Text(
                            "Customer Name:",
                            style: R.textStyle.regularMetropolis().copyWith(
                                color: R.colors.blackColor.withOpacity(1),
                                fontSize: FetchPixels.getPixelHeight(15)),
                          ),
                          Text(
                            widget.model.customerName!,
                            style: R.textStyle.regularMetropolis().copyWith(
                                color: R.colors.theme1.withOpacity(0.7),
                                fontSize: FetchPixels.getPixelHeight(14)),
                          ),
                          SizedBox(height: FetchPixels.getPixelHeight(10)),
                          Text(
                            "Delivery Address:",
                            style: R.textStyle.regularMetropolis().copyWith(
                                color: R.colors.blackColor.withOpacity(1),
                                fontSize: FetchPixels.getPixelHeight(15)),
                          ),
                          Text(
                            widget.model.deliveryAddress!,
                            style: R.textStyle.regularMetropolis().copyWith(
                                color: R.colors.theme1.withOpacity(0.7),
                                fontSize: FetchPixels.getPixelHeight(14)),
                          ),
                          SizedBox(height: FetchPixels.getPixelHeight(10)),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Payment Method: ",
                                  style: R.textStyle.regularMetropolis().copyWith(
                                    color: R.colors.blackColor.withOpacity(1),
                                    fontSize: FetchPixels.getPixelHeight(15),
                                  ),
                                ),
                                TextSpan(
                                  text: widget.model.paymentMethod!,
                                  style: R.textStyle.regularMetropolis().copyWith(
                                    color: R.colors.theme1.withOpacity(0.7),
                                    fontSize: FetchPixels.getPixelHeight(14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: FetchPixels.getPixelHeight(10)),
                          Row(
                            children: [
                              getAssetImage(R.images.clock,
                                  scale: FetchPixels.getPixelHeight(6)),
                              getHorSpace(FetchPixels.getPixelWidth(10)),
                              Text(

                                "${(widget.model.endDate?.toDate().difference(widget.model.startDate!.toDate()).inDays)!+1} days",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(15)),
                              ),
                             SizedBox(width: 20,),
                              Text(
        DateFormat('MMM dd yyyy')
            .format(widget.model.endDate!.toDate()),
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(15)),
                              ),
                            ],
                          ),

                          Divider(),
                          SizedBox(height: FetchPixels.getPixelHeight(5)),
                          Text(
                            "Delivery Status",
                            style: R.textStyle.semiBoldMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(16)),
                          ),
                          SizedBox(height: FetchPixels.getPixelHeight(5)),


                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: FetchPixels.getPixelHeight(10),
                              horizontal: FetchPixels.getPixelWidth(10),
                            ),
                            decoration: BoxDecoration(
                              color: R.colors.g1,
                              borderRadius: BorderRadius.circular(
                                FetchPixels.getPixelHeight(5),
                              ),
                            ),
                            child:

                            InkWell(
                              onTap: (){
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return OrderStatusSelectionSheet(
                                    //   model: widget.model,
                                    //   pro: widget.pro,
                                    //   onOrderStatusSelected: (status) {
                                    //     // Update delivery_status when the order status is selected
                                    //     setState(() {
                                    //       delivery_status = status;
                                    //     });
                                    //   },
                                    // );
                                    return OrderStatusSelectionSheet(pro:pro,model: widget.model, onOrderStatusSelected: (status) {
                                      // Update delivery_status when the order status is selected
                                      setState(() {
                                        delivery_status = status;
                                      });
                                    },);
                                  },
                                );
                              },
                             child: Center(
                             child:Text(
                               delivery_status,
                               style: R.textStyle
                                   .semiBoldMetropolis()
                                   .copyWith(
                                   fontSize:
                                   FetchPixels.getPixelHeight(
                                       15),
                                   color: R.colors.whiteColor),
                             ),)
                            ),
                          ),

                          Divider(),
                          SizedBox(height: FetchPixels.getPixelHeight(10)),
                          widget.isCart != null
                              ? SizedBox()
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.productType == "custom"
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
                              widget.product.productType == "custom"
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

class OrderStatusSelectionSheet extends StatefulWidget {
  final CartModel model;

  final ProductProvider pro;
  final Function(String) onOrderStatusSelected; // Callback function

  OrderStatusSelectionSheet({super.key, required this.model, required this.pro, required this.onOrderStatusSelected});

  @override
  _OrderStatusSelectionSheetState createState() =>
      _OrderStatusSelectionSheetState();
}

class _OrderStatusSelectionSheetState extends State<OrderStatusSelectionSheet> {
  List<String> orderStatusOptions = ['Order Placed', 'Preparing', 'Out for Delivery','Delivered','Returned'];
  String selectedOrderStatus = 'Order Placed';

  void updateOrderStatus() {
    widget.onOrderStatusSelected(selectedOrderStatus);
    Navigator.pop(context); // Close the bottom sheet after updating
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProductProvider>(

        builder: (context, auth, pro, child) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Order Status',
                  style: R.textStyle.mediumMetropolis().copyWith(
                      fontSize: FetchPixels.getPixelHeight(18)),
                ),
                SizedBox(height: 16.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: orderStatusOptions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(orderStatusOptions[index],
                          style: R.textStyle.regularMetropolis().copyWith(
                              color: R.colors.blackColor.withOpacity(1),
                              fontSize: FetchPixels.getPixelHeight(15))),
                      tileColor: selectedOrderStatus ==
                          orderStatusOptions[index]
                          ? Colors.grey.withOpacity(0.5)
                          : null,
                      onTap: () {
                        setState(() {
                          selectedOrderStatus = orderStatusOptions[index];
                        });
                        // Navigator.pop(context);
                      },
                    );
                  },
                ),
                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(

                    onPressed: () async {
                      // You can perform any action with the selected order status here
                      print('Selected Order Status: $selectedOrderStatus');
                      await FirebaseFirestore.instance
                          .collection("placeOrder")
                          .doc(widget.model.docId)
                          .update({"order_status": selectedOrderStatus,
                      }).then((value) async {
                        pro.earningsList
                            .where((element) => element.docId==widget.model.docId)
                            .toList()[0].orderStatus=selectedOrderStatus;
                        widget.onOrderStatusSelected(selectedOrderStatus);
                        pro.update();
                        await FirebaseFirestore.instance
                            .collection("products")
                            .doc(widget.model.productId)
                            .update({
                          "product_type": (selectedOrderStatus == 'Returned')
                              ? 'rent'
                              : 'rented',

                        });

                        Get.snackbar(
                            backgroundColor: R.colors.theme,
                            colorText: R.colors.whiteColor,
                            "Done",
                            "Order Status updated successfully");
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Change Status'),
                  ),
                )

              ],
            ),
          );
        });
  }
}

String getInitials(String bankAccountName) => bankAccountName.isNotEmpty
    ? bankAccountName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
    : '';
