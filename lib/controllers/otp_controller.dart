import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hng_shoppers/constants/toast.dart';
import 'package:hng_shoppers/controllers/login_controller.dart';
import 'package:hng_shoppers/controllers/sign_up_controller.dart';
import 'package:hng_shoppers/network/service_call.dart';
import 'package:hng_shoppers/views/bottom_nav_bar.dart';

class OtpController extends GetxController {
  RxInt counter = 60.obs;
  Timer? timer;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer(); // Start the timer as soon as the screen is entered
  }

  Future<void> verifyOtp(String value) async {
    final otpModel = {"email": loginResponseModel.email, "otp": value};
    print('res - $otpModel');
    try {
      isLoading.value = true;
      final res = await httpPost(
        url: 'user/verifyOtp',
        body: jsonEncode(otpModel),
      );
      print('Data - ${res.statusCode}-${res.body}');
      isLoading.value = false;
      if (res.statusCode == 200) {
        toast(message: 'Email successfully verified');
        Get.off(const BottomNavigations());
      } else {
        errorResponseMethod(res);
      }
    } catch (e) {
      isLoading.value = false;
      toast(message: 'An error occurred: $e');
    }
  }

  Future<void> resentOtp() async {
    final otpModel = {"email": loginResponseModel.email};

    try {
      final res = await httpPost(
        url: 'user/resendOtp',
        body: jsonEncode(otpModel),
      );
      print('Data - ${res.statusCode}-${res.body}');
      if (res.statusCode == 200) {
        toast(message: 'OTP resent successfully, check you email for new otp.');
      } else {
        errorResponseMethod(res);
      }
    } catch (e) {
      toast(message: 'An error occurred: $e');
    }
  }

  void startTimer() {
    counter.value = 60; // Reset counter
    if (timer == null || !timer!.isActive) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (counter.value == 0) {
            timer.cancel();
          } else {
            counter.value--;
          }
        },
      );
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
