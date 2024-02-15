import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';
import '../../../../widgets/my_button.dart';

class AboutHunt extends StatelessWidget {
  const AboutHunt({super.key});

  @override
  Widget build(BuildContext context) {
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
          elevation: 2.0,
          centerTitle: true,
          title: Center(
            child: Text(
              "About Hunt & Rent",
              style: R.textStyle
                  .mediumMetropolis()
                  .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
            ),
          )),
      body: getPaddingWidget(
        EdgeInsets.all(FetchPixels.getPixelHeight(20)),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(FetchPixels.getPixelWidth(20)),
            // height: FetchPixels.height,
            width: FetchPixels.width,
            decoration: BoxDecoration(
                border: Border.all(
                    width: FetchPixels.getPixelWidth(
                      0.8,
                    ),
                    color: R.colors.whiteColor),
                borderRadius: BorderRadius.circular(6),
                color: R.colors.whiteColor),
            child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("appData")
                    .doc("about")
                    .get(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Text("Loading...");
                  } else {
                    return SingleChildScrollView(
                        child: HtmlWidget(
                      "${snapshot.data!['html_view']}",
                      // style: R.textStyle
                      //   .regularMontserrat()
                      //   .copyWith(fontSize: 14, color: R.colors.headingColor),
                    ));
                  }
                }),
          ),
        ),
      ),
    );
  }
}
