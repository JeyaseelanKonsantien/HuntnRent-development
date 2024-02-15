import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../../base/resizer/fetch_pixels.dart';
import '../../../../../../base/widget_utils.dart';
import '../../../../../../resources/resources.dart';

class SelectOccasionDialog extends StatefulWidget {
  final Function onTap;
  SelectOccasionDialog({Key? key, required this.onTap})
      : super(key: key);

  @override
  State<SelectOccasionDialog> createState() => _SelectOccasionDialogState();
}

class _SelectOccasionDialogState extends State<SelectOccasionDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.ease);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  var horSpace = FetchPixels.getPixelHeight(20);

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Consumer<ProductProvider>(builder: (context, product, child) {
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
              getPaddingWidget(
                EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelWidth(20),
                    vertical: FetchPixels.getPixelHeight(10)),
                  Container(
                    margin: EdgeInsets.only(
                        left: FetchPixels.getPixelWidth(5),
                        right: FetchPixels.getPixelWidth(15)),
                    height: FetchPixels.getPixelHeight(250),
                    width: FetchPixels.width,
                    decoration: BoxDecoration(
                        // color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: GridView.builder(
                       shrinkWrap: true,
                        itemCount: product.occasionNames.length,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        gridDelegate:
                        SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150,
                            mainAxisExtent: 40,
                            childAspectRatio: 0.65,
                            crossAxisSpacing:
                            FetchPixels.getPixelWidth(5),
                            mainAxisSpacing:
                            FetchPixels.getPixelHeight(15)),
                        itemBuilder: (context, index) {
                          return Container(
                            height: FetchPixels.getPixelHeight(5),
                            width: FetchPixels.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.occasionNames[index],
                                    style: R.textStyle
                                        .regularMetropolis()
                                        .copyWith(
                                        fontSize: FetchPixels
                                            .getPixelHeight(
                                            15)),
                                  ),
                                  SizedBox(
                                    height:
                                    FetchPixels.getPixelHeight(
                                        20),
                                    width:
                                    FetchPixels.getPixelWidth(
                                        20),
                                    child: Checkbox(
                                      fillColor:
                                      MaterialStateProperty.all<
                                          Color>(
                                          R.colors.theme),
                                      value: product
                                          .selectionsOcc![index],
                                      onChanged: (value) {
                                        setState(() {
                                          product.selectionsOcc![
                                          index] = value!;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
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
    );   },);
  }
}
