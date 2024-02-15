import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hunt_and_rent/screens/dashboard/cart/cart_page.dart';
import 'package:hunt_and_rent/screens/dashboard/category/category_page.dart';
import 'package:hunt_and_rent/screens/dashboard/home/provider/product_provider.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/profile_page.dart';
import 'package:hunt_and_rent/screens/dashboard/renter_pages/analytics/analytics_view.dart';
import 'package:hunt_and_rent/screens/dashboard/renter_pages/collections/collections_view.dart';
import 'package:hunt_and_rent/screens/dashboard/renter_pages/renter_home/renter_home_view.dart';
import 'package:hunt_and_rent/screens/dashboard/renter_pages/renter_profile/renter_profile_view.dart';
import 'package:provider/provider.dart';

import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../../resources/resources.dart';
import '../auth/provider/auth_provider.dart';
import 'home/favrt_produects.dart';
import 'home/home_page.dart';

class DashboardView extends StatefulWidget {
  final index;

  const DashboardView({Key? key, this.index = 0}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  PageController pageController = PageController();
  ProductProvider provider = Provider.of<ProductProvider>(Get.context!);

  @override
  void initState() {
    provider.selectedCatId = provider.majorCatList[0].docId ?? "";
    setState(() {
      currentPage = widget.index;
      pageController = PageController(initialPage: currentPage);
    });
    super.initState();
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: InkWell(
            onTap: () {
              if (authProvider.userModel.isRenter == true) {
                Get.offAll(DashboardView(
                  index: 0,
                ));
                authProvider.userModel.isRenter = false;
                authProvider.update();
              } else {
                authProvider.userModel.isRenter == false;
                Get.offAll(DashboardView(
                  index: 0,
                ));
                authProvider.userModel.isRenter = true;
                authProvider.update();
              }
            },
            child: Container(
              height: FetchPixels.getPixelHeight(90),
              width: FetchPixels.getPixelWidth(90),
              decoration: ShapeDecoration(
                  // boxShadow: [],
                  color: R.colors.whiteColor,
                  shape: OvalBorder()),
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: FetchPixels.getPixelHeight(70),
                  width: FetchPixels.getPixelWidth(70),
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.21, -0.98),
                      end: Alignment(0.21, 0.98),
                      colors: [
                        Color(0xFFE7A4F7),
                        Color(0xFF460D54),
                        Color(0xFFBE64D4)
                      ],
                    ),
                    shape: OvalBorder(),
                  ),
                  child: Center(
                      child: Text(
                    authProvider.userModel.isRenter == true
                        ? "BECOME\nA HUNTER"
                        : "BECOME\nA RENTER",
                    style: R.textStyle.mediumMetropolis().copyWith(
                        color: R.colors.whiteColor,
                        fontSize: FetchPixels.getPixelHeight(10)),
                  )),
                ),

                // Container(
                //   width: 68,
                //   height: 68,
                //   child: Stack(
                //     children: [
                //       Positioned(
                //         left: 0,
                //         top: 0,
                //         child: Container(
                //           width: 68,
                //           height: 68,
                //           decoration: ShapeDecoration(
                //             gradient: LinearGradient(
                //               begin: Alignment(-0.21, -0.98),
                //               end: Alignment(0.21, 0.98),
                //               colors: [Color(0xFFE7A4F7), Color(0xFF460D54), Color(0xFFBE64D4)],
                //             ),
                //             shape: OvalBorder(),
                //           ),
                //         ),
                //       ),
                //       Positioned(
                //         left: 8,
                //         top: 22,
                //         child: Text(
                //           'BECOME\nA RENTER',
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 10,
                //             fontFamily: 'Montserrat',
                //             fontWeight: FontWeight.w500,
                //             height: 0.12,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // )
                //
                //

                //
              ),
            ),
          ),
          appBar: authProvider.userModel.isRenter == true
              ? AppBar(
                  actions: authProvider.userModel.isRenter == true
                      ? []
                      : [
                          Center(
                            child: InkWell(
                              onTap: () {
                                Get.offAll(const DashboardView(
                                  index: 2,
                                ));
                              },
                              child: getAssetImage(R.images.chat,
                                  // color: R.colors.buttonText,
                                  scale: FetchPixels.getPixelHeight(4)),
                            ),
                          ),
                          getHorSpace(FetchPixels.getPixelWidth(20)),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  () => FavrtProductsView(),
                                );
                              },
                              child: getAssetImage(R.images.fav,
                                  color: R.colors.theme,
                                  scale: FetchPixels.getPixelHeight(3.5)),
                            ),
                          ),
                          getHorSpace(FetchPixels.getPixelWidth(20))
                        ],
                  iconTheme: IconThemeData(
                    color: R.colors.whiteColor, //change your color here
                  ),
                  automaticallyImplyLeading: false,
                  backgroundColor: R.colors.transparent,
                  elevation: 0.0,
                  // centerTitle: true,
                  title: authProvider.userModel.isRenter == true
                      ? Align(
                          alignment: Alignment.center,
                          child: Text(
                            currentPage == 0
                                ? "Summary Analytics"
                                : currentPage == 1
                                    ? "My Collection"
                                    : currentPage == 2
                                        ? "Analytics & Report"
                                        : "My Profile",
                            style: R.textStyle.semiBoldMetropolis().copyWith(
                                fontSize: FetchPixels.getPixelHeight(16)),
                          ),
                        )
                      : SizedBox())
              : null,
          body: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              R.colors.whiteColor,
              R.colors.whiteColor,
              // R.colors.whiteColor,
              // R.colors.whiteColor,
              R.colors.whiteColor,
              R.colors.containerBG1
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SafeArea(
              child: Stack(
                children: [
                  PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (page) {
                        print("on page changed $page");
                        currentPage = page;
                        // setState(() {});
                      },
                      children: [
                        authProvider.userModel.isRenter == true
                            ? RenterHomeView()
                            : HomeView(),
                        authProvider.userModel.isRenter == true
                            ? CollectionsView()
                            : CategoryView(),
                        authProvider.userModel.isRenter == true
                            ? AnalyticsView()
                            : CartView(),
                        authProvider.userModel.isRenter == true
                            ? RenterProfileView()
                            : ProfileView(),
                      ]),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          // vertical: FetchPixels.getPixelHeight(10),
                          // horizontal: FetchPixels.getPixelWidth(5),
                          ),
                      height: FetchPixels.getPixelHeight(60),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: R.colors.whiteColor,
                        // borderRadius:
                        //     BorderRadius.circular(FetchPixels.getPixelWidth(50))
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            tab(
                              authProvider,
                              0,
                              R.images.home,
                              R.images.selectedHome,
                            ),
                            authProvider.userModel.isRenter == true
                                ? tab(
                                    authProvider,
                                    1,
                                    R.images.collections,
                                    R.images.selectedCollection,
                                  )
                                : tab(
                                    authProvider,
                                    1,
                                    R.images.category,
                                    R.images.selectedCategory,
                                  ),
                            Container(),
                            getHorSpace(FetchPixels.getPixelWidth(40)),
                            authProvider.userModel.isRenter == true
                                ? tab(
                                    authProvider,
                                    2,
                                    R.images.analytics,
                                    R.images.selectedAnalytics,
                                  )
                                : tab(
                                    authProvider,
                                    2,
                                    R.images.cart,
                                    R.images.selectedCart,
                                  ),
                            tab(
                              authProvider,
                              3,
                              R.images.profile,
                              R.images.selectedProfile,
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget tab(
    AuthProvider authProvider,
    int index,
    String image,
    String image1,
  ) {
    return InkWell(
        onTap: () {
          print("index $currentPage");
          pageController.jumpToPage(index);
          authProvider.update();
          // setState(() {});
          print('current page$currentPage');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: FetchPixels.getPixelHeight(25),
              width: FetchPixels.getPixelWidth(25),
              decoration: BoxDecoration(
                  image: getDecorationAssetImage(
                context,
                currentPage == index ? image1 : image,
              )),
            ),
            getVerSpace(FetchPixels.getPixelHeight(2)),
            Text(
              index == 0
                  ? "Home"
                  : index == 1
                      ? authProvider.userModel.isRenter == true
                          ? "Collection"
                          : "Categories"
                      : index == 2
                          ? authProvider.userModel.isRenter == true
                              ? "Analytics"
                              : "Cart"
                          : "Me",
              style: R.textStyle.regularMetropolis().copyWith(
                  fontSize: FetchPixels.getPixelHeight(12),
                  color: currentPage == index
                      ? R.colors.blackColor
                      : R.colors.theme),
            )
          ],
        ));
  }
}
