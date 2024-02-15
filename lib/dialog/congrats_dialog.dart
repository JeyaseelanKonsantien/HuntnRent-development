
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../base/widget_utils.dart';
import '../../../../../resources/resources.dart';

class CongratsDialog extends StatefulWidget {
  String text;
  final Function onTap;
  CongratsDialog({Key? key, required this.text,required this.onTap}) : super(key: key);

  @override
  State<CongratsDialog> createState() => _CongratsDialogState();
}

class _CongratsDialogState extends State<CongratsDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  var horSpace = FetchPixels.getPixelHeight(20);

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return ScaleTransition(
      alignment: Alignment.center,
      scale: scaleAnimation,
      child: Padding(
        padding: EdgeInsets.all(FetchPixels.getPixelHeight(20)),
        child: Dialog(
          insetPadding:
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(22))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              getVerSpace(FetchPixels.getPixelHeight(20)),
              // getAssetImage(R.images.logo,
              //     scale: FetchPixels.getPixelHeight(8)),
              getPaddingWidget(
                EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelWidth(20),
                    vertical: FetchPixels.getPixelHeight(10)),
                Column(
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: R.textStyle.mediumMetropolis().copyWith(
                          fontSize: FetchPixels.getPixelHeight(18),
                          color: R.colors.blackColor),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                  ],
                ),
              ),
              getDivider(R.colors.fillColor.withOpacity(0.5), 0.0,
                  FetchPixels.getPixelHeight(1)),
              InkWell(
                  onTap: () {
                    widget.onTap();
                  },
                  child: SizedBox(
                      height: FetchPixels.getPixelHeight(40),
                      child: Center(
                        child: Text(
                          "OK",
                          style: R.textStyle.semiBoldMetropolis().copyWith(
                              fontSize: FetchPixels.getPixelHeight(16),
                              color: R.colors.theme),
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
