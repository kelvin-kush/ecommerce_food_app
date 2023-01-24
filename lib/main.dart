import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/helper/dependencies.dart' as dep;

import 'package:food_app/routes/route_helper.dart';

import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  await Get.find<CartController>().getCartHistoryList();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return GetBuilder<PopProdController>(
      builder: (_) {
        return GetBuilder<RecommendedProdController>(builder: (_) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            // home: SignInPage(),
            initialRoute: RouteHelper.getSplashScreen(),
            // initialRoute: RouteHelper.getSplashScreen(),
            getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}
