import 'package:hng_shoppers/widgets/prodCardWidget.dart';
// To parse this JSON data, do
//
//     final getProductModel = getProductModelFromJson(jsonString);

import 'dart:convert';

GetProductModel getProductModelFromJson(String str) =>
    GetProductModel.fromJson(json.decode(str));

String getProductModelToJson(GetProductModel data) =>
    json.encode(data.toJson());

class GetProductModel {
  List<Product> products;

  GetProductModel({
    required this.products,
  });

  factory GetProductModel.fromJson(Map<String, dynamic> json) =>
      GetProductModel(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  String product;
  int price;
  String productImageUrl;
  String id;

  Product({
    required this.product,
    required this.price,
    required this.productImageUrl,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        product: json["product"],
        price: json["price"],
        productImageUrl: json["productImageUrl"] ?? "",
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "price": price,
        "productImageUrl": productImageUrl,
        "id": id,
      };
}
