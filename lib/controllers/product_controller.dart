import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hng_shoppers/constants/constants.dart';
import 'package:hng_shoppers/constants/toast.dart';
import 'package:hng_shoppers/controllers/login_controller.dart';
import 'package:hng_shoppers/controllers/sign_up_controller.dart';
import 'package:hng_shoppers/models/product_model.dart';
import 'package:hng_shoppers/network/service_call.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  RxList<Product> products = RxList([]);
  Rx<TextEditingController> productNameController = TextEditingController().obs;
  Rx<TextEditingController> productPriceController =
      TextEditingController().obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isLoading = false.obs;
  Rx<Future<List<Product>>?> getProducts = Rx<Future<List<Product>>?>(null);

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  Future<void> createProduct() async {
    if (selectedImage.value == null ||
        productNameController.value.text.isEmpty ||
        productPriceController.value.text.isEmpty) {
      toast(message: 'All fields are required, including the image.');
      return;
    }
    try {
      isLoading.value = true;
      final uri = Uri.parse('${baseUrl}product/createProduct');
      final request = http.MultipartRequest('POST', uri)
        ..fields['product'] = productNameController.value.text
        ..fields['price'] = productPriceController.value.text
        ..files.add(await http.MultipartFile.fromPath(
            'productImage', selectedImage.value!.path))
        ..headers.addAll({
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer ${loginResponseModel.token}',
        });
      final response = await request.send();

      isLoading.value = false;
      final responseData = await response.stream.bytesToString();
      print('resData - ${response.statusCode} - $responseData');
      if (response.statusCode == 200) {
        toast(message: 'Product successfully created');
        await loadProducts();
        productNameController.value.clear();
        productPriceController.value.clear();
        selectedImage.value = null;
        Get.back();
      } else {
        print('resData - $responseData');
        toast(message: responseData);
      }
    } catch (e) {
      isLoading.value = false;
      print('resData - $e');
      toast(message: 'An error occurred: $e');
    }
  }

  Future<List<Product>>? getProduct() async {
    try {
      final res = await httpGet(
        url: 'product/getProducts',
      );
      if (res.statusCode == 200) {
        var getProduct = getProductModelFromJson(res.body);

        return getProduct.products;
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

  loadProducts() async {
    getProducts.value = getProduct();
  }

  deleteProduct(String id) async {
    print('ddata - $id');
    try {
      final res = await httpGet(
        url: 'product/removeProduct/$id',
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

  @override
  void onReady() {
    super.onReady();
    loadProducts();
  }
}
