import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hng_shoppers/controllers/product_details_controller.dart';
import 'package:hng_shoppers/views/bottom_nav_bar.dart';
import 'package:hng_shoppers/views/cart_page/components/cart_listview_widget.dart';
import 'package:hng_shoppers/views/check_out_page.dart';
import 'package:hng_shoppers/widgets/service_loading_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailsController());
    controller.loadProducts();
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const BottomNavigations(),
        ));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Cart',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            centerTitle: true,
            elevation: 5,
            shadowColor: Colors.black),
        body: Obx(() {
          final future = controller.getOrders.value;
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
                      return const Center(child: Text('Cart list is empty'));
                    } else {
                      var cartItems = snapshot.data!;
                      return Column(
                        children: [
                          CartListViewWidget(cartItems: cartItems),
                          const SizedBox(height: 10),
                          // const Text('Total Price'),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 8),
                          //   child: Text(
                          //     'Rs. ${_calculateTotalPrice().toStringAsFixed(2)}',
                          //     style: const TextStyle(
                          //         fontSize: 20, fontWeight: FontWeight.w600),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow),
                                onPressed: () {
                                  if (cartItems.isNotEmpty) {
                                    cartItems.clear();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CheckOutPage(),
                                        ));
                                  }
                                },
                                child: const Center(child: Text('CHECK OUT'))),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    }
                  },
                );
        }),
      ),
    );
  }
}
