import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/custom_abaya_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';
import 'package:hunt_and_rent/widgets/table_calender.dart';
import 'package:provider/provider.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';

class SpecialTailoryForm extends StatefulWidget {
  ProductModel? productModel;

  SpecialTailoryForm({super.key, this.productModel});

  @override
  State<SpecialTailoryForm> createState() => _SpecialTailoryFormState();
}

class _SpecialTailoryFormState extends State<SpecialTailoryForm>
    with TickerProviderStateMixin {
  TextEditingController requestCT = TextEditingController();

  TextEditingController neckCT = TextEditingController();

  TextEditingController shoulderCT = TextEditingController();

  TextEditingController chestCT = TextEditingController();

  TextEditingController waistCT = TextEditingController();

  TextEditingController hipCT = TextEditingController();

  TextEditingController armLengthCT = TextEditingController();

  TextEditingController armWidthCT = TextEditingController();

  TextEditingController heightCT = TextEditingController();

  TextEditingController desCT = TextEditingController();
  TextEditingController addressCT = TextEditingController();

  TextEditingController des1CT = TextEditingController();
  TextEditingController deliveryAddressCT = TextEditingController();
  TextEditingController stateCT = TextEditingController();
  TextEditingController zipCodeCT = TextEditingController();

  bool isBooked = false;
  var timestamp =(DateTime.now().toUtc().millisecondsSinceEpoch);

  @override
  void initState() {
    var pro = Provider.of<ProductProvider>(context, listen: false);
    addressCT.text = pro.locationAddress;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabcontroller = TabController(length: 2, vsync: this);

    return Consumer2<AuthProvider, ProductProvider>(
      builder: (context, auth, pro, child) {
        List<String> option = ['Cm', 'Inch'];
        String _measurement = option[0];

        return Scaffold(
          appBar: AppBar(
              leading: Center(
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: FetchPixels.getPixelHeight(22),
                    color: R.colors.blackColor,
                  ),
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
                "Item Details",
                style: R.textStyle
                    .semiBoldMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
              )),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelWidth(20)),
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    Row(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          height: FetchPixels.getPixelHeight(260),
                          width: FetchPixels.getPixelWidth(200),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: R.colors.containerBG),
                          child: getNetworkImage(
                              widget.productModel!.productImage!.first ?? "",
                              boxFit: BoxFit.cover),
                        ),
                        getHorSpace(FetchPixels.getPixelWidth(35)),
                        SizedBox(
                          height: FetchPixels.getPixelHeight(260),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                height: FetchPixels.getPixelHeight(80),
                                width: FetchPixels.getPixelWidth(80),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: R.colors.containerBG),
                                child: getNetworkImage(
                                    widget.productModel!.productImage![0] ?? "",
                                    boxFit: BoxFit.cover),
                              ),
                              Container(
                                clipBehavior: Clip.hardEdge,
                                height: FetchPixels.getPixelHeight(80),
                                width: FetchPixels.getPixelWidth(80),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: R.colors.containerBG),
                                child: getNetworkImage(
                                    ((widget.productModel!.productImage!
                                                    .length >
                                                1)
                                            ? widget
                                                .productModel!.productImage![1]
                                            : "") ??
                                        "",
                                    boxFit: BoxFit.cover),
                              ),
                              Container(
                                clipBehavior: Clip.hardEdge,
                                height: FetchPixels.getPixelHeight(80),
                                width: FetchPixels.getPixelWidth(80),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: R.colors.containerBG),
                                child: getNetworkImage(
                                    ((widget.productModel!.productImage!
                                                    .length >
                                                2)
                                            ? widget
                                                .productModel!.productImage![2]
                                            : "") ??
                                        "",
                                    boxFit: BoxFit.cover),
                              )
                            ],
                          ),
                        ),
                        // ListView.builder(itemBuilder: itemBuilder)
                        // Expanded(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         "Layered Evening Abaya",
                        //         style: R.textStyle
                        //             .semiBoldMetropolis()
                        //             .copyWith(
                        //                 fontSize:
                        //                     FetchPixels.getPixelHeight(15)),
                        //       ),
                        //       Text(
                        //         "${widget.productModel!.productBrand} Closet",
                        //         style: R.textStyle
                        //             .mediumMetropolis()
                        //             .copyWith(
                        //                 fontSize:
                        //                     FetchPixels.getPixelHeight(15)),
                        //       ),
                        //       Text(
                        //         widget.productModel!.productDescription ??
                        //             "",
                        //         style: R.textStyle
                        //             .regularMetropolis()
                        //             .copyWith(
                        //                 fontSize:
                        //                     FetchPixels.getPixelHeight(14)),
                        //       ),
                        //       getVerSpace(FetchPixels.getPixelHeight(10)),
                        //       Text(
                        //         "${widget.productModel!.productPrice} QR",
                        //         style: R.textStyle
                        //             .semiBoldMetropolis()
                        //             .copyWith(
                        //                 fontSize:
                        //                     FetchPixels.getPixelHeight(15)),
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                    // SizedBox(
                    //   height: 250,
                    //   child: ,
                    // ),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //       vertical: FetchPixels.getPixelHeight(5),
                            //       horizontal: FetchPixels.getPixelWidth(10)),
                            //   decoration: BoxDecoration(
                            //       color: R.colors.containerBG,
                            //       borderRadius: BorderRadius.circular(
                            //           FetchPixels.getPixelHeight(5))),
                            //   child: Row(children: [
                            //     model.productType == "sell"
                            //         ? SizedBox()
                            //         : Text(
                            //             "6x",
                            //             style: R.textStyle
                            //                 .mediumMetropolis()
                            //                 .copyWith(
                            //                     fontSize:
                            //                         FetchPixels.getPixelHeight(
                            //                             12)),
                            //           ),
                            //     model.productType == "sell"
                            //         ? SizedBox()
                            //         : getHorSpace(FetchPixels.getPixelWidth(20)),
                            //     Text(
                            //       model.productType == "sell"
                            //           ? model.productType ?? ""
                            //           : "Rented",
                            //       style: R.textStyle.mediumMetropolis().copyWith(
                            //           fontSize: FetchPixels.getPixelHeight(12)),
                            //     ),
                            //   ]),
                            // ),
                            // getHorSpace(FetchPixels.getPixelWidth(10)),
                            getAssetImage(R.images.star,
                                scale: FetchPixels.getPixelWidth(3)),
                            getHorSpace(FetchPixels.getPixelWidth(5)),
                            Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(children: [
                                  TextSpan(
                                      text: "4.4",
                                      style: R.textStyle
                                          .mediumMetropolis()
                                          .copyWith(
                                              color: R.colors.blackColor
                                                  .withOpacity(0.7),
                                              fontSize:
                                                  FetchPixels.getPixelHeight(
                                                      14))),
                                  TextSpan(
                                      text: "(5)",
                                      style: R.textStyle
                                          .regularMetropolis()
                                          .copyWith(
                                              color: R.colors.blackColor
                                                  .withOpacity(0.6),
                                              fontSize:
                                                  FetchPixels.getPixelHeight(
                                                      14))),
                                ])),
                          ],
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(5)),
                        Text(
                          "Layered Evening Abaya",
                          style: R.textStyle.mediumMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(16)),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(5)),
                        Text(
                          "${widget.productModel!.productBrand} Closet",
                          style: R.textStyle.regularMetropolis().copyWith(
                              color: R.colors.blackColor.withOpacity(0.7),
                              fontSize: FetchPixels.getPixelHeight(14)),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(5)),
                        Text(
                          "${widget.productModel!.productPrice} QR",
                          style: R.textStyle.semiBoldMetropolis().copyWith(
                              color: R.colors.theme,
                              fontSize: FetchPixels.getPixelHeight(16)),
                        ),
                        Divider(height: 20),
                        Text(
                          widget.productModel!.productDescription ?? "",
                          style: R.textStyle.regularMetropolis().copyWith(
                              color: R.colors.blackColor.withOpacity(0.7),
                              fontSize: FetchPixels.getPixelHeight(14)),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(10)),
                      ],
                    ),

                    // DefaultTabController(
                    //   length: 2,
                    //   child: Column(
                    //     children: [
                    //       Material(
                    //         child: TabBar(tabs: [
                    //           Tab(
                    //             text: 'Measurements',
                    //           ),
                    //           Tab(
                    //             text: 'Book a Tailor',
                    //           )
                    //         ]),
                    //       ),
                    //       SizedBox(
                    //         child: TabBarView(
                    //             children: [Text("hii"), Text("hii")]),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // TabBarView(children: [Text("hii"), Text("hii")])

                    Material(
                      color: R.colors.containerBG1,
                      child: TabBar(
                          indicatorColor: R.colors.theme,
                          indicator: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2, color: R.colors.theme)),
                              color: R.colors.theme.withOpacity(0.2)),
                          indicatorSize: TabBarIndicatorSize.tab,
                          // overlayColor:
                          //     MaterialStatePropertyAll(R.colors.whiteColor),
                          // indicatorPadding: EdgeInsets.all(10),
                          unselectedLabelColor: R.colors.blackColor,
                          unselectedLabelStyle: R.textStyle
                              .regularMetropolis()
                              .copyWith(
                                  fontSize: FetchPixels.getPixelHeight(14)),
                          labelColor: R.colors.theme,
                          labelStyle: R.textStyle.mediumMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(14)),
                          dividerHeight: 0,
                          controller: _tabcontroller,
                          tabs: [
                            Tab(child: Text('Measurements')

                                // Text(
                                //   "Measurements",
                                //   style: R.textStyle.mediumMetropolis().copyWith(
                                //       fontSize: FetchPixels.getPixelHeight(14)),
                                // ),
                                ),
                            Tab(
                              child: Text("Book a Tailor"),
                            )
                          ]),
                    ),

                    SizedBox(
                      height: 500,
                      child: TabBarView(controller: _tabcontroller, children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            Text(
                              "Put in your measurements to get your customized ready Abaya directly at your doorstep.",
                              style: R.textStyle.regularMetropolis().copyWith(
                                  fontSize: FetchPixels.getPixelHeight(14)),
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            Text(
                              "Enter Your measurements in : ",
                              style: R.textStyle.regularMetropolis().copyWith(
                                  fontSize: FetchPixels.getPixelHeight(15)),
                            ),
                            RadioListTile(
                              title: Text('Cm'),
                              value: option[0],
                              groupValue: _measurement,
                              onChanged: (value) {
                                setState(() {
                                  _measurement = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('Inch'),
                              value: option[1],
                              groupValue: _measurement,
                              onChanged: (value) {
                                setState(() {
                                  _measurement = value.toString();
                                });
                              },
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: FetchPixels.getPixelWidth(100),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Neck:",
                                              style: R.textStyle
                                                  .regularMetropolis()
                                                  .copyWith(
                                                      fontSize: FetchPixels
                                                          .getPixelHeight(15),
                                                      color: R.colors.blackColor
                                                          .withOpacity(0.7)),
                                            ),
                                            SizedBox(
                                              height:
                                                  FetchPixels.getPixelHeight(
                                                      40),
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: neckCT,
                                                cursorColor:
                                                    R.colors.blackColor,
                                                textInputAction:
                                                    TextInputAction.next,
                                                style: R.textStyle
                                                    .regularMetropolis()
                                                    .copyWith(
                                                        fontSize: FetchPixels
                                                            .getPixelHeight(15),
                                                        color: R
                                                            .colors.blackColor),
                                                decoration: InputDecoration(
                                                    hintText: '000',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                              ),
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      width: FetchPixels.getPixelWidth(100),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Shoulder:",
                                              style: R.textStyle
                                                  .regularMetropolis()
                                                  .copyWith(
                                                      fontSize: FetchPixels
                                                          .getPixelHeight(15),
                                                      color: R.colors.blackColor
                                                          .withOpacity(0.7)),
                                            ),
                                            SizedBox(
                                              height:
                                                  FetchPixels.getPixelHeight(
                                                      40),
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: shoulderCT,
                                                cursorColor:
                                                    R.colors.blackColor,
                                                textInputAction:
                                                    TextInputAction.next,
                                                style: R.textStyle
                                                    .regularMetropolis()
                                                    .copyWith(
                                                        fontSize: FetchPixels
                                                            .getPixelHeight(15),
                                                        color: R
                                                            .colors.blackColor),
                                                decoration: InputDecoration(
                                                    hintText: '000',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                              ),
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      width: FetchPixels.getPixelWidth(100),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Chest:",
                                              style: R.textStyle
                                                  .regularMetropolis()
                                                  .copyWith(
                                                      fontSize: FetchPixels
                                                          .getPixelHeight(15),
                                                      color: R.colors.blackColor
                                                          .withOpacity(0.7)),
                                            ),
                                            SizedBox(
                                              height:
                                                  FetchPixels.getPixelHeight(
                                                      40),
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: chestCT,
                                                cursorColor:
                                                    R.colors.blackColor,
                                                textInputAction:
                                                    TextInputAction.next,
                                                style: R.textStyle
                                                    .regularMetropolis()
                                                    .copyWith(
                                                        fontSize: FetchPixels
                                                            .getPixelHeight(15),
                                                        color: R
                                                            .colors.blackColor),
                                                decoration: InputDecoration(
                                                    hintText: '000',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                                getVerSpace(FetchPixels.getPixelHeight(10)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: FetchPixels.getPixelWidth(100),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Waist:",
                                              style: R.textStyle
                                                  .regularMetropolis()
                                                  .copyWith(
                                                      fontSize: FetchPixels
                                                          .getPixelHeight(15),
                                                      color: R.colors.blackColor
                                                          .withOpacity(0.7)),
                                            ),
                                            SizedBox(
                                              height:
                                                  FetchPixels.getPixelHeight(
                                                      40),
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: waistCT,
                                                cursorColor:
                                                    R.colors.blackColor,
                                                textInputAction:
                                                    TextInputAction.next,
                                                style: R.textStyle
                                                    .regularMetropolis()
                                                    .copyWith(
                                                        fontSize: FetchPixels
                                                            .getPixelHeight(15),
                                                        color: R
                                                            .colors.blackColor),
                                                decoration: InputDecoration(
                                                    hintText: '000',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                              ),
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      width: FetchPixels.getPixelWidth(100),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Hip:",
                                              style: R.textStyle
                                                  .regularMetropolis()
                                                  .copyWith(
                                                      fontSize: FetchPixels
                                                          .getPixelHeight(15),
                                                      color: R.colors.blackColor
                                                          .withOpacity(0.7)),
                                            ),
                                            SizedBox(
                                              height:
                                                  FetchPixels.getPixelHeight(
                                                      40),
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: hipCT,
                                                cursorColor:
                                                    R.colors.blackColor,
                                                textInputAction:
                                                    TextInputAction.next,
                                                style: R.textStyle
                                                    .regularMetropolis()
                                                    .copyWith(
                                                        fontSize: FetchPixels
                                                            .getPixelHeight(15),
                                                        color: R
                                                            .colors.blackColor),
                                                decoration: InputDecoration(
                                                    hintText: '000',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                              ),
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      width: FetchPixels.getPixelWidth(100),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Arm length:",
                                              style: R.textStyle
                                                  .regularMetropolis()
                                                  .copyWith(
                                                      fontSize: FetchPixels
                                                          .getPixelHeight(15),
                                                      color: R.colors.blackColor
                                                          .withOpacity(0.7)),
                                            ),
                                            SizedBox(
                                              height:
                                                  FetchPixels.getPixelHeight(
                                                      40),
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: armLengthCT,
                                                cursorColor:
                                                    R.colors.blackColor,
                                                textInputAction:
                                                    TextInputAction.next,
                                                style: R.textStyle
                                                    .regularMetropolis()
                                                    .copyWith(
                                                        fontSize: FetchPixels
                                                            .getPixelHeight(15),
                                                        color: R
                                                            .colors.blackColor),
                                                decoration: InputDecoration(
                                                    hintText: '000',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                                getVerSpace(FetchPixels.getPixelHeight(10)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: FetchPixels.getPixelWidth(100),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Arm width:",
                                              style: R.textStyle
                                                  .regularMetropolis()
                                                  .copyWith(
                                                      fontSize: FetchPixels
                                                          .getPixelHeight(15),
                                                      color: R.colors.blackColor
                                                          .withOpacity(0.7)),
                                            ),
                                            SizedBox(
                                              height:
                                                  FetchPixels.getPixelHeight(
                                                      40),
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: armWidthCT,
                                                cursorColor:
                                                    R.colors.blackColor,
                                                textInputAction:
                                                    TextInputAction.next,
                                                style: R.textStyle
                                                    .regularMetropolis()
                                                    .copyWith(
                                                        fontSize: FetchPixels
                                                            .getPixelHeight(15),
                                                        color: R
                                                            .colors.blackColor),
                                                decoration: InputDecoration(
                                                    hintText: '000',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                              ),
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                        width: FetchPixels.getPixelWidth(20)),
                                    SizedBox(
                                      width: FetchPixels.getPixelWidth(100),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Height:",
                                              style: R.textStyle
                                                  .regularMetropolis()
                                                  .copyWith(
                                                      fontSize: FetchPixels
                                                          .getPixelHeight(15),
                                                      color: R.colors.blackColor
                                                          .withOpacity(0.7)),
                                            ),
                                            SizedBox(
                                              height:
                                                  FetchPixels.getPixelHeight(
                                                      40),
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: heightCT,
                                                cursorColor:
                                                    R.colors.blackColor,
                                                textInputAction:
                                                    TextInputAction.next,
                                                style: R.textStyle
                                                    .regularMetropolis()
                                                    .copyWith(
                                                        fontSize: FetchPixels
                                                            .getPixelHeight(15),
                                                        color: R
                                                            .colors.blackColor),
                                                decoration: InputDecoration(
                                                    hintText: '000',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                                getVerSpace(FetchPixels.getPixelHeight(20)),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Book a Tailor to be sent to your home.",
                                  style: R.textStyle
                                      .regularMetropolis()
                                      .copyWith(
                                          fontSize:
                                              FetchPixels.getPixelHeight(15)),
                                ),
                                Spacer(),
                                Switch(
                                    activeColor: R.colors.theme,
                                    value: isBooked,
                                    onChanged: (value) {
                                      setState(() {
                                        isBooked = value;
                                      });
                                    }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(2, (index) {
                                return gender(index, auth);
                              }),
                            ),
                            SizedBox(
                                height: FetchPixels.getPixelHeight(350),
                                child: CalendarScreen1()),
                            // Row(
                            //   children: [
                            //     Checkbox(
                            //       tristate: true,
                            //       value: isBooked = false,
                            //       onChanged: (bool? value) {
                            //         setState(() {
                            //           isBooked = value!;
                            //         });
                            //       },
                            //     )
                            //   ],
                            // ),

                            // isBooked
                            //     ? Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: List.generate(2, (index) {
                            //           return gender(index, auth);
                            //         }),
                            //       )
                            //     : SizedBox(),
                            // isBooked
                            //     ? SizedBox(
                            //         height: FetchPixels.getPixelHeight(450),
                            //         child: CalendarScreen1())
                            //     : SizedBox(),
                            // isBooked
                            //     ? SizedBox()
                            //     : Row(
                            //         children: [
                            //           Checkbox(
                            //             tristate: true,
                            //             value: isBooked = false,
                            //             onChanged: (bool? value) {
                            //               setState(() {
                            //                 isBooked = value!;
                            //               });
                            //             },
                            //           )
                            //         ],
                            //       ),
                          ], //upinside
                        ),
                      ]),
                    ),

                    Text(
                      "Enter your Address for Delivery",
                      style: R.textStyle
                          .mediumMetropolis()
                          .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    Text(
                      "Address",
                      style: R.textStyle.regularMetropolis().copyWith(
                          color: R.colors.blackColor.withOpacity(0.7),
                          fontSize: FetchPixels.getPixelHeight(14)),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: addressCT,
                      cursorColor: R.colors.blackColor,
                      textInputAction: TextInputAction.next,
                      style: R.textStyle.regularMetropolis().copyWith(
                          height: 1,
                          fontSize: FetchPixels.getPixelHeight(16),
                          color: R.colors.blackColor),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ).copyWith(
                          suffixIcon: InkWell(
                              onTap: () async {
                                setState(() {});
                              },
                              child: Icon(
                                Icons.location_on_rounded,
                                color: R.colors.theme,
                              ))),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "State",
                              style: R.textStyle.regularMetropolis().copyWith(
                                  color: R.colors.blackColor.withOpacity(0.7),
                                  fontSize: FetchPixels.getPixelHeight(14)),
                            ),
                            SizedBox(
                              width: FetchPixels.getPixelWidth(150),
                              // height: FetchPixels.getPixelHeight(50),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: stateCT,
                                cursorColor: R.colors.blackColor,
                                textInputAction: TextInputAction.next,
                                style: R.textStyle.regularMetropolis().copyWith(
                                    height: 1,
                                    fontSize: FetchPixels.getPixelHeight(16),
                                    color: R.colors.blackColor),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Zip Code",
                              style: R.textStyle.regularMetropolis().copyWith(
                                  color: R.colors.blackColor.withOpacity(0.7),
                                  fontSize: FetchPixels.getPixelHeight(14)),
                            ),
                            SizedBox(
                              width: FetchPixels.getPixelWidth(150),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: zipCodeCT,
                                cursorColor: R.colors.blackColor,
                                textInputAction: TextInputAction.next,
                                style: R.textStyle.regularMetropolis().copyWith(
                                    height: 1,
                                    fontSize: FetchPixels.getPixelHeight(16),
                                    color: R.colors.blackColor),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(55)),

                    ///
                    pro.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                            color: R.colors.theme,
                          ))
                        : MyButton(
                            onTap: () async {
                              pro.startLoader();
                              CustomAbayaModel customAbayaModel =
                                  CustomAbayaModel(
                                docId: timestamp,
                                productType:
                                    "${widget.productModel!.subCategoryName}",
                                productDescription: desCT.text,
                                productGender: auth.selectedGender == 0
                                    ? "Male"
                                    : "Female",
                                productId: "${widget.productModel!.docId}",
                                productName:
                                    "${widget.productModel!.productName}",
                                productTailor: des1CT.text,
                                userArmLength: armLengthCT.text,
                                userArmWidth: armWidthCT.text,
                                userChest: chestCT.text,
                                userHeight: heightCT.text,
                                userHips: hipCT.text,
                                userNeck: neckCT.text,
                                userShoulder: shoulderCT.text,
                                userWaist: waistCT.text,
                                      deliveryAddress: deliveryAddressCT.text,
                                      state: stateCT.text,
                                      zipCode: zipCodeCT.text,
                                userId: "${auth.userModel.email}",
                                vendarId: "${widget.productModel!.email}",
                                tailorBookingDate:
                                    Timestamp.fromDate(auth.datesTimes1),
                                    price: widget.productModel!.productPrice,
                                    orderStatus: "Active",
                                    customerName:auth.userModel.fullName,
                              );
                              //Updating the model.
                              pro.bookingsList = [customAbayaModel];

                              await FirebaseFirestore.instance
                                  .collection("customAbaya")
                                  .doc('$timestamp')
                                  .set(customAbayaModel.toJson())
                                  .then((value) async {

                                pro.stopLoader();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Your Booking is done"),
                                ));
                                Navigator.pop(context);
                              });
                            },
                            buttonText: "Book Now")

                    ///
                  ]),
            ),
          ),
        );
      },
    );
  }

  gender(index, AuthProvider auth) {
    return getPaddingWidget(
      EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(5)),
      Row(
        children: [
          Text(
            index == 0 ? "Male" : "Female",
            style: R.textStyle
                .regularMetropolis()
                .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
          ),
          getHorSpace(FetchPixels.getPixelWidth(10)),
          InkWell(
            onTap: () {
              auth.selectedGender = index;
              auth.update();
            },
            child: Container(
              height: FetchPixels.getPixelHeight(25),
              width: FetchPixels.getPixelWidth(25),
              decoration: BoxDecoration(
                  border: Border.all(color: R.colors.theme),
                  color: auth.selectedGender == index
                      ? R.colors.theme
                      : R.colors.transparent,
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(4))),
              child: Icon(
                Icons.check,
                color: auth.selectedGender == index
                    ? R.colors.whiteColor
                    : R.colors.transparent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
