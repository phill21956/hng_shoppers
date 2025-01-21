import 'dart:convert';

import 'package:get/get.dart';
import 'package:hng_shoppers/constants/toast.dart';
import 'package:hng_shoppers/controllers/login_controller.dart';
import 'package:hng_shoppers/controllers/sign_up_controller.dart';
import 'package:hng_shoppers/models/cart_model.dart';
import 'package:hng_shoppers/network/service_call.dart';
import 'package:hng_shoppers/views/bottom_nav_bar.dart';

class ProductDetailsController extends GetxController {
  final RxBool isLoading = false.obs;
  RxInt qty = 1.obs;
  RxInt qtyPrice = 0.obs;
  Rx<Future<List<Order>>?> getOrders = Rx<Future<List<Order>>?>(null);

  Future<List<Order>>? getOrder() async {
    try {
      final res = await httpGet(
          url: 'orders/getOrders', token: loginResponseModel.token);
      print('Data - ${res.statusCode}-${res.body}');
      if (res.statusCode == 200) {
        var orders = cartItemModelFromJson(res.body);
        return orders.orders;
      } else {
        errorResponseMethod(res);
      }
      return [];
    } catch (e) {
      print('ddata - $e');
      toast(message: 'An error occurred: $e');
      return [];
    }
  }

  Future<void> addToCart(String id) async {
    final loginModel = {"productId": id, "quantity": qty.value};
    try {
      isLoading.value = true;
      final res = await httpPost(
          url: 'orders/createOrder',
          body: jsonEncode(loginModel),
          token: loginResponseModel.token);
      print('Data - ${res.statusCode}-${res.body}');
      isLoading.value = false;
      if (res.statusCode == 200) {
        toast(message: 'Order successfully created');
        qty.value = 1;
        await loadProducts();
        Get.off(const BottomNavigations());
      } else {
        errorResponseMethod(res);
      }
    } catch (e) {
      isLoading.value = false;
      print('ddata - $e');
      toast(message: 'An error occurred: $e');
    }
  }

  deleteOrder(String id) async {
    print('ddata - $id');
    try {
      final res = await httpGet(
        url: 'orders/removeOrder/$id',
        token: loginResponseModel.token,
      );
      print('resData - ${res.statusCode} - ${res.body}');
      if (res.statusCode == 200) {
        toast(message: res.body);
        await loadProducts();
      } else {
        errorResponseMethod(res);
      }
    } catch (e) {
      print('ddata - $e');
      toast(message: 'An error occurred: $e');
    }
  }

  String getPrice(int price) {
    try {
      qtyPrice = price.obs;
      qtyPrice.value = qty.value * price;

      return qtyPrice.toString();
    } catch (e) {
      return 0.toString();
    }
  }

  add() {
    qty += 1;
  }

  remove() {
    if (qty > 1) {
      qty -= 1;
    }
  }

  loadProducts() async {
    getOrders.value = getOrder();
  }

  @override
  void onReady() {
    super.onReady();
    loadProducts();
  }
}
