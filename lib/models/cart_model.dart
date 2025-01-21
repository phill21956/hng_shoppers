// To parse this JSON data, do
//
//     final cartItemModel = cartItemModelFromJson(jsonString);

import 'dart:convert';

class CartItem {
  final String image;
  final String title;
  final String price;

  CartItem({
    required this.image,
    required this.title,
    required this.price,
  });
}

CartItemModel cartItemModelFromJson(String str) =>
    CartItemModel.fromJson(json.decode(str));

String cartItemModelToJson(CartItemModel data) => json.encode(data.toJson());

class CartItemModel {
  List<Order> orders;

  CartItemModel({
    required this.orders,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  String id;
  String name;
  String productId;
  String productImage;
  int unitPrice;
  int quantity;
  int totalPrice;
  DateTime createdAt;
  DateTime updatedAt;

  Order({
    required this.id,
    required this.name,
    required this.productId,
    required this.productImage,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        name: json["name"],
        productId: json["productId"],
        productImage: json["productImage"],
        unitPrice: json["unitPrice"],
        quantity: json["quantity"],
        totalPrice: json["totalPrice"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "productId": productId,
        "productImage": productImage,
        "unitPrice": unitPrice,
        "quantity": quantity,
        "totalPrice": totalPrice,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
