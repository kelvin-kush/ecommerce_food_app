import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    print(
        'Loading indicator ' + Get.find<AuthController>().isloading.toString());
    return Container(
      height: Dimensions.height100,
      width: Dimensions.height100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height100 / 2),
          color: Colors.yellow[700]),
      alignment: Alignment.center,
      child: CircularProgressIndicator(color: Colors.white),
    );
  }
}
