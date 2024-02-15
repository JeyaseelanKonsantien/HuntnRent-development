import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hunt_and_rent/screens/auth/login_signup.dart';
import 'package:hunt_and_rent/screens/dashboard/profile/pages/bank_details.dart';

import '../screens/auth/forgot_password/forgot_password_view.dart';
import '../screens/auth/login_page/login_view.dart';
import '../screens/auth/sign_up_page/sign_up_view.dart';
import '../screens/auth/user_type_view.dart';
import '../screens/dashboard/cart/performance_page.dart';
import '../screens/dashboard/dashboard_view.dart';
import '../screens/dashboard/profile/pages/about_hunt.dart';
import '../screens/dashboard/profile/pages/faqs_page.dart';
import '../screens/dashboard/profile/pages/my_whish_list.dart';
import '../screens/dashboard/profile/pages/notifications/notifications.dart';
import '../screens/dashboard/profile/pages/my_order_history/order_history.dart';
import '../screens/dashboard/profile/pages/privacy_policy.dart';
import '../screens/dashboard/profile/pages/support.dart';
import '../screens/dashboard/profile/pages/terms_conditions.dart';
import '../screens/landing_pages/landing_screens.dart';
import '../screens/splash/splash.dart';
import 'app_routes.dart';

abstract class AppPages {
  static List<GetPage> pages = [
    GetPage(name: Routes.splashScreen, page: () => SplashScreen()),
    GetPage(name: Routes.landingScreens, page: () => LandingScreens()),
    GetPage(name: Routes.userTypeView, page: () => UserTypeView()),
    GetPage(name: Routes.dashboardView, page: () => DashboardView()),
    GetPage(name: Routes.signUpView, page: () => SignUpView()),
    GetPage(name: Routes.loginView, page: () => LoginView()),
    GetPage(name: Routes.orderHistory, page: () => OrderHistory()),
    GetPage(name: Routes.notificationsView, page: () => NotificationsView()),
    GetPage(name: Routes.wishList, page: () => WishList()),
    GetPage(name: Routes.supportView, page: () => SupportView()),
    GetPage(name: Routes.aboutHunt, page: () => AboutHunt()),
    GetPage(name: Routes.privacyPolicy, page: () => PrivacyPolicy()),
    GetPage(name: Routes.termsConditions, page: () => TermsConditions()),
    GetPage(name: Routes.fAQs, page: () => FAQs()),
    GetPage(name: Routes.performancePage, page: () => PerformancePage()),
    GetPage(name: Routes.forgotPassword, page: () => ForgotPassword()),
    GetPage(name: Routes.Bank_details, page: () => BankDetailsView()),
    // GetPage(name: Routes.paymentDetails, page: () => PaymentSuccessPage()),
    GetPage(name: Routes.LoginSignup, page: () => LoginSignup()),
  ];
}
