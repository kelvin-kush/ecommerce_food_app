import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/helper/dependencies.dart' as dep;


import 'package:food_app/routes/route_helper.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  await Get.find<CartController>().getCartHistoryList();
  await Hive.initFlutter();
 // Hive.registerAdapter(ProductModelAdapter());
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
              //home: OTP(),
              initialRoute: RouteHelper.getSplashScreen(),
              getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}
