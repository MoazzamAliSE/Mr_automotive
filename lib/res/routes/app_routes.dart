import 'package:auto_motive/res/routes/routes.dart';
import 'package:auto_motive/view/add_services/service/add_services.dart';
import 'package:auto_motive/view/add_spare_parts/add_spare_parts.dart';
import 'package:auto_motive/view/available_products/available_products.dart';
import 'package:auto_motive/view/available_services/available_services.dart';
import 'package:auto_motive/view/bottom_nav/custom_bottom_nav.dart';
import 'package:auto_motive/view/cart/my_cart.dart';
import 'package:auto_motive/view/profile_picture/profile_picture.dart';
import 'package:get/get.dart';

import '../../view/sign in/sign_in.dart';
import '../../view/sign up/sign_up.dart';
import '../../view/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() {
    return [
      GetPage(name: Routes.splashScreen, page: () => const SplashScreen()),
      GetPage(name: Routes.signUpScreen, page: () => const SignUp()),
      GetPage(name: Routes.signInScreen, page: () => const SignIn()),
      GetPage(name: Routes.home, page: () => CustomBottomNav()),
      GetPage(name: Routes.profilePicture, page: () => ProfilePicture()),
      GetPage(name: Routes.addServices, page: () =>  AddServices()),
      GetPage(name: Routes.availableServices, page: () =>  AvailableServices()),
      GetPage(name: Routes.availableProducts, page: () =>  AvailableProducts()),
      GetPage(name: Routes.addSparePart, page: () =>  AddSparePart()),
      GetPage(name: Routes.myCart, page: () =>  MyCart()),
    ];
  }
}
