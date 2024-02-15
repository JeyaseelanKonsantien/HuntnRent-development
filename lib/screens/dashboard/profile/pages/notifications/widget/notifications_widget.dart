import 'package:flutter/material.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/base/widget_utils.dart';

import '../../../../../../resources/resources.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: FetchPixels.width,
      padding: EdgeInsets.all(FetchPixels.getPixelHeight(10)),
      margin: EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(5)),
      decoration: BoxDecoration(
          color: R.colors.containerBG1,
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15))),
      child: Row(children: [
        Container(
          height: FetchPixels.getPixelHeight(70),
          width: FetchPixels.getPixelWidth(80),
          decoration: BoxDecoration(
              image: getDecorationAssetImage(context, R.images.featured1,
                  fit: BoxFit.fill),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(5))),
        ),
        getHorSpace(FetchPixels.getPixelWidth(10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Darleene Robert has placed an order.",
                style: R.textStyle
                    .regularMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(13)),
              ),
              getVerSpace(FetchPixels.getPixelHeight(5)),
              Text(
                "Party Dress",
                style: R.textStyle
                    .semiBoldMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(15)),
              ),
              Text(
                "\$808",
                style: R.textStyle
                    .mediumMetropolis()
                    .copyWith(fontSize: FetchPixels.getPixelHeight(15)),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
