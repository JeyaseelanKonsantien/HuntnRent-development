import 'package:flutter/material.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';

import '../../../../../base/widget_utils.dart';
import '../../../../../resources/resources.dart';

class SpecialTailoryWidget extends StatelessWidget {
  String? name;
  String? image;

  SpecialTailoryWidget({super.key, this.name, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(FetchPixels.getPixelHeight(10)),
      margin: EdgeInsets.all(FetchPixels.getPixelHeight(6)),
      // height: FetchPixels.getPixelHeight(150),
      // width: FetchPixels.getPixelWidth(160),
      decoration: BoxDecoration(
        border: Border.all(color: R.colors.containerBG),
        borderRadius: BorderRadius.circular(10),
        color: R.colors.transparent,
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: FetchPixels.getPixelHeight(180),
          width: FetchPixels.getPixelWidth(160),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              image: getDecorationAssetImage(context, image ?? "",
                  fit: BoxFit.fill)),
        ),
        Text(
          name ?? "",
          style: R.textStyle
              .semiBoldMetropolis()
              .copyWith(fontSize: FetchPixels.getPixelHeight(15)),
        )
      ]),
    );
  }
}
