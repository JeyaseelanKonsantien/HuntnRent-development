import 'package:flutter/material.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/base/widget_utils.dart';
import 'package:hunt_and_rent/screens/dashboard/renter_pages/renter_home/widget/summary_widget.dart';

class RenterHomeView extends StatelessWidget {
  const RenterHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
      Column(
        children: [
          getVerSpace(FetchPixels.getPixelHeight(20)),
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelWidth(20)),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    childAspectRatio: 3 / 3.5,
                    mainAxisExtent: 200,
                    crossAxisSpacing: FetchPixels.getPixelWidth(20),
                    mainAxisSpacing: FetchPixels.getPixelHeight(20)),
                itemCount: 3,
                itemBuilder: (BuildContext ctx, index) {
                  // ProductModel model = auth.userModel.favrt![index];
                  return SummaryWidget(
                    index: index,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
