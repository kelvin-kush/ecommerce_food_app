import 'package:food_app/pages/auth/signin_page.dart';
import 'package:food_app/pages/cart/cart_page.dart';
import 'package:food_app/pages/home/food/pop_food.dart';
import 'package:food_app/pages/home/food/recommended_food_detal.dart';
import 'package:food_app/pages/home/homepage.dart';
import 'package:food_app/pages/spalsh/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashSceen = '/splash-Sceen';
  static const String initial = '/';
  static const String popularFood = '/popular-Food';
  static const String signInPage = '/sign-in';
  static const String recommendedFoods = '/recommended-Foods';
  static const String cartPage = '/cart-Page';

  static String getSplashScreen() => splashSceen;
  static String getInitial() => '$initial';
  static String getSignIn() => '$signInPage';
  static String getPopFoods(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecFoods(int listId, String page) =>
      '$recommendedFoods?listId=$listId&page=$page';
  static String getCartPage() => cartPage;
  static List<GetPage> routes = [
    GetPage(name: splashSceen, page: () => SplashScreen()),
    GetPage(name: signInPage, page: () => SignInPage(),transition: Transition.fadeIn),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFoods,
        page: () {
          var listId = Get.parameters['listId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetail(listId: int.parse(listId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.fadeIn)
  ];
}
