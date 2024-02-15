import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/dashboard/home/special_tailory/widget/abayas_view.dart';
import 'package:hunt_and_rent/screens/dashboard/home/special_tailory/widget/special_tailory_widget.dart';

import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../forum/forum_page.dart';
import '../../../../resources/resources.dart';
import '../../dashboard_view.dart';
import '../../profile/pages/my_whish_list.dart';
import '../../profile/pages/notifications/notifications.dart';
import '../favrt_produects.dart';

class SpecialTailoryView extends StatelessWidget {
  const SpecialTailoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     leading: Center(
      //       child: InkWell(
      //         onTap: () {
      //           Get.back();
      //         },
      //         child: Container(
      //           height: FetchPixels.getPixelHeight(30),
      //           width: FetchPixels.getPixelWidth(30),
      //           decoration: BoxDecoration(
      //               shape: BoxShape.circle, color: R.colors.blackColor),
      //           child: Icon(
      //             Icons.arrow_back_ios_rounded,
      //             size: FetchPixels.getPixelHeight(18),
      //             color: R.colors.bgColor,
      //           ),
      //         ),
      //       ),
      //     ),
      //     actions: [
      //       Center(
      //         child: getAssetImage(R.images.selectedCart,
      //             color: R.colors.buttonText,
      //             scale: FetchPixels.getPixelHeight(4)),
      //       ),
      //       getHorSpace(FetchPixels.getPixelWidth(10)),
      //       Center(
      //         child: InkWell(
      //           onTap: () {
      //             Get.to(FavrtProductsView());
      //           },
      //           child: getAssetImage(R.images.fav,
      //               color: R.colors.redColor,
      //               scale: FetchPixels.getPixelHeight(3.5)),
      //         ),
      //       ),
      //       getHorSpace(FetchPixels.getPixelWidth(20))
      //     ],
      //     iconTheme: IconThemeData(
      //       color: R.colors.whiteColor, //change your color here
      //     ),
      //     automaticallyImplyLeading: false,
      //     backgroundColor: R.colors.transparent,
      //     elevation: 0.0,
      //     centerTitle: true,
      //     title: getAssetImage(R.images.logo1,
      //         height: FetchPixels.getPixelHeight(60),
      //         width: FetchPixels.getPixelWidth(150))),
      body: getPaddingWidget(
        EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(15)),
        ListView(children: [
          getVerSpace(FetchPixels.getPixelHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: FetchPixels.getPixelHeight(22),
                  color: R.colors.blackColor,
                ),
              ),
              getHorSpace(FetchPixels.getPixelWidth(30)),
              Row(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Tailory Service",
                        style: R.textStyle
                            .semiBoldMetropolis()
                            .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                      )),
                ],
              ),
              // Container(
              //   height: FetchPixels.getPixelHeight(40),
              //   width: FetchPixels.getPixelWidth(180),
              //   child: Padding(
              //     padding: EdgeInsets.only(
              //         left: FetchPixels.getPixelWidth(5),
              //         right: FetchPixels.getPixelWidth(10)),
              //     child: TextFormField(
              //         // controller: searchController,
              //         // onChanged: (value) {
              //         //   searchQuery = value;
              //         //   performSearch(product: product);
              //         //   setState(() {});
              //         // },
              //         decoration: R.decorations.textFormFieldDecoration(
              //             null, "Search",
              //             suffix: Icon(Icons.search_rounded))),
              //   ),
              // ),

              Row(
                children: [
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
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          Text(
            "Introducing our Special Tailory Service",
            style: R.textStyle
                .mediumMetropolis()
                .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
          ),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                  style: R.textStyle
                      .regularMetropolis()
                      .copyWith(fontSize: FetchPixels.getPixelHeight(14)),
                  text:
                      'Custom-made Abayas and Thobes,delivered to your doorstep. Know '),
              TextSpan(
                style: R.textStyle.regularMetropolis().copyWith(
                    decoration: TextDecoration.underline,
                    fontSize: FetchPixels.getPixelHeight(14),
                    color: R.colors.theme),
                text: ' How it works.',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        height: FetchPixels.getPixelHeight(350),
                        padding: EdgeInsets.symmetric(
                            horizontal: FetchPixels.getPixelWidth(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Here's how it works:",
                              style: R.textStyle.semiBoldMetropolis().copyWith(
                                  fontSize: FetchPixels.getPixelHeight(18)),
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(20)),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: "1. ",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                              TextSpan(
                                text:
                                    "Explore designs and select your favorite.",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                            ])),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: "2. ",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                              TextSpan(
                                text:
                                    "Request a visit from our Special Tailory agent.",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                            ])),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: "3. ",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                              TextSpan(
                                text:
                                    "Personalized consultation and measurements at your convenience.",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                            ])),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: "4. ",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                              TextSpan(
                                text:
                                    "Order placed with partner tailor stores.",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                            ])),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: "5. ",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                              TextSpan(
                                text: "Timely delivery to your doorstep.",
                                style: R.textStyle.regularMetropolis().copyWith(
                                    fontSize: FetchPixels.getPixelHeight(14)),
                              ),
                            ])),
                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            Text(
                              "Say goodbye to long waits and enjoy hassle-free customization with Hunt&Rent's Special Tailory Service. Contact our customer support for more information.",
                              style: R.textStyle.regularMetropolis().copyWith(
                                  fontSize: FetchPixels.getPixelHeight(14)),
                            ),
                          ],
                        ),
                      ),
                   
                    );
                 
                  },
              )
            ],
          )),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          SizedBox(
            height: FetchPixels.getPixelHeight(250),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {
                      Get.to(() => AbayasView(
                            productName: "Abayas",
                          ));
                    },
                    child: SpecialTailoryWidget(
                      name: "Abayas",
                      image: R.images.aba,
                    )),
                // getHorSpace(FetchPixels.getPixelWidth(10)),
                InkWell(
                    onTap: () {
                      Get.to(() => AbayasView(
                            productName: "Thobes",
                          ));
                    },
                    child: SpecialTailoryWidget(
                      name: "Thobes",
                      image: R.images.tho,
                    )),
                // SpecialTailoryWidget(
                //   name: "Thobes",
                //   image: R.images.tho,
                // ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
