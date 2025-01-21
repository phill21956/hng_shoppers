import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hng_shoppers/constants/toast.dart';
import 'package:hng_shoppers/controllers/sign_up_controller.dart';
import 'package:hng_shoppers/models/auth_models/login_response_model.dart';
import 'package:hng_shoppers/models/auth_models/login_post_model.dart';
import 'package:hng_shoppers/network/service_call.dart';
import 'package:hng_shoppers/views/auth/otp_page.dart';
import 'package:hng_shoppers/views/bottom_nav_bar.dart';

User loginResponseModel = User(email: '', fullname: '', token: '', userid: '');

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  Rx<TextEditingController> loginEmailController = TextEditingController().obs;
  Rx<TextEditingController> loginPasswordController =
      TextEditingController().obs;

  Future<void> login() async {
    final loginModel = LoginPostModel(
      email: loginEmailController.value.text,
      password: loginPasswordController.value.text,
    );
    try {
      isLoading.value = true;
      final res = await httpPost(
        url: 'user/login',
        body: jsonEncode(loginModel),
      );
      print('loginData - ${res.statusCode}-${res.body}');
      isLoading.value = false;
      if (res.statusCode == 200) {
        var loginResponse = loginModelFromJson(res.body);
        loginResponseModel = loginResponse.user;
        loginEmailController.value.clear();
        loginPasswordController.value.clear();
        toast(message: loginResponse.message);
        Get.off(const BottomNavigations());
      } else if (res.statusCode == 403) {
        var loginResponse = loginModelFromJson(res.body);
        loginResponseModel = loginResponse.user;
        loginEmailController.value.clear();
        loginPasswordController.value.clear();
        toast(message: loginResponse.message);
        Get.off(const VerificationScreen());
      } else {
        errorResponseMethod(res);
      }
    } catch (e) {
      isLoading.value = false;
      print('ddata - $e');
      toast(message: 'An error occurred: $e');
    }
  }
}
