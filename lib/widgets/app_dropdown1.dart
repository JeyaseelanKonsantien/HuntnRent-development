import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../base/resizer/fetch_pixels.dart';
import '../base/widget_utils.dart';
import '../resources/resources.dart';

class DropDownDynamicWidget1 extends StatefulWidget {
  final ExpandableController controller;
  final List<String> dropDownItems;
  final String heading;
  final Function() onTap;
  final ValueSetter<String> onSelect;
  final String selectedWord;

  DropDownDynamicWidget1(
      {required this.controller,
      required this.dropDownItems,
      required this.heading,
      required this.onTap,
      required this.selectedWord,
      required this.onSelect});

  @override
  _DropDownDynamicWidget1State createState() => _DropDownDynamicWidget1State(
      controller: controller,
      dropDownItems: dropDownItems,
      heading: heading,
      onTap: onTap,
      selectedWord: selectedWord);
}

class _DropDownDynamicWidget1State extends State<DropDownDynamicWidget1> {
  ExpandableController controller;
  List<String> dropDownItems;
  String heading;
  Function()? onTap;
  String selectedWord;
  _DropDownDynamicWidget1State(
      {required this.controller,
      required this.dropDownItems,
      required this.heading,
      required this.onTap,
      required this.selectedWord});

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        controller: controller,
        child: Column(children: [
          Container(
              //height: 7.4.h,
              // width: FetchPixels.getPixelWidth(180),
              // margin: EdgeInsets.only(top: FetchPixels.getPixelHeight(10)),
              child: Expandable(
                collapsed: ExpandableButton(
                  child: Container(
                    width: FetchPixels.width,
                    decoration: BoxDecoration(
                        // color: R.colors.bottom,
                      border: Border.all(width: 1,color: R.colors.theme),
                        borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.symmetric(
                        vertical: FetchPixels.getPixelHeight(10),
                        horizontal: FetchPixels.getPixelWidth(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedWord.isEmpty ? heading : selectedWord,
                            style: R.textStyle.mediumMetropolis().copyWith(
                                fontSize: 13,
                                color: selectedWord.isEmpty
                                    ? R.colors.theme.withOpacity(0.7)
                                    : R.colors.theme),
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            size: FetchPixels.getPixelHeight(30),
                          )
                        ]),
                  ),
                ),
                expanded: Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          width: FetchPixels.width,
                          decoration: BoxDecoration(
                              color: R.colors.fillColor,
                              borderRadius: BorderRadius.circular(4)),
                          padding: EdgeInsets.symmetric(
                              vertical: FetchPixels.getPixelHeight(10),
                              horizontal: FetchPixels.getPixelWidth(10)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedWord.isEmpty
                                      ? "Select"
                                      : selectedWord,
                                  style: R.textStyle.mediumMetropolis().copyWith(
                                      fontSize: 14, color: R.colors.blackColor),
                                ),
                                Icon(
                                  Icons.arrow_drop_up_rounded,
                                  size: FetchPixels.getPixelHeight(30),
                                )
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Container(
                        width: FetchPixels.width,
                        decoration: BoxDecoration(
                            color: R.colors.whiteColor.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:
                              List.generate(dropDownItems.length, (index) {
                            return GestureDetector(
                                onTap: () {
                                  widget.onSelect(dropDownItems[index]);
                                  selectedWord = dropDownItems[index];
                                  setState(() {
                                    controller.toggle();
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dropDownItems[index],
                                      style: R.textStyle
                                          .semiBoldMetropolisItalic()
                                          .copyWith(
                                              fontSize: 14,
                                              color: R.colors.theme),
                                      textAlign: TextAlign.left,
                                    ),
                                    Divider(
                                      color:
                                          R.colors.blackColor.withOpacity(0.5),
                                      height: FetchPixels.getPixelHeight(25),
                                      thickness: 1,
                                    ),
                                  ],
                                ));
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ]));
  }
}
