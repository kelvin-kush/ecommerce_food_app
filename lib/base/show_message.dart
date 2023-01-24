import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message,
    {bool isError = true, String title = 'Error', }) {
  Get.snackbar(title, message,
      titleText: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: Dimensions.font15),
      ),
      messageText: Text(
        message,
        style:const TextStyle(color: Colors.white),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent);
}

void successCustomSnackBar(String message,
    {bool isError = false, String title = 'Success', }) {
  Get.snackbar(title, message,
      titleText: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: Dimensions.font15),
      ),
      messageText: Text(
        message,
        style:const TextStyle(color: Colors.white),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.yellow[700]);
}