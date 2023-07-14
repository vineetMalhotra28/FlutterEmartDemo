import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/home_screen/cart_screen.dart';
import 'package:get/get.dart';

import '../views/auth_screen/signup_screen.dart';
import '../views/auth_screen/splash_screen.dart';
import '../views/home_screen/SearchScreen.dart';
import '../views/home_screen/account_screen.dart';
import '../views/home_screen/category_screen.dart';
import '../views/home_screen/chat_screen.dart';
import '../views/home_screen/home_screen.dart';
import '../views/home_screen/messagin_screen.dart';
import '../views/home_screen/orderDetails.dart';
import '../views/home_screen/order_screen.dart';
import '../views/home_screen/payment_screen.dart';
import '../views/home_screen/productDetail_screen.dart';
import '../views/home_screen/shipping_screen.dart';
import '../views/home_screen/subCategory_screen.dart';
import '../views/home_screen/editProfile_screen.dart';
import '../views/home_screen/wishlist_screen.dart';

class Routes {
  var route = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/signup', page: () => SignupScreen()),
    GetPage(name: '/homeScreen', page: () => HomeScreen()),
    GetPage(name: '/categoryScreen', page: () => Caetegoryscreen()),
    GetPage(name: '/subcategoryScreen', page: () => SubCategoryScreen()),
    GetPage(name: '/productDetailScreen', page: () => ProductdetailScreen()),
    GetPage(name: '/accountScreen', page: () => AccountScreen()),
    GetPage(name: '/editProfileScreen', page: () => EditprofileScreen()),
    GetPage(name: '/userCartScreen', page: () => CartScreen()),
    GetPage(name: '/ChatScreen', page: () => ChatScreen()),
    GetPage(name: '/ShippingScreen', page: () => ShippingScreen()),
    GetPage(name: '/PaymentScreen', page: () => PaymentScreen()),
    GetPage(name: '/userOrderScreen', page: () => UserOrderScreen()),
    GetPage(name: '/userWishlistScreen', page: () => userWishlistScreen()),
    GetPage(name: '/userMessageScreen', page: () => MessagingScreen()),
    GetPage(name: '/OrderDetails', page: () => OrderDetails()),
    GetPage(name: '/searchScreen', page: () => SearchScreen()),
  ];
}
