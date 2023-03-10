import 'package:flutter/material.dart';
import 'package:food_app/base/show_message.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:food_app/database/cart_database.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/models/product_model.dart';
import 'package:get/get.dart';

class PopProdController extends GetxController {
  final PopularProdRepo popularProdRepo;

  PopProdController({required this.popularProdRepo});

  List<ProductModel> _popProductList = [];
  List<ProductModel> get popProductList => _popProductList;
  List<ProductModel> productsFromDatabase = [];
  late CartController _cart;

  String errorMessage = '';
  bool error = false;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCarItems = 0;
  int get inCarItems => _inCarItems + _quantity;

  Future<void> getPopProdList() async {
    try {
      Response response = await popularProdRepo.getPopularProdList();
      if (response.statusCode == 200) {
        // _popProductList = [];

        _popProductList.addAll(Product.fromJson(response.body).products);

        print('products in _popProductList${_popProductList}');

        error = false;
        await createProductsDatabase(_popProductList);
      } else {
        error = true;

        errorMessage = 'Please check your internet connection';
        //  _popProductList = [];
        await getAllProducts();
      }
      update();
    } catch (e) {
      errorMessage = e.toString();
    }
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
      Get.snackbar(
        'Item Count',
        'Can\'t be less than 0',
        backgroundColor: Colors.green[100],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
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
          //   icon:IconButton(onPressed: (){Navigator.pop()}, icon: Icon(Icons.close))
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
    // print('exist or not ${exist.toString()}');

    if (exist) {
      _inCarItems = _cart.getQuantity(product);
    }
    //print('the quantity is ${_inCarItems.toString()}');
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

  createProductsDatabase(List<ProductModel> produCts) async {
    await deleteAllProducts();
    try {
      for (int i = 0; i < produCts.length; i++) {
        await CartDatabase.instance.createProductsDatabase(produCts[i]);
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
    await getAllProducts();
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      productsFromDatabase = await CartDatabase.instance.getAllProducts();
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
    print('products in database${productsFromDatabase}');
    return productsFromDatabase;
  }

  deleteAllProducts() async {
    try {
      await CartDatabase.instance.deleteAllProducts();
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
  }
}
