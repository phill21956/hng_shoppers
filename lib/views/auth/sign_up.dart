import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hng_shoppers/constants/colors.dart';
import 'package:hng_shoppers/controllers/sign_up_controller.dart';
import 'package:hng_shoppers/views/auth/login.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.08),
                Image.network(
                  "https://i.postimg.cc/nz0YBQcH/Logo-light.png",
                  height: 100,
                ),
                SizedBox(height: constraints.maxHeight * 0.08),
                Text(
                  "Sign Up",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: controller.nameController.value,
                        hintText: 'Full name',
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          controller.nameController.value.text = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextFormField(
                        controller: controller.emailController.value,
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null; // Valid case
                        },
                        onChanged: (value) {
                          controller.emailController.value.text = value;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextFormField(
                        controller: controller.passwordController.value,
                        hintText: 'Password',
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          final passwordRegex = RegExp(r'^.{5,}$');
                          if (!passwordRegex.hasMatch(value)) {
                            return 'Password must be at least 5 characters long';
                          }
                          return null; // Valid case
                        },
                        onChanged: (value) {
                          controller.passwordController.value.text = value;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextFormField(
                        controller: controller.confirmPasswordController.value,
                        hintText: 'Confirm Password',
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          final passwordRegex = RegExp(r'^.{5,}$');
                          if (!passwordRegex.hasMatch(value)) {
                            return 'Password must be at least 5 characters long';
                          }
                          if (controller.passwordController.value.text !=
                              controller.confirmPasswordController.value.text) {
                            return 'Password mismatch';
                          }
                          return null; // Valid case
                        },
                        onChanged: (value) {
                          controller.confirmPasswordController.value.text =
                              value;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Obx(
                        () => ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.signUp();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xFF00BF6D),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 48),
                            shape: const StadiumBorder(),
                          ),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text("Sign Up"),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                        ),
                        child: Text.rich(
                          const TextSpan(
                            text: "Already have an account? ",
                            children: [
                              TextSpan(
                                text: "Sign in",
                                style: TextStyle(color: AppTheme.greenColor),
                              ),
                            ],
                          ),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.64),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator,
      this.onChanged,
      this.keyboardType,
      this.obscureText = false,
      this.textInputAction});

  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextInputAction? textInputAction;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppTheme.fillColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0 * 1.5, vertical: 16.0),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      textInputAction: textInputAction,
    );
  }
}
