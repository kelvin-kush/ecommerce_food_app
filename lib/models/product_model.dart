import 'package:hive_flutter/adapters.dart';



class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel> _products;
  List<ProductModel> get products => _products;

  Product(
      {required totalSize,
      required typeId,
      required offset,
      required products}) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['total_size'] = this.totalSize;
  //   data['type_id'] = this.typeId;
  //   data['offset'] = this.offset;
  //   if (this.products != null) {
  //     data['products'] = this.products!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

final String productTable = 'product';

class ProductFields {
 static final String id = 'id';
  static final String name = 'name';
 static final String description= 'description';
  static final String price = 'price';
  static final String stars = 'stars';
  static final String img = 'img';
   static final String location = 'location';
  static final String createdAt = 'createdAt';
  static final String updatedAt = 'updatedAt';
  static final String typeId = 'typeId';
  
   static final List<String> allFields = [
    id,
    name,
    description,
    price,
    stars,
    img,
    location,
    createdAt,
    updatedAt,
    typeId
  ];
}


class ProductModel  {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    typeId = json['typeId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stars': stars,
      'img': img,
      'location': location,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'typeId': typeId,
    };
  }
}
