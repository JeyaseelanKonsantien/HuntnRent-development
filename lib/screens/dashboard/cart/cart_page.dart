import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/base/widget_utils.dart';
import 'package:hunt_and_rent/screens/auth/provider/auth_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/dashboard_view.dart';
import 'package:hunt_and_rent/screens/dashboard/home/model/product_model.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/widgets/my_button.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../resources/resources.dart';
import '../home/widgets/featured_product_widget.dart';
import 'check_out_pay.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  loc.Location location = loc.Location();
  bool? _serviceEnabled;
  loc.LocationData? _locationData;

  @override
  void initState() {
    var auth = Provider.of<AuthProvider>(context, listen: false);
    auth.getAllProductDoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProductProvider>(
      builder: (context, auth, pro, child) {
        return Scaffold(
          body: SizedBox(
            width: FetchPixels.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  Row(
                    children: [
                      getHorSpace(FetchPixels.getPixelWidth(10)),
                      InkWell(
                          onTap: () {
                            Get.offAll(() => DashboardView(
                                  index: 0,
                                ));
                          },
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                          )),
                      getHorSpace(FetchPixels.getPixelWidth(20)),
                      Center(
                          child: Text(
                        "My Basket",
                        style: R.textStyle
                            .semiBoldMetropolis()
                            .copyWith(fontSize: FetchPixels.getPixelHeight(16)),
                      )),
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  pro.products
                              .where((element) =>
                                  auth.cartDocList.contains(element.docId))
                              .length ==
                          0
                      ? Expanded(
                          child: getAssetImage(
                          R.images.emptyCart,
                          height: FetchPixels.getPixelHeight(200),
                          width: FetchPixels.getPixelWidth(200),
                        ))
                      : Expanded(
                          child:
                              // auth.userModel.cart!.length==0?Center(child: Text("There is no Item in Cart",style: R.textStyle.semiBoldMetropolis().copyWith(fontSize: FetchPixels.getPixelHeight(16),color: R.colors.blackColor.withOpacity(0.5)),))
                              //     :
                              ListView.builder(
                            itemCount: pro.products
                                .where((element) =>
                                    auth.cartDocList.contains(element.docId))
                                .length,
                            padding: EdgeInsets.symmetric(
                                horizontal: FetchPixels.getPixelWidth(20)),
                            itemBuilder: (context, index) {
                              ProductModel model = pro.products
                                  .where((element) =>
                                      auth.cartDocList.contains(element.docId))
                                  .toList()[index];
                              return Column(
                                children: [
                                  FeaturedWidget1(
                                    model: model,
                                    isCart: true,
                                    index1: index,
                                  ),
                                  Divider(
                                    height: 0,
                                    color: R.colors.theme.withOpacity(0.4),
                                    indent: 10,
                                    endIndent: 10,
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  MyButton(
                    onTap: () {
                      pro.products
                                  .where((element) =>
                                      auth.cartDocList.contains(element.docId))
                                  .length ==
                              0
                          ? Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return DashboardView(
                                  index: 1,
                                );
                              },
                            ))
                          // Get.to(()=>DashboardView(index: 0,))
                          :
                          // openLocationSettings();
                          // auth.userModel.cart!.length==0?Get.snackbar(
                          //     backgroundColor: R.colors.bottom,
                          //     " ", "Please Add At Least One Product to Checkout!"):
                          Get.to(() => CheckOutPage());
                    },
                    buttonText: pro.products
                                .where((element) =>
                                    auth.cartDocList.contains(element.docId))
                                .length ==
                            0
                        ? "Hunt Now"
                        : "CHECKOUT",
                    borderRadius: 40,
                    height: FetchPixels.getPixelHeight(50),
                    textSize: 18,
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(120)),
                ]),
          ),
        );
      },
    );
  }

  void openLocationSettings() async {
    try {
      PermissionStatus permissionStatus = await Permission.location.request();
      if (permissionStatus.isGranted) {
        await getLocationInfo();
        Get.to(() => CheckOutPage());
      } else {
        openAppSettings();
      }
    } catch (e) {
      print('Error opening location settings: $e');
    }
  }

  getLocationInfo() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }
    // _permissionGranted = (await location.hasPermission()) as PermissionStatus?;
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = (await location.requestPermission()) as PermissionStatus?;
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }
    _locationData = await location.getLocation();
    var c = Provider.of<ProductProvider>(context, listen: false);
    c.lat = _locationData!.latitude.toString();
    c.lng = _locationData!.longitude.toString();
    print("lat ${c.lat} lng ${c.lng}");
    c.fetchLocationAddress();
    c.update();
  }
}
