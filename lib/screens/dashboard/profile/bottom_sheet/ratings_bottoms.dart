import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';

import '../../../../base/widget_utils.dart';
import '../../../../resources/resources.dart';

class RatingsBottom extends StatelessWidget {
  const RatingsBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: FetchPixels.getPixelHeight(350),
      width: FetchPixels.width,
      decoration: BoxDecoration(
          color: R.colors.whiteColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                FetchPixels.getPixelHeight(20),
              ),
              topLeft: Radius.circular(FetchPixels.getPixelHeight(20)))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getAssetImage(R.images.ratings,
              // color: R.colors.buttonText,
              scale: FetchPixels.getPixelHeight(4)),
          Text(
            "How much you are enjoying our app?",
            style: R.textStyle.mediumMetropolis().copyWith(fontSize: 18),
          ),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyButton(
                  color: R.colors.fillColor.withOpacity(0.5),
                  textColor: R.colors.blackColor,
                  width: FetchPixels.getPixelWidth(130),
                  onTap: () {
                    Get.back();
                  },
                  buttonText: "Cancel",
                  borderRadius: 10),
              MyButton(
                  width: FetchPixels.getPixelWidth(200),
                  onTap: () {
                    Get.back();
                  },
                  borderRadius: 10,
                  buttonText: "Rate Now"),
            ],
          )
        ],
      ),
    );
  }
}
