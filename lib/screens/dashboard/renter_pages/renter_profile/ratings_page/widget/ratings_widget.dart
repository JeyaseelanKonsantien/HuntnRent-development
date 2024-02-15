import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

import '../../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../../base/widget_utils.dart';
import '../../../../../../resources/resources.dart';

class RatingsWidget extends StatelessWidget {
  const RatingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(5)),
      padding: EdgeInsets.all(FetchPixels.getPixelHeight(10) ),
      decoration: BoxDecoration(
        color: R.colors.containerBG1
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircularProfileAvatar(
                backgroundColor: R.colors.theme,
                "",
                child: getAssetImage(
                  R.images.subC1,
                ),
                radius: FetchPixels.getPixelHeight(30)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Darleene Robert",
                  style: R.textStyle
                      .semiBoldMetropolis()
                      .copyWith(fontSize: FetchPixels.getPixelHeight(15)),
                ),
                Text(
                  "5 days ago",
                  style: R.textStyle
                      .regularMetropolis()
                      .copyWith(fontSize: FetchPixels.getPixelHeight(12)),
                ),
              ],
            ),
            subtitle: Align(
              alignment: Alignment.centerLeft,
              child: getAssetImage(R.images.stars,
                  scale: FetchPixels.getPixelHeight(3)),
            ),
          ),
          Text(
              "This item is very good, my son likes it very much and plays every day!This item is very good, my son likes it very much and plays every day!")
        ],
      ),
    );
  }
}
