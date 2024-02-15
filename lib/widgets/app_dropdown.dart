import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../base/resizer/fetch_pixels.dart';
import '../base/widget_utils.dart';
import '../resources/resources.dart';

class DropDownDynamicWidget extends StatefulWidget {
  final ExpandableController controller;
  final List<String> dropDownItems;
  final String heading;
  final Function() onTap;
  final ValueSetter<String> onSelect;
  final String selectedWord;

  DropDownDynamicWidget(
      {required this.controller,
      required this.dropDownItems,
      required this.heading,
      required this.onTap,
      required this.selectedWord,
      required this.onSelect});

  @override
  _DropDownDynamicWidgetState createState() => _DropDownDynamicWidgetState(
      controller: controller,
      dropDownItems: dropDownItems,
      heading: heading,
      onTap: onTap,
      selectedWord: selectedWord);
}

class _DropDownDynamicWidgetState extends State<DropDownDynamicWidget> {
  ExpandableController controller;
  List<String> dropDownItems;
  String heading;
  Function()? onTap;
  String selectedWord;
  _DropDownDynamicWidgetState(
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
              width: FetchPixels.getPixelWidth(180),
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
                      InkWell(
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
                            return InkWell(
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

class DropDownDynamicWidget2 extends StatefulWidget {
  final ExpandableController controller;
  final List<String> dropDownItems;
  final String heading;
  final Function() onTap;
  final ValueSetter<String> onSelect;
  final String selectedWord;

  DropDownDynamicWidget2(
      {required this.controller,
        required this.dropDownItems,
        required this.heading,
        required this.onTap,
        required this.selectedWord,
        required this.onSelect});

  @override
  _DropDownDynamicWidget2State createState() => _DropDownDynamicWidget2State(
      controller: controller,
      dropDownItems: dropDownItems,
      heading: heading,
      onTap: onTap,
      selectedWord: selectedWord);
}

class _DropDownDynamicWidget2State extends State<DropDownDynamicWidget2> {
  ExpandableController controller;
  List<String> dropDownItems;
  String heading;
  Function()? onTap;
  String selectedWord;
  _DropDownDynamicWidget2State(
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
              width: FetchPixels.width,
              // margin: EdgeInsets.only(top: FetchPixels.getPixelHeight(10)),
              child: Expandable(
                collapsed: ExpandableButton(
                  child: Container(
                    width: FetchPixels.width,
                    decoration: BoxDecoration(
                        color: R.colors.containerBG1,
                        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(5))
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: FetchPixels.getPixelHeight(10),
                        horizontal: FetchPixels.getPixelWidth(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedWord.isEmpty ? heading : selectedWord,
                            style: R.textStyle.semiBoldMetropolis().copyWith(
                                fontSize: 13,
                                color: selectedWord.isEmpty
                                    ? R.colors.blackColor.withOpacity(0.7)
                                    : R.colors.blackColor),
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
                              color: R.colors.containerBG1,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(FetchPixels.getPixelHeight(5)), topRight: Radius.circular(FetchPixels.getPixelHeight(5)))
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: FetchPixels.getPixelHeight(5),
                              horizontal: FetchPixels.getPixelWidth(10)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedWord.isEmpty
                                      ? "Select"
                                      : selectedWord,
                                  style: R.textStyle.semiBoldMetropolis().copyWith(
                                       color: R.colors.blackColor),
                                ),
                                Icon(
                                  Icons.arrow_drop_up_rounded,
                                  size: FetchPixels.getPixelHeight(30),
                                )
                              ]),
                        ),
                      ),
                      Container(
                        width: FetchPixels.width,
                        decoration: BoxDecoration(
                            color: R.colors.containerBG1,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(FetchPixels.getPixelHeight(5)), bottomRight: Radius.circular(FetchPixels.getPixelHeight(5)))
                        ),
                        padding: const EdgeInsets.all(10),
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
                                          .regularMetropolis()
                                          .copyWith(
                                          fontSize: 14,
                                          color: R.colors.blackColor),
                                      textAlign: TextAlign.left,
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
