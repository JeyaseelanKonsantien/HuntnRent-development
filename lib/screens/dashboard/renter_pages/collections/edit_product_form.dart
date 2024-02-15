import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file/src/types/interface.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/utils/validator.dart';
import 'package:hunt_and_rent/widgets/table_calender.dart';
import 'package:provider/provider.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';
import '../../../../widgets/app_dropdown.dart';
import '../../../../widgets/app_dropdown1.dart';
import '../../../../widgets/my_button.dart';

class EditProductForm extends StatefulWidget {

  ProductModel model;


  EditProductForm({super.key,  required this.model});

  @override
  State<EditProductForm> createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController retailPriceTC = TextEditingController();
  TextEditingController itemNameTC = TextEditingController();
  TextEditingController descriptionTC = TextEditingController();
  TextEditingController selectDateTC = TextEditingController();
  TextEditingController additionalTC = TextEditingController();
  TextEditingController rentalPriceTC = TextEditingController();
  ExpandableController categoryECT = ExpandableController();
  TextEditingController categoryCT = TextEditingController();
  List<String> categoryList = [
    "Male",
    "Female",
  ];

  ExpandableController occasionECT = ExpandableController();
  TextEditingController occasionCT = TextEditingController();
  List<String> occasionList = [
    "party",
    "wedding",
    "functions",
  ];

  ExpandableController sizeECT = ExpandableController();
  TextEditingController sizeCT = TextEditingController();
  List<String> sizeList = [
    "Small",
    "Medium",
    "Large",
    "Extra Large",
  ];

  ExpandableController daysECT = ExpandableController();
  TextEditingController daysCT = TextEditingController();
  List<String> daysList = [
    "1",
    "2",
    "3",
    "4",
    "5",
  ];

  ExpandableController rentECT = ExpandableController();
  TextEditingController rentCT = TextEditingController();
  List<String> rentList = [
    "rent",
    "custom",
  ];

  ExpandableController brandECT = ExpandableController();
  TextEditingController brandCT = TextEditingController();
  List<String> brandList = [
    "Breakout",
    "Gul Ahmed",
    "Outfitters",
    "Beechtree",
    "Moaciani",
    "Diner",
  ];

  ExpandableController colorECT = ExpandableController();
  TextEditingController colorCT = TextEditingController();

  // create some values
  Color pickerColor = Color(0xff443a49);
  List<dynamic> inHexValues = [];
  String hexValue1 = "0";
  List<int> dates = [1, 3, 7, 14];

  Color currentColor = Color(0xff443a49);

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
      hexValue1 = colorToHex(pickerColor);
      print("this is f: ${hexValue1.replaceAll('#', '0xff')}");
    });
  }

  List<dynamic> selectedSize = [];

  @override
  void initState() {
    var c = Provider.of<ProductProvider>(context, listen: false);

    c.getMajorCatNames();
    c.getSubCatNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    itemNameTC.text=widget.model.productName!;
    rentalPriceTC.text=widget.model.productPrice!;
    descriptionTC.text=widget.model.productDescription!;
    additionalTC.text=widget.model.additionalInstructions!;
    sizeCT.text==widget.model.productSize!;
    categoryCT.text=widget.model.categoryName!;
    occasionCT.text=widget.model.subCategoryName!;
    brandCT.text=widget.model.productBrand!;
    rentCT.text=widget.model.productType!;

    if(rentCT.text == "rent") {
      hexValue1 = widget.model.productColors?[0].replaceAll('0xff', '#');
    }else{
      inHexValues = widget.model.productColors!;
    }




    if(rentCT.text == "rent") {
    sizeCT.text = widget.model.productSize?[0];
    }else{
    selectedSize = widget.model.productSize!;
    }

    return Consumer2<AuthProvider, ProductProvider>(
      builder: (context, auth, product, child) {

        // List<XFile> pickedImages1 = await productList.pickMultiImage();
        //
        // listOfImages = pickedImages1;


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
              title: Text(
                "Edit Listing",
                style: R.textStyle
                    .semiBoldMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
              )),
          body: Form(
            key: formKey,
            child: ListView(
                padding: EdgeInsets.all(FetchPixels.getPixelHeight(10)),
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  InkWell(
                    onTap: () {
                      auth.getListImages().then((value) async {
                        // print("This is Urls ${MyUrls}");
                      });
                      auth.update();
                    },
                    child: Container(
                      height: FetchPixels.getPixelHeight(100),
                      width: FetchPixels.width,
                      decoration: BoxDecoration(
                          color: R.colors.containerBG,
                          borderRadius: BorderRadius.circular(
                              FetchPixels.getPixelHeight(15))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Upload 3-5 clear pictures of the item\nyou would like to offer to rent.",
                              textAlign: TextAlign.center,
                              style: R.textStyle.regularMetropolis().copyWith(
                                  fontSize: FetchPixels.getPixelHeight(16),
                                  color: R.colors.blackColor),
                            ),
                            getAssetImage(R.images.upload,
                                scale: FetchPixels.getPixelHeight(15))
                          ]),
                    ),
                  ),
                  auth.listOfImages.isEmpty
                      ? SizedBox()
                      : getVerSpace(FetchPixels.getPixelHeight(10)),
                  auth.listOfImages.isEmpty
                      ? SizedBox()
                      : SizedBox(
                          height: FetchPixels.getPixelHeight(100),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: auth.listOfImages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          FetchPixels.getPixelHeight(5)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        FetchPixels.getPixelHeight(20)),
                                  ),
                                  width: FetchPixels.getPixelWidth(80),
                                  child: Image.file(
                                    File((auth.listOfImages[index].path)),
                                    fit: BoxFit.cover,
                                  ));
                            },
                          ),
                        ),

                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  // Text(
                  //   "Item Name:",
                  //   style: R.textStyle
                  //       .mediumMetropolis()
                  //       .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                  // ),
                  TextFormField(
                    cursorColor: R.colors.theme,
                    validator: (value) =>
                        FieldValidator.validateItemName(value!),
                    controller: itemNameTC,
                    keyboardType: TextInputType.text,
                    style: R.textStyle.regularMetropolisItalic(),
                    textInputAction: TextInputAction.next,
                    decoration: R.decorations
                        .textFormFieldDecoration(null, "item name")
                        .copyWith(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: R.colors.g1,
                            )),
                            hintStyle:
                                TextStyle(fontSize: 14, color: R.colors.theme)),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   "Category:",
                          //   style: R.textStyle.mediumMetropolis().copyWith(
                          //       fontSize: FetchPixels.getPixelHeight(16)),
                          // ),
                          // getVerSpace(FetchPixels.getPixelHeight(5)),
                          DropDownDynamicWidget(
                            heading: "Category",
                            selectedWord: categoryCT.text,
                            dropDownItems: product.majorCatNameList,
                            controller: categoryECT,
                            onSelect: (value) {
                              if (kDebugMode) {
                                print(value);
                              }
                              categoryCT.text = value;
                              setState(() {});
                              // product.subCatList.clear();
                              product.subCatNameList.clear();
                              product.update();
                              for (var i = 0;
                                  i <
                                      product.subCatList
                                          .where((element) =>
                                              element.categoryId ==
                                              product.majorCatList
                                                  .where((element1) =>
                                                      element1.catName ==
                                                      categoryCT.text)
                                                  .first
                                                  .docId)
                                          .length;
                                  i++) {
                                product.subCatNameList.add(product.subCatList
                                    .where((element) =>
                                        element.categoryId ==
                                        product.majorCatList
                                            .where((element1) =>
                                                element1.catName ==
                                                categoryCT.text)
                                            .first
                                            .docId)
                                    .toList()[i]
                                    .categoryName!);
                                product.update();
                              }
                              // String val = product.majorCatList.where((element1) => element1.catName == categoryCT.text).first.docId!;
                              // print("subCatNameList ${product.subCatList.where((element) => element.categoryId == val).length}");
                              // print("subCatNameList ${product.majorCatList.where((element1) => element1.catName == categoryCT.text).first.docId}");
                            },
                            onTap: () {
                              setState(() {});
                              categoryECT.toggle();
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   "SubCategory:",
                          //   style: R.textStyle.mediumMetropolis().copyWith(
                          //       fontSize: FetchPixels.getPixelHeight(16)),
                          // ),
                          // getVerSpace(FetchPixels.getPixelHeight(5)),
                          DropDownDynamicWidget(
                            heading: "SubCategory",
                            selectedWord: occasionCT.text,
                            dropDownItems: product.subCatNameList,
                            controller: occasionECT,
                            onSelect: (value) {
                              if (kDebugMode) {
                                print(value);
                              }
                              occasionCT.text = value;
                              setState(() {});
                            },
                            onTap: () {
                              setState(() {});
                              occasionECT.toggle();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   "Brand:",
                          //   style: R.textStyle.mediumMetropolis().copyWith(
                          //       fontSize: FetchPixels.getPixelHeight(16)),
                          // ),
                          // getVerSpace(FetchPixels.getPixelHeight(5)),
                          DropDownDynamicWidget(
                            heading: "select Brand",
                            selectedWord: brandCT.text,
                            dropDownItems: product.brandNames,
                            controller: brandECT,
                            onSelect: (value) {
                              if (kDebugMode) {
                                print(value);
                              }
                              brandCT.text = value;
                              setState(() {});
                            },
                            onTap: () {
                              setState(() {});
                              brandECT.toggle();
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   "Rent/Sell:",
                          //   style: R.textStyle.mediumMetropolis().copyWith(
                          //       fontSize: FetchPixels.getPixelHeight(16)),
                          // ),
                          // getVerSpace(FetchPixels.getPixelHeight(5)),
                          DropDownDynamicWidget(
                            heading: "Rent/Custom",
                            selectedWord: rentCT.text,
                            dropDownItems: rentList,
                            controller: rentECT,
                            onSelect: (value) {
                              if (kDebugMode) {
                                print(value);
                              }
                              rentCT.text = value;
                              setState(() {});
                            },
                            onTap: () {
                              setState(() {});
                              rentECT.toggle();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  // Text(
                  //   "Size:",
                  //   style: R.textStyle
                  //       .mediumMetropolis()
                  //       .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                  // ),
                  // getVerSpace(FetchPixels.getPixelHeight(5)),
                  DropDownDynamicWidget1(
                    heading: "Size",
                    selectedWord: sizeCT.text,
                    dropDownItems: sizeList,
                    controller: sizeECT,
                    onSelect: (value) {
                      if (kDebugMode) {
                        print(value);
                      }
                      sizeCT.text = value;
                      if (rentCT.text == "custom") {
                        selectedSize.add(sizeCT.text);
                      }
                      setState(() {});
                    },
                    onTap: () {
                      setState(() {});
                      sizeECT.toggle();
                    },
                  ),

                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  if (selectedSize.isEmpty)
                    SizedBox()
                  else
                    SizedBox(
                      height: FetchPixels.getPixelHeight(40),
                      child: ListView.builder(
                        itemCount: selectedSize.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: FetchPixels.getPixelWidth(5),
                                  top: FetchPixels.getPixelWidth(8),
                                  left: FetchPixels.getPixelWidth(5),
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: R.colors.theme),
                                    borderRadius: BorderRadius.circular(
                                        FetchPixels.getPixelHeight(10))),
                                padding: EdgeInsets.symmetric(
                                    vertical: FetchPixels.getPixelHeight(5),
                                    horizontal: FetchPixels.getPixelWidth(10)),
                                child: Center(
                                    child: Text(
                                  selectedSize[index],
                                  style: R.textStyle
                                      .regularMetropolis()
                                      .copyWith(
                                          fontSize:
                                              FetchPixels.getPixelHeight(15),
                                          color: R.colors.blackColor),
                                )),
                              ),
                              InkWell(
                                  onTap: () {
                                    selectedSize.removeAt(index);
                                    auth.update();
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    color: R.colors.theme,
                                    size: FetchPixels.getPixelHeight(18),
                                  )),
                            ],
                          );
                        },
                      ),
                    ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  // Text(
                  //   "Color",
                  //   style: R.textStyle
                  //       .mediumMetropolis()
                  //       .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                  // ),
                  // getVerSpace(FetchPixels.getPixelHeight(10)),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: FetchPixels.getPixelWidth(15)),
                          height: FetchPixels.getPixelHeight(55),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  // width: FetchPixels.getPixelWidth(1.5),
                                  color: R.colors.theme),
                              borderRadius: BorderRadius.circular(
                                FetchPixels.getPixelHeight(4),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                hexValue1 == "0" ? "Select Color" : hexValue1,
                                style: R.textStyle.mediumMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(16),
                                    color: R.colors.fillColor),
                              ),
                              Container(
                                height: FetchPixels.getPixelHeight(55),
                                width: FetchPixels.getPixelWidth(55),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(int.parse(
                                      hexValue1.replaceAll('#', '0xff'))),
                                  border: Border.all(
                                      // width: FetchPixels.getPixelWidth(1.5),
                                      color: R.colors.transparent),
                                  // borderRadius: BorderRadius.circular(
                                  //   FetchPixels.getPixelHeight(4),
                                  // ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      getHorSpace(FetchPixels.getPixelWidth(10)),
                      InkWell(
                        onTap: () {
                          Get.dialog(
                            Material(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Icon(Icons.arrow_back))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  SizedBox(
                                    height: 500,
                                    child: ColorPicker(
                                      pickerColor: pickerColor,
                                      onColorChanged: changeColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  MyButton(
                                      onTap: () {
                                        if (rentCT.text == "custom") {
                                          inHexValues.add(hexValue1.replaceAll(
                                              '#', '0xff'));
                                        }

                                        setState(() {});
                                        Get.back();
                                      },
                                      buttonText: "Add Color")
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: FetchPixels.getPixelHeight(55),
                          width: FetchPixels.getPixelWidth(55),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  // width: FetchPixels.getPixelWidth(1.5),
                                  color: R.colors.theme),
                              borderRadius: BorderRadius.circular(
                                FetchPixels.getPixelHeight(4),
                              )),
                          child: Center(
                            child: getAssetImage(R.images.edit,
                                scale: FetchPixels.getPixelHeight(6)),
                          ),
                        ),
                      )
                    ],
                  ),

                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  if (inHexValues.isEmpty)
                    SizedBox()
                  else
                    SizedBox(
                      height: FetchPixels.getPixelHeight(45),
                      child: ListView.builder(
                        itemCount: inHexValues.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: FetchPixels.getPixelWidth(5),
                                  top: FetchPixels.getPixelWidth(8),
                                  left: FetchPixels.getPixelWidth(5),
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: R.colors.theme),
                                    color: Color(int.parse(inHexValues[index])),
                                    borderRadius: BorderRadius.circular(
                                        FetchPixels.getPixelHeight(10))),
                                padding: EdgeInsets.symmetric(
                                    vertical: FetchPixels.getPixelHeight(10),
                                    horizontal: FetchPixels.getPixelWidth(20)),
                                // child: Center(
                                //     child: Text(
                                //       selectedSize[index],
                                //       style: R.textStyle
                                //           .regularMetropolis()
                                //           .copyWith(
                                //           fontSize:
                                //           FetchPixels.getPixelHeight(15),
                                //           color: R.colors.blackColor),
                                //     )),
                              ),
                              InkWell(
                                  onTap: () {
                                    inHexValues.removeAt(index);
                                    auth.update();
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    color: R.colors.theme,
                                    size: FetchPixels.getPixelHeight(18),
                                  )),
                            ],
                          );
                        },
                      ),
                    ),

                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  // Text(
                  //   "Price:",
                  //   style: R.textStyle
                  //       .mediumMetropolis()
                  //       .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                  // ),
                  // getVerSpace(FetchPixels.getPixelHeight(5)),
                  TextFormField(
                    style: R.textStyle.regularMetropolisItalic(),
                    validator: (value) =>
                        FieldValidator.validateEmptyField(value),
                    controller: rentalPriceTC,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: R.decorations
                        .textFormFieldDecoration(null, "price")
                        .copyWith(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: R.colors.g1,
                            )),
                            hintStyle:
                                TextStyle(fontSize: 14, color: R.colors.theme)),
                  ),

                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  // rentCT.text == "sell"
                  //     ? SizedBox()
                  //     : Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "Rent For:",
                  //             style: R.textStyle.mediumMetropolis().copyWith(
                  //                 fontSize: FetchPixels.getPixelHeight(16)),
                  //           ),
                  //           // getVerSpace(FetchPixels.getPixelHeight(5)),
                  //           // InkWell(
                  //           //   onTap: (){
                  //           //     DateTimePickerServices.selectDateFunction(
                  //           //         DateTime.now(),
                  //           //         DateTime.now(),
                  //           //         DateTime(2050),
                  //           //         context,
                  //           //         selectDateTC);
                  //           //   },
                  //           //   child: TextFormField(
                  //           //     style: R.textStyle.regularMetropolisItalic(),
                  //           //     validator: (value) =>
                  //           //         FieldValidator.validateEmptyField(value),
                  //           //     controller: selectDateTC,
                  //           //     enabled: false,
                  //           //     textInputAction: TextInputAction.next,
                  //           //     keyboardType: TextInputType.text,
                  //           //     decoration: R.decorations
                  //           //         .textFormFieldDecoration(null, "Enter Date..",suffix: Icon(Icons.calendar_today_outlined,color: R.colors.theme,)),
                  //           //   ),
                  //           // ),
                  //           SizedBox(height: FetchPixels.getPixelHeight(5)),
                  //           SizedBox(
                  //             height: FetchPixels.getPixelHeight(60),
                  //             child: ListView(
                  //               scrollDirection: Axis.horizontal,
                  //               children: [
                  //                 Row(
                  //                   children: List.generate(4, (index) {
                  //                     return InkWell(
                  //                         onTap: () {
                  //                           auth.selectedDays = index;
                  //                           auth.datesTimes = DateTime.now();
                  //                           auth.update();
                  //                           auth.datesTimes = auth.datesTimes
                  //                               .add(Duration(
                  //                                   days: dates[index]));
                  //                           auth.startDate = DateTime.now();
                  //                           auth.endDate = auth.datesTimes;
                  //                           auth.update();
                  //                           print(
                  //                               "This is the start date: ${auth.startDate}");
                  //                           print(
                  //                               "This is the end date: ${auth.endDate}");
                  //                         },
                  //                         child: Container(
                  //                           padding: EdgeInsets.symmetric(
                  //                               horizontal:
                  //                                   FetchPixels.getPixelWidth(
                  //                                       15),
                  //                               vertical:
                  //                                   FetchPixels.getPixelHeight(
                  //                                       8)),
                  //                           margin: EdgeInsets.all(
                  //                               FetchPixels.getPixelHeight(5)),
                  //                           decoration: BoxDecoration(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(
                  //                                     FetchPixels
                  //                                         .getPixelHeight(5)),
                  //                             color: auth.selectedDays == index
                  //                                 ? R.colors.theme
                  //                                 : R.colors.whiteColor,
                  //                           ),
                  //                           child: Center(
                  //                             child: Text(
                  //                               "${dates[index]} Days",
                  //                               style: R.textStyle
                  //                                   .mediumMetropolis()
                  //                                   .copyWith(
                  //                                     fontSize: FetchPixels
                  //                                         .getPixelHeight(16),
                  //                                     color:
                  //                                         auth.selectedDays ==
                  //                                                 index
                  //                                             ? R.colors
                  //                                                 .whiteColor
                  //                                             : R.colors
                  //                                                 .blackColor,
                  //                                   ),
                  //                             ),
                  //                           ),
                  //                         ));
                  //                   }),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           SizedBox(height: FetchPixels.getPixelHeight(10)),
                  //           SizedBox(
                  //               height: FetchPixels.getPixelHeight(450),
                  //               child: CalendarScreen()),
                  //           // getVerSpace(FetchPixels.getPixelHeight(10)),
                  //         ],
                  //       ),
                  // Text(
                  //   "Description:",
                  //   style: R.textStyle
                  //       .mediumMetropolis()
                  //       .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                  // ),
                  // getVerSpace(FetchPixels.getPixelHeight(5)),
                  TextFormField(
                    style: R.textStyle.regularMetropolisItalic(),
                    validator: (value) =>
                        FieldValidator.validateEmptyField(value),
                    controller: descriptionTC,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    decoration: R.decorations
                        .textFormFieldDecoration(null, "Description"),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  // Text(
                  //   "Additional Care Instructions:",
                  //   style: R.textStyle
                  //       .mediumMetropolis()
                  //       .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                  // ),
                  // getVerSpace(FetchPixels.getPixelHeight(5)),
                  TextFormField(
                    style: R.textStyle.regularMetropolisItalic(),
                    validator: (value) =>
                        FieldValidator.validateEmptyField(value),
                    controller: additionalTC,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    decoration: R.decorations.textFormFieldDecoration(
                        null, "Additional Care Instructions: "),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  Center(
                    child: auth.isLoading == true
                        ? Center(
                            child: Column(
                              children: [
                                CircularProgressIndicator(
                                  strokeWidth: 10,
                                  color: R.colors.theme,
                                ),
                                SizedBox(
                                  height: FetchPixels.getPixelHeight(10),
                                ),
                                Text(
                                  "Pictures and Data is Uploading...! Please Wait",
                                  style: R.textStyle
                                      .mediumMetropolis()
                                      .copyWith(
                                          fontSize:
                                              FetchPixels.getPixelHeight(16)),
                                )
                              ],
                            ),
                          )
                        : MyButton(
                            width: FetchPixels.getPixelWidth(250),
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                if (auth.listOfImages.isEmpty) {
                                  Get.snackbar(
                                      " ", "Please Select Images First");
                                  return;
                                }
                                if (categoryCT.text.isEmpty) {
                                  Get.snackbar(
                                      " ", "Please Select Category First");
                                  return;
                                }
                                if (occasionCT.text.isEmpty) {
                                  Get.snackbar(
                                      " ", "Please Select Occasion First");
                                  return;
                                }
                                if (brandCT.text.isEmpty) {
                                  Get.snackbar(
                                      " ", "Please Select Brand First");
                                  return;
                                }
                                if (rentCT.text.isEmpty) {
                                  Get.snackbar(
                                      " ", "Please Select Rent/Custom First");
                                  return;
                                }
                                if (sizeCT.text.isEmpty) {
                                  Get.snackbar(" ", "Please Select Size First");
                                  return;
                                }

                                auth.isLoading = true;
                                auth.update();
                                List<String>? myUrls =
                                    await auth.uploadMultiFiles(
                                        images: auth.listOfImages,
                                        userEmail: "test@test.com",
                                        bucketName: "Usama");
                                auth.isLoading = false;
                                ProductModel product1 = ProductModel(
                                  additionalInstructions: additionalTC.text,
                                  categoryName: categoryCT.text,
                                  // startDate:
                                  //     Timestamp.fromDate(auth.startDate!),
                                  // endDate: Timestamp.fromDate(auth.endDate!),
                                  productBrand: brandCT.text,
                                  categoryId: product.majorCatList
                                      .where((element1) =>
                                          element1.catName == categoryCT.text)
                                      .first
                                      .docId,
                                  productColors: rentCT.text == "custom"
                                      ? inHexValues
                                      : [hexValue1.replaceAll('#', '0xff')],
                                  productDescription: descriptionTC.text,
                                  productImage: myUrls,
                                  productEndDate: selectDateTC.text,
                                  productName: itemNameTC.text,
                                  productPrice: rentalPriceTC.text,
                                  productSize: rentCT.text == "custom"
                                      ? selectedSize
                                      : [sizeCT.text],
                                  productType: rentCT.text,
                                  subCategoryName: occasionCT.text,
                                  docId: "",
                                  email: auth.userModel.email,
                                  status: "pending",
                                  admin_review: "",
                                );
                                auth.updateProduct(productModel: product1, productId:widget.model.docId);
                              }

                              // Get.back();
                            },
                            buttonText: "Update Now"),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                ]),
          ),
        );
      },
    );
  }
}
