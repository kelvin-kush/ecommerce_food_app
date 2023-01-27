import 'dart:convert';

import 'package:food_app/database/cart_database.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<CartModel> cartListHistory = [];

  // Future<List<CartModel>> getCartHistoryList() async {
  //   try {
  //     cartListHistory = await CartDatabase.instance.getAllCart();
  //   } catch (e) {
  //     print('exception for getCartHistoryList ${e.toString()}');
  //   }
  //   print('items added to cartListHistory ${cartListHistory}');
  //   return cartListHistory;
  // }

  // addToCartHistoryList(List<CartModel> cartList) async {
  //   try {
  //     print('items in cartList ${cartList}');
  //     for (int i = 0; i < cartList.length; i++) {
  //       await CartDatabase.instance.addToCart(cartList[i]);
  //     }
  //   } catch (e) {
  //     print('exception for addToCartHistoryList ${e.toString()}');
  //   }
   
  // }

  
   void clearCartData() {

   }

}
