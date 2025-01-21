import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hng_shoppers/controllers/product_controller.dart';
import 'package:hng_shoppers/views/auth/login.dart';
import 'package:hng_shoppers/widgets/profile_pic_widget.dart';
import 'package:hng_shoppers/widgets/service_loading_widget.dart';
import 'components/product_view_builder.dart';

class ProductPage extends StatelessWidget {
  final _createProductFormKey = GlobalKey<FormState>();
  ProductPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
        centerTitle: true,
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                await onLogOut(context);
              },
              icon: const Icon(Icons.logout_outlined),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final future = controller.getProducts.value;
        return future == null
            ? const ServiceLoading()
            : FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ServiceLoading();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return const Center(child: Text('No products available'));
                  } else {
                    return ProductViewBuilder(productItemModel: snapshot.data!);
                  }
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.bottomSheet(Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              )),
          child: Form(
            key: _createProductFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                shrinkWrap: true,
                children: [
                  PicturePickerWidget(controller: controller),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.productNameController.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your product name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      controller.productNameController.value.text = value;
                    },
                    decoration: const InputDecoration(hintText: 'Product name'),
                  ),
                  TextFormField(
                    controller: controller.productPriceController.value,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your price';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      controller.productPriceController.value.text = value;
                    },
                    decoration:
                        const InputDecoration(hintText: 'Product price'),
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        if (_createProductFormKey.currentState!.validate()) {
                          controller.createProduct();
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
                          : const Text("Create Product"),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        )),
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  onLogOut(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Get.offAll(SignInScreen());
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
