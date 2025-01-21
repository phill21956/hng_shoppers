import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:hng_shoppers/constants/colors.dart';
import 'package:hng_shoppers/controllers/login_controller.dart';
import 'package:hng_shoppers/controllers/otp_controller.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: LogoWithTitle(
        title: 'Verification',
        subText: "Email Verification code has been sent",
        children: [
          Text(loginResponseModel.email),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          const OtpTextFieldWidget(),
          const SizedBox(height: 24),
          Obx(() => ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF00BF6D),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Continue"),
              )),
          const SizedBox(height: 30),
          const Center(
            child: Text("Haven’t received the code yet?",
                style: TextStyle(
                    color: AppTheme.greenColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14)),
          ),
          Center(
            child: Obx(
              () => TextButton(
                onPressed: () {
                  if (controller.counter.value == 0) {
                    controller.startTimer();
                    controller.resentOtp();
                  }
                },
                child: controller.counter.value == 0
                    ? const Text(
                        "Resend OTP.",
                        style: TextStyle(
                            color: AppTheme.greenColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      )
                    : Text(
                        "Tap here to resend OTP in ${controller.counter.value}.",
                        style: const TextStyle(
                            color: Color(0xff777777),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

class LogoWithTitle extends StatelessWidget {
  final String title, subText;
  final List<Widget> children;

  const LogoWithTitle(
      {Key? key,
      required this.title,
      this.subText = '',
      required this.children})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: constraints.maxHeight * 0.1),
              Image.network(
                "https://i.postimg.cc/nz0YBQcH/Logo-light.png",
                height: 100,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.1,
                width: double.infinity,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  subText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.64),
                  ),
                ),
              ),
              ...children,
            ],
          ),
        );
      }),
    );
  }
}

class OtpTextFieldWidget extends StatelessWidget {
  const OtpTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController());
    return OtpTextField(
      numberOfFields: 5,
      fillColor: AppTheme.fillColor,
      filled: true,
      borderRadius: BorderRadius.circular(10),
      borderColor: AppTheme.inactiveColor,
      enabledBorderColor: AppTheme.inactiveColor,
      borderWidth: 1,
      obscureText: false,
      showFieldAsBox: true,
      textStyle: const TextStyle(color: Colors.black),
      onSubmit: (value) {
        controller.verifyOtp(value);
      },
    );
  }
}
