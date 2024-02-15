import 'package:flutter/material.dart';

import '../base/resizer/fetch_pixels.dart';
import '../resources/resources.dart';

class MyButton extends StatefulWidget {
  final Function onTap;
  final String buttonText;
  final bool isPrefixIcon;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? borderRadius;

  final double? textSize;

  MyButton({
    required this.onTap,
    required this.buttonText,
    this.textColor,
    this.textSize,
    this.isPrefixIcon = false,
    this.color,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    double? textSize = widget.textSize;
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () {
        widget.onTap();
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
        height: widget.height ?? FetchPixels.getPixelHeight(55),
        width: widget.width ?? FetchPixels.getPixelWidth(350),
        decoration: BoxDecoration(
            border: Border.all(color: R.colors.theme1.withOpacity(0.3)),
            // border: Border.all(color: R.colors.blackColor),
            borderRadius: BorderRadius.circular(widget.borderRadius == null
                ? FetchPixels.getPixelHeight(10)
                : widget.borderRadius!),
            color: widget.color ?? R.colors.theme),
        child: Center(
          child: Text(
            widget.buttonText.toUpperCase(),
            style: R.textStyle.mediumMetropolis().copyWith(
                  color: widget.textColor ?? R.colors.buttonText,
                  fontSize: widget.textSize == null
                      ? FetchPixels.getPixelHeight(18)
                      : FetchPixels.getPixelHeight(textSize!),
                ),
          ),
        ),
      ),
    );
  }
}
