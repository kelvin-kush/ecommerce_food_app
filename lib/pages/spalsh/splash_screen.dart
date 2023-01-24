import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/popular_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> loadResources() async {
    await Get.find<PopProdController>().getPopProdList();
    await Get.find<RecommendedProdController>().getRecommendedProdList();
  }

  @override
  void initState() {
    super.initState();
    loadResources();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(
      const Duration(seconds: 3),
      (() => Get.find<AuthController>().userLogedIn()
          ? Get.offNamed(RouteHelper.getInitial())
          : Get.offNamed(RouteHelper.getSignIn())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Image.asset(
              'assets/images/food_logo.jpg',
              fit: BoxFit.cover,
              //color: AppColor.appMainColor,
            ),
          ),
          // Text(
          //   'Best Food',
          //   style: GoogleFonts.robotoMono(fontSize: 24, color: Colors.grey),
          // )
        ],
      ),
    );
  }
}
