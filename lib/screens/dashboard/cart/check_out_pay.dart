import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/cart/payment_success_page.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../dialog/on_tap_dialog.dart';
import '../../../resources/resources.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/my_button.dart';
import '../home/model/category_model.dart';
import '../home/model/product_model.dart';
import '../home/widgets/featured_product_widget.dart';
import '../profile/pages/fatora_pay.dart';
import 'model/cart_model.dart';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  TextEditingController deliveryAddressTC = TextEditingController();
  List<String> paymentImages = [
    R.images.cardLogo,
    // R.images.credit,
    R.images.cash,
    // R.images.huntPay,
  ];
  List<String> payName = [
    "Debit/MasterCard",
    // "Credit Card",
    "Cash on Delivery",
  ];
  int currentPay = 0;
  int currentSelected = 0;
  var total = 0;

  addTotalValue() {
    var pro = Provider.of<ProductProvider>(context, listen: false);
    var auth = Provider.of<AuthProvider>(context, listen: false);
    for (var i = 0;
        i <
            pro.products
                .where((element) => auth.cartDocList.contains(element.docId))
                .length;
        i++) {
      total = total +
          int.parse(pro.products
              .where((element) => auth.cartDocList.contains(element.docId))
              .toList()[i]
              .productPrice!);
      print("total $total");
    }
  }

  @override
  void initState() {
    addTotalValue();
    deliveryAddressTC.text="";
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var timestamp =(DateTime.now().toUtc().millisecondsSinceEpoch);
    return Consumer2<ProductProvider, AuthProvider>(
        builder: (context, pro, auth, child) {
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
            centerTitle: true,
            title: Text(
              "Checkout",
              style: R.textStyle
                  .mediumMetropolis()
                  .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: pro.products
                    .where(
                        (element) => auth.cartDocList.contains(element.docId))
                    .length,
                padding: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelWidth(20)),
                itemBuilder: (context, index) {
                  ProductModel model = pro.products
                      .where(
                          (element) => auth.cartDocList.contains(element.docId))
                      .toList()[index];
                  return Card(
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(16),
                    //     side: BorderSide(color: R.colors.g1)),
                    // borderOnForeground: true,
                    color: R.colors.whiteColor,
                    elevation: 0.4,
                    shadowColor: R.colors.containerBG1,
                    child: FeaturedWidget1(
                      model: model,
                      isCart: true,
                      index1: index,
                    ),
                  );
                },
              ),
              ListView(
                primary: true,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelWidth(20)),
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  // ListTile(
                  //   contentPadding: EdgeInsets.zero,
                  //   leading: getAssetImage(R.images.locationIcon,
                  //       scale: FetchPixels.getPixelHeight(3)),
                  //   title: Text(
                  //     "My Home Address",
                  //     style: R.textStyle
                  //         .mediumMetropolis()
                  //         .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                  //   ),
                  //   subtitle: Text(
                  //     "${pro.locationAddress}",
                  //     style: R.textStyle
                  //         .regularMetropolis()
                  //         .copyWith(fontSize: FetchPixels.getPixelHeight(12)),
                  //   ),
                  // ),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: getAssetImage(R.images.locationIcon,
                          scale: FetchPixels.getPixelHeight(3)),
                      title: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        controller: deliveryAddressTC,
                        validator: (value) {},
                        scribbleEnabled: true,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          label: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Enter Your Address',
                              style: R.textStyle.regularMetropolis().copyWith(
                                  fontSize: FetchPixels.getPixelHeight(14)),
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          isCollapsed: true,
                        ),
                      )),
                  // Container(
                  //   height: FetchPixels.getPixelHeight(250),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(16),
                  //     child: GoogleMap(
                  //       initialCameraPosition: CameraPosition(
                  //           target: LatLng(
                  //               double.parse(pro.lat), double.parse(pro.lng)),
                  //           zoom: 11),
                  //       mapType: MapType.normal,
                  //       scrollGesturesEnabled: true,
                  //       zoomControlsEnabled: true,
                  //       zoomGesturesEnabled: true,
                  //       myLocationEnabled: true,
                  //       myLocationButtonEnabled: true,
                  //       onTap: (latLng) {
                  //         pro.lat = latLng.latitude.toString();
                  //         pro.lng = latLng.longitude.toString();
                  //         pro.markers.clear();
                  //         pro.markers.add(
                  //           Marker(
                  //             markerId: MarkerId('marker_1'),
                  //             position: LatLng(
                  //                 double.parse(pro.lat), double.parse(pro.lng)),
                  //             infoWindow:
                  //                 InfoWindow(title: "${pro.locationAddress}"),
                  //             icon: BitmapDescriptor.defaultMarkerWithHue(
                  //                 BitmapDescriptor.hueViolet),
                  //           ),
                  //         );
                  //         pro.fetchLocationAddress();
                  //         pro.notifyListeners();
                  //       },
                  //       onMapCreated: (GoogleMapController controller) {
                  //         // _controller.complete(controller);
                  //       },
                  //       markers: Set<Marker>.of(pro.markers),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              ListView(
                primary: true,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelWidth(20)),
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: getAssetImage(R.images.clock,
                        scale: FetchPixels.getPixelHeight(3)),
                    title: Text(
                      "Within 1 Day",
                      style: R.textStyle
                          .mediumMetropolis()
                          .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: getAssetImage(R.images.reward,
                        scale: FetchPixels.getPixelHeight(3)),
                    title: Text(
                      "Reward your rider with a tip",
                      style: R.textStyle
                          .mediumMetropolis()
                          .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                    ),
                    subtitle: Text(
                      "Your rider keeps 100% of the tips",
                      style: R.textStyle.regularMetropolis().copyWith(
                          color: R.colors.blackColor.withOpacity(0.6),
                          fontSize: FetchPixels.getPixelHeight(12)),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "If you want to give tips on your rider?",
                      style: R.textStyle.regularMetropolis().copyWith(
                          color: R.colors.theme,
                          fontSize: FetchPixels.getPixelHeight(14)),
                    ),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  Text(
                    "Pay with",
                    style: R.textStyle
                        .mediumMetropolis()
                        .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  Column(
                    children: List.generate(2, (index) {
                      return pay(index);
                    }),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  // Text(
                  //   "Items Summary",
                  //   style: R.textStyle
                  //       .semiBoldMetropolis()
                  //       .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
                  // ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: List.generate(
                  //       pro.products
                  //           .where((element) =>
                  //               auth.cartDocList.contains(element.docId))
                  //           .length, (index) {
                  //     ProductModel model = pro.products
                  //         .where((element) =>
                  //             auth.cartDocList.contains(element.docId))
                  //         .toList()[index];
                  //     return Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Row(
                  //         children: [
                  //           Text(
                  //             "${index + 1} : ",
                  //             style: R.textStyle.regularMetropolis().copyWith(
                  //                 fontSize: FetchPixels.getPixelHeight(15)),
                  //           ),
                  //           Text(
                  //             "${model.productName}",
                  //             style: R.textStyle.regularMetropolis().copyWith(
                  //                 fontSize: FetchPixels.getPixelHeight(15)),
                  //           ),
                  //           Spacer(),
                  //           Text(
                  //             "QR ${model.productPrice}",
                  //             style: R.textStyle.regularMetropolis().copyWith(
                  //                 fontSize: FetchPixels.getPixelHeight(15)),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   }),
                  // ),
                  Text(
                    "Payment Summary",
                    style: R.textStyle
                        .mediumMetropolis()
                        .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Basket Total",
                        style: R.textStyle
                            .regularMetropolis()
                            .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
                      ),
                      Text(
                        "QR $total.00",
                        style: R.textStyle
                            .mediumMetropolis()
                            .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
                      ),
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Fee",
                        style: R.textStyle
                            .regularMetropolis()
                            .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
                      ),
                      Text(
                        "QR 10.00",
                        style: R.textStyle
                            .mediumMetropolis()
                            .copyWith(fontSize: FetchPixels.getPixelHeight(15)),
                      ),
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dry Cleaning Fee",
                        style: R.textStyle
                            .regularMetropolis()
                            .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
                      ),
                      Text(
                        "QR 5.00",
                        style: R.textStyle
                            .mediumMetropolis()
                            .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
                      ),
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  DottedLine(
                    dashLength: 10,
                    lineThickness: 2,
                    dashColor: R.colors.fillColor,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: FetchPixels.getPixelWidth(10)),
                    height: FetchPixels.getPixelHeight(50),
                    width: FetchPixels.width,
                    decoration: BoxDecoration(
                        color: R.colors.whiteColor,
                        borderRadius: BorderRadius.circular(
                            FetchPixels.getPixelHeight(5))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: R.textStyle.mediumMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(16)),
                          ),
                          Text(
                            "QR ${total + 15}.00",
                            style: R.textStyle.semiBoldMetropolis().copyWith(
                                color: R.colors.theme,
                                fontSize: FetchPixels.getPixelHeight(17)),
                          ),
                        ]),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text:
                          "By placing the order you agree to the Credit Card Payment Terms and Conditions",
                      style: R.textStyle.regularMetropolis().copyWith(
                          fontSize: FetchPixels.getPixelHeight(12),
                          color: R.colors.blackColor.withOpacity(0.5)),
                    ),
                    TextSpan(
                      text: "Terms and Conditions",
                      style: R.textStyle.regularMetropolis().copyWith(
                          fontSize: FetchPixels.getPixelHeight(14),
                          color: R.colors.theme),
                    ),
                  ])),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  MyButton(
                      onTap: () {
                        if (currentPay == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return FatoraPay(
                                  currencyCode: 'QAR',
                                  // Pass your desired values here
                                  amount: total + 15,
                                  customerEmail: '${auth.userModel.email}',
                                  customerName: '${auth.userModel.userName}',
                                  customerPhone: '1234567890',
                                  customerCountry: 'LK',
                                  lang: 'en',
                                  note: 'This is a test note',
                                );
                              },
                            ),
                          );
                        } else {
                          Get.dialog(OnTapFunctionDialog(
                            onTap: () async {
                              for (int i = 0;
                                  i < auth.userModel.cart!.length;
                                  i++) {
                                CartModel cartModel = CartModel(
                                  productId: auth.userModel.cart![i].productId,
                                  docId: "",
                                  productPrice: pro.products
                                      .where((element) =>
                                          element.docId == auth.cartDocList[i])
                                      .first
                                      .productPrice,
                                  color:pro.products
                                      .where((element) =>
                                  element.docId == auth.cartDocList[i])
                                      .first
                                      .productColors?[auth.selectedColor],
                                    size:pro.products
                                        .where((element) =>
                                    element.docId == auth.cartDocList[i])
                                        .first
                                        .productSize?[auth.selectedSize],
                                  customerId: auth.userModel.email,
                                  customerName: auth.userModel.fullName,
                                  vendorId: pro.products
                                      .where((element) =>
                                          element.docId == auth.cartDocList[i])
                                      .first
                                      .email,
                                  startDate: auth.userModel.cart![i].startDate!,
                                  endDate: auth.userModel.cart![i].endDate!,
                                  orderStatus: OrderStatus.Active.name,
                                  submitStatus: "",
                                  deliveryAddress: deliveryAddressTC.text,
                                    paymentMethod:payName[currentPay]
                                );
                                await FirebaseFirestore.instance
                                    .collection("placeOrder")
                                    .doc('$timestamp')
                                    .set(cartModel.toJson())
                                    .then((value) async {
                                  await FirebaseFirestore.instance
                                      .collection("placeOrder")
                                      .doc('$timestamp')
                                      .update({"doc_id": timestamp, "id":timestamp});
                                });
                                if (pro.products
                                        .where((element) => auth.cartDocList
                                            .contains(element.docId))
                                        .toList()[i]
                                        .productType ==
                                    ProductsTypes.custom.name) {
                                  await FirebaseFirestore.instance
                                      .collection("products")
                                      .doc(auth.userModel.cart![i].productId)
                                      .update({
                                    "product_type": ProductsTypes.sold.name
                                  });
                                } else {
                                  await FirebaseFirestore.instance
                                      .collection("products")
                                      .doc(auth.userModel.cart![i].productId)
                                      .update({
                                    "product_type": ProductsTypes.rented.name
                                  });
                                }
                              }
                              auth.userModel.cart!.clear();
                              auth.updateUser(auth.userModel);


                              pro.getEarningRecord();
                              Get.to(() => PaymentSuccessPage(total: '$total', payment_method:payName[currentPay], timestamp: '$timestamp',));
                              // Get.toNamed(Routes.paymentDetails);
                            },
                            text: "Are You Sure You Want to Place This Order?",
                            headingText: "Order Confirmation!",
                          ));
                        }
                      },
                      buttonText: "Place Your Order"),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  tip(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: FetchPixels.getPixelHeight(35),
        width: FetchPixels.getPixelWidth(100),
        decoration: BoxDecoration(
            color: R.colors.containerBG,
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(5))),
        child: Center(
            child: Text(
          index == 0
              ? "QR 5"
              : index == 1
                  ? "QR 10"
                  : "Others",
          style: R.textStyle.regularMetropolis().copyWith(
              fontSize: FetchPixels.getPixelHeight(16),
              color: R.colors.blackColor),
        )),
      ),
    );
  }

  pay(index) {
    return getPaddingWidget(
      EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(8)),
      InkWell(
        onTap: () {
          currentPay = index;
          print(currentPay);
          setState(() {});
        },
        child: Container(
          height: FetchPixels.getPixelHeight(50),
          padding:
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(10)),
          decoration: BoxDecoration(
              color: R.colors.containerBG1,
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(9))),
          child: Row(
            children: [
              Container(
                height: FetchPixels.getPixelHeight(25),
                width: FetchPixels.getPixelWidth(25),
                decoration: BoxDecoration(
                    color: R.colors.whiteColor, shape: BoxShape.circle),
                child: Center(
                  child: Container(
                    height: FetchPixels.getPixelHeight(15),
                    width: FetchPixels.getPixelWidth(15),
                    decoration: BoxDecoration(
                        color: currentPay == index
                            ? R.colors.theme
                            : R.colors.whiteColor,
                        shape: BoxShape.circle),
                  ),
                ),
              ),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              getAssetImage(paymentImages[index],
                  scale: FetchPixels.getPixelHeight(4)),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              Text(
                payName[index],
                style: R.textStyle
                    .regularMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
