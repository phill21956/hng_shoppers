import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hng_shoppers/constants/toast.dart';
import 'package:hng_shoppers/models/auth_models/signup_post_model.dart';
import 'package:hng_shoppers/models/error_response_model.dart';
import 'package:hng_shoppers/network/service_call.dart';
import 'package:hng_shoppers/views/auth/login.dart';

class SignUpController extends GetxController {
  final RxBool isLoading = false.obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;

  Future<void> signUp() async {
    final signUpModel = SignUpPostModel(
      fullname: nameController.value.text,
      email: emailController.value.text,
      password: passwordController.value.text,
    );
    print('res - $signUpModel');
    try {
      isLoading.value = true;
      final res = await httpPost(
        url: 'user/signUp',
        body: jsonEncode(signUpModel),
      );
      print('signUpData - ${res.statusCode}-${res.body}');
      isLoading.value = false;
      if (res.statusCode == 201) {
        nameController.value.clear();
        emailController.value.clear();
        passwordController.value.clear();
        confirmPasswordController.value.clear();
        toast(message: 'User successfully created, Login to continue');
        Get.off(SignInScreen());
      } else {
        errorResponseMethod(res);
      }
    } catch (e) {
      isLoading.value = false;
      toast(message: 'An error occurred: $e');
    }
  }
}

void errorResponseMethod(res) {
  var responseData = errorResponseModelFromJson(res.body);
  toast(message: 'An error occurred: ${responseData.message}');
}
