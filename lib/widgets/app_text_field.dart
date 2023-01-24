import 'package:flutter/material.dart';
import 'package:food_app/utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {Key? key,
      required this.controller,
      required this.text,
      required this.iconData,
      required this.keyboardtype,
      this.isObscure = false})
      : super(key: key);

  final TextEditingController controller;
  final String text;
  final IconData iconData;
  final TextInputType keyboardtype;
  final bool isObscure;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(Dimensions.width20, 0, Dimensions.width20, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                spreadRadius: 3,
                offset: const Offset(1, 6),
                color: Colors.grey.withOpacity(0.2))
          ],
          borderRadius: BorderRadius.circular(Dimensions.radius30)),
      child: TextField(
        obscureText: isObscure ? true : false,
        keyboardType: keyboardtype,
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          prefixIcon: Icon(
            iconData,
            color: Colors.yellow,
          ),
          focusedBorder: (OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.height20),
            borderSide: const BorderSide(width: 1.0, color: Colors.white),
          )),
          enabledBorder: (OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.height20),
            borderSide: const BorderSide(width: 1.0, color: Colors.white),
          )),
          border: (OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.height20),
          )),
        ),
      ),
    );
  }
}
