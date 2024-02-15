import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../../resources/resources.dart';
import '../auth/provider/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Location location = new Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  getLocationInfo() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      // .then((value) => Get.dialog(Center(
      //   child: Material(
      //         child: InkWell(
      //             onTap: () {
      //               getLocationInfo();
      //               Get.back();
      //             },
      //             child: Text("USAMAMAMAMAM")),
      //       ),
      // )));
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    var c = Provider.of<ProductProvider>(context, listen: false);
    c.lat = _locationData!.latitude.toString();
    c.lng = _locationData!.longitude.toString();
    print("lat ${c.lat} lng ${c.lng}");
    c.fetchLocationAddress();
    c.update();
  }

  void initState() {
    var c = Provider.of<ProductProvider>(context, listen: false);
    c.fetchMajorData();
    // getLocationInfo();
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Provider.of<AuthProvider>(context, listen: false).getCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      // backgroundColor: R.colors.theme1,
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // getVerSpace(FetchPixels.getPixelHeight(10)),
          // getVerSpace(FetchPixels.getPixelHeight(10)),
          getAssetImage(
              width: double.maxFinite, R.images.landing01, boxFit: BoxFit.fill),
          Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: getAssetImage(
                R.images.logoHnr,
                height: FetchPixels.getPixelHeight(200),
                width: FetchPixels.getPixelWidth(200),
              ),
            ),
          )
          // getVerSpace(FetchPixels.getPixelHeight(10)),
          // getVerSpace(FetchPixels.getPixelHeight(10)),
        ],
      ),
    );
  }
}
