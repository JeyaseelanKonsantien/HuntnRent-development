import 'package:flutter/material.dart';
import 'package:hunt_and_rent/resources/resources.dart';

import '../base/resizer/fetch_pixels.dart';

class AppDecorations {
  InputDecoration textFormFieldDecoration(
    Widget? prefix,
    String hintText, {
    Widget? suffix,
  }) {
    return InputDecoration(
        // contentPadding: EdgeInsets.symmetric(
        //     vertical: FetchPixels.getPixelHeight(10),
        //     horizontal: FetchPixels.getPixelWidth(20)),
        prefixIcon: prefix,
        suffixIcon: suffix ?? null,
        isDense: true,
        // floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(25)),
          borderSide: BorderSide(
            width: 1,
            color: R.colors.theme,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(25)),
          borderSide: BorderSide(width: 2, color: R.colors.fillColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(25)),
          borderSide: BorderSide(width: 2, color: R.colors.fillColor),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: R.colors.fillColor,
          ),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(25)),
        ),
        filled: true,
        fillColor: R.colors.transparent,
        focusColor: R.colors.theme,
        hintText: hintText,
        hintStyle: R.textStyle.regularMetropolis().copyWith(
            fontSize: FetchPixels.getPixelHeight(14),
            color: R.colors.theme.withOpacity(0.5))

        //  border: OutlineInputBorder()
        );
  }

  InputDecoration textFormFieldDecorationEdit(
    Widget? prefix,
    String hintText,
  ) {
    return InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: FetchPixels.getPixelHeight(10),
            horizontal: FetchPixels.getPixelWidth(20)),
        prefixIcon: prefix,
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(25)),
          borderSide: BorderSide(
            width: 0.5,
            color: R.colors.theme,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(25)),
          borderSide: BorderSide(
            width: 0.5,
            color: R.colors.theme,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(25)),
          borderSide: BorderSide(width: 0.5, color: R.colors.fillColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(25)),
          borderSide: BorderSide(color: R.colors.whiteColor.withOpacity(0.2)),
        ),
        focusColor: R.colors.theme,
        hintText: hintText,
        hintStyle: R.textStyle.regularMetropolis().copyWith(
            fontSize: FetchPixels.getPixelHeight(14), color: R.colors.theme)

        //  border: OutlineInputBorder()
        );
  }
}
