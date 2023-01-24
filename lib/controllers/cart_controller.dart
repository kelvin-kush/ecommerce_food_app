import 'package:flutter/cupertino.dart';
import 'package:food_app/data/repository/card_repo.dart';
import 'package:food_app/database/cart_database.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/models/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];
  List<CartModel> cartListHistory = [];
  //sqlite
  // List<CartModel> _newCart = [];
  // List<CartModel> get newCart => _newCart;

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(
        product.id!,
        (value) {
          totalQuantity = value.quantity! + quantity;
          return CartModel(
              id: value.id,
              name: value.name,
              price: value.price,
              img: value.img,
              quantity: value.quantity! + quantity,
              isExit: true,
              time: DateTime.now().toString(),
              product: product);
        },
      );
      if (totalQuantity < 0) {
        _items.remove(product.id!);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(
          product.id!,
          () {
            return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity: quantity,
              product: product,
              isExit: true,
              time: DateTime.now().toString(),
            );
          },
        );
      } else {
        Get.snackbar('Cart Info', 'Please cart can\'t be  0');
      }
    }
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id!)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.forEach((key, value) {
        if (key == product.id!) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  // List<CartModel> getCartData()  {
  //   setCart = cartRepo.cart;
  //   return storageItems;
  // }
  // set setCart(List<CartModel> items) {
  //   storageItems = items;

  //   for (int i = 0; i < storageItems.length; i++) {
  //     _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
  //   }
  // }

  // void addToHistory() {
  //   cartRepo.addToCartHistoryList(getItems);
  //   clear();
  // }

  addToCartHistoryList() async {
    var time = DateTime.now().toString();
    try {
      print('items in cartList ${getItems}');
      for (int i = 0; i < getItems.length; i++) {
        getItems[i].time = time;
        await CartDatabase.instance.addToCart(getItems[i]);
      }
    } catch (e) {
      print('exception for addToCartHistoryList ${e.toString()}');
    }
    clear();
    await getCartHistoryList();
  }

  void clear() {
    _items = {};
    update();
  }

  Future<List<CartModel>> getCartHistoryList() async {
    try {
      cartListHistory = await CartDatabase.instance.getAllCart();
    } catch (e) {
      print('exception for getCartHistoryList ${e.toString()}');
    }
    print('items added to cartListHistory ${cartListHistory}');
    return cartListHistory;
  }

  // void clearCartData() {
  //   cartRepo.clearCartData();
  //   update();
  // }

  void removeCartItem(CartModel cart) {
    if (_items.containsKey(cart.id!)) {
      _items.remove(cart.id);
      update();
    }
  }
}
