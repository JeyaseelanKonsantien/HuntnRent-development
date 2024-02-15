import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/resources/resources.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/cart/model/cart_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EarningsView extends StatelessWidget {
  EarningsView({Key? key});

  final Color dark = R.colors.theme;
  final Color normal = R.colors.theme;
  final Color light = R.colors.theme;

  List<BarChartGroupData> getData(ProductProvider pro, AuthProvider auth,
      double barsWidth, double barsSpace) {
    // Create a map to store sales data for each product
    Map<String?, double> salesDataMap = {};

    // Calculate sales data for each product
    pro.earningsList
        .where((element) => element.vendorId == auth.userModel.email)
        .forEach((model) {
      String? productId = model.productId;
      print(model.productPrice);
      double salesData = double.tryParse(model.productPrice ?? '0.0') ?? 0.0;

      // Ensure that salesDataMap[productId] is not null
      if (salesDataMap[productId] == null) {
        salesDataMap[productId] = 0.0;
      }

      salesDataMap[productId] = (salesDataMap[productId] ?? 0.0) + salesData;
    });

    List<BarChartGroupData> data = [];

    // Iterate through the product IDs and create bar chart data
    salesDataMap.forEach((productId, salesData) {
      data.add(BarChartGroupData(
        x: data.length,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: salesData,
            width: barsWidth,
            color: R.colors.theme, // Set color based on your preference
          ),
        ],
      ));
    });

    return data;
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    // Customize the bottom titles as needed
    const style = TextStyle(fontSize: 10);
    String text = ''; // Customize this based on your requirement

    // Example: Display month names
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 2:
        text = 'Mar';
        break;
      case 4:
        text = 'May';
        break;
      case 6:
        text = 'Jul';
        break;
      case 8:
        text = 'Sep';
        break;
      case 10:
        text = 'Nov';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, AuthProvider>(
      builder: (context, pro, auth, _) {
        return Scaffold(
          appBar: AppBar(
            leading: Center(
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 22,
                  color: R.colors.whiteColor,
                ),
              ),
            ),
            iconTheme: IconThemeData(
              color: R.colors.whiteColor,
            ),
            automaticallyImplyLeading: false,
            backgroundColor: R.colors.theme,
            elevation: 0.0,
            centerTitle: true,
            title: Center(
              child: Text(
                "Earnings",
                style: R.textStyle.mediumMetropolis().copyWith(
                    color: R.colors.whiteColor,
                    fontSize: FetchPixels.getPixelHeight(18)),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.66,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final barsSpace = 4.0 * constraints.maxWidth / 400;
                        final barsWidth = 20.0 * constraints.maxWidth / 400;

                        return BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.center,
                            barTouchData: BarTouchData(
                              enabled: false,
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 28,
                                  getTitlesWidget: bottomTitles,
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: leftTitles,
                                ),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: FlGridData(
                              show: true,
                              checkToShowHorizontalLine: (value) =>
                                  value % 10 == 0,
                              getDrawingHorizontalLine: (value) => FlLine(
                                color: R.colors.theme.withOpacity(0.1),
                                strokeWidth: 1,
                              ),
                              drawVerticalLine: false,
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            groupsSpace: barsSpace,
                            barGroups: getData(pro, auth, barsWidth, barsSpace),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 100),
                pro.earningsList
                        .where((element) =>
                            element.vendorId == auth.userModel.email)
                        .isEmpty
                    ? Center(
                        child: Image.asset(
                          "assets/images/earnings-empty.png",
                          height: 150,
                          width: 150,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: pro.earningsList
                              .where((element) =>
                                  element.vendorId == auth.userModel.email)
                              .length,
                          itemBuilder: (context, index) {
                            CartModel model = pro.earningsList
                                .where((element) =>
                                    element.vendorId == auth.userModel.email)
                                .toList()[index];
                            return earnings(model, pro);
                          },
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget earnings(CartModel model, ProductProvider pro) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 60,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircularProfileAvatar(
            "",
            cacheImage: true,
            imageFit: BoxFit.fill,
            child: Image.network(
                pro.products
                        .where((element) => element.docId == model.productId)
                        .toList()[0]
                        .productImage!
                        .first ??
                    "",
                fit: BoxFit.fill),
            radius: 30,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  pro.products
                          .where((element) => element.docId == model.productId)
                          .toList()[0]
                          .productName ??
                      "",
                  style: R.textStyle.regularMetropolis().copyWith(
                        fontSize: FetchPixels.getPixelHeight(14),
                      ),
                ),
              ),
              Text(
                "\QR ${model.productPrice}",
                style: R.textStyle.mediumMetropolis().copyWith(
                      color: R.colors.theme,
                      fontSize: FetchPixels.getPixelHeight(14),
                    ),
              ),
            ],
          ),
          subtitle: Text(
            DateFormat('MMM dd yyyy | hh : mm a')
                .format(model.endDate!.toDate()),
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
