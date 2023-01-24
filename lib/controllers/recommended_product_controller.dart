import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';

import 'package:food_app/data/repository/recommended_product_repo.dart';
import 'package:food_app/models/product_model.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class RecommendedProdController extends GetxController {
  final RecommendedProdRepo recommendedProdRepo;

  RecommendedProdController({required this.recommendedProdRepo});

  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  late CartController _cart;
  String errorMessage = '';
  bool error = false;

 

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCarItems = 0;
  int get inCarItems => _inCarItems + _quantity;

  Future<void> getRecommendedProdList() async {
    Response response = await recommendedProdRepo.getRecommendedProdList();
    if (response.statusCode == 200) {
      try {
      //  print('Got products');
        _recommendedProductList = [];

        // _popProductList.addAll(jsonDecode(response.body));
        _recommendedProductList
            .addAll(Product.fromJson(response.body).products);
        error = false;
      } catch (e) {
        error = true;
        _recommendedProductList = [];
        errorMessage = e.toString();
      }
    } else {
      error = true;
      _recommendedProductList = [];
      errorMessage = 'Please check your internet connection';
    }
    update();
  }

  void setQuantity(bool isIncreament) {
    if (isIncreament) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCarItems + quantity) < 0) {
      Get.snackbar('Item Count', 'Can\'t be less than 0',
          backgroundColor: Colors.green[100],
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.close));
      if (_inCarItems > 0) {
        _quantity = -_inCarItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCarItems + quantity) > 20) {
      Get.snackbar('Item Count', 'Can\'t be more than 20',
          backgroundColor: Colors.green[100],
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.close));
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCarItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    //if exist
    //get from storage _inCarItems
    //print('exist or not ${exist.toString()}');

    if (exist) {
      _inCarItems = _cart.getQuantity(product);
    }
   // print('the quantity is ${_inCarItems.toString()}');
  }

  void addItem(ProductModel product) {
    // if (_quantity > 0) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCarItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print(
          'The id is ${value.id.toString()} and quantity is ${value.quantity.toString()} ');
    });
    // } else {
    //   Get.snackbar('Cart Info', 'Please cart can\'t be  0');
    // }
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
