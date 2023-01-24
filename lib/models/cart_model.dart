import 'package:food_app/models/product_model.dart';
import 'package:hive/hive.dart';

final String cartTable = 'cart';

class CartFields {
  static final String id = 'id';
  static final String name = 'name';
  static final String price = 'price';
  static final String img = 'img';
  static final String quantity = 'quantity';
  static final String isExit = 'isExit';
  static final String time = 'time';
  

  static final List<String> allFields = [
    id,
    name,
    price,
    img,
    quantity,
    isExit,
    time,
  ];
}

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool isExit;
  String? time;
  ProductModel? product;
  CartModel(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.quantity,
      this.isExit=false,
      this.time,
      this.product});

 static CartModel fromJson(Map<String, dynamic> json) =>CartModel(

     id : json['id'],
    quantity:json['quantity'] ,
     isExit : json['isExit'] ==1? true: false,
    time : json['time'],
    name : json['name'],
    price : json['price'],
    img : json['img'],
  // product : ProductModel.fromJson(json['product']),
 );
   
  

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'img': img,
      'quantity': quantity,
      'isExit': isExit ? 1: 0,
      'time': time,
    // 'product': product!.toJson()
    };
  }
}
