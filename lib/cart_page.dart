import 'package:flutter/material.dart';
import 'package:hng_shoppers/bottom_nav_bar.dart';
import 'package:hng_shoppers/check_out_page.dart';
import 'package:hng_shoppers/controller.dart';
import 'package:hng_shoppers/product_details.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeCart(CartItem item) {
    setState(() {
      cartItems.remove(item);
    });
  }

  // double _calculateTotalPrice() {
  //   double total = 0;
  //   for (var item in cartItems) {
  //     print('totall-${item.price}');
  //     double itemPrice = double.tryParse(item.price)!;
  //     print('tl-$itemPrice');
  //     total += itemPrice;
  //     print('toll-$total');
  //   }
  //   print('totall-$total');
  //   return total;
  // }

  @override
  Widget build(BuildContext context) {
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
            title: const Text('SHOPPERS',
                style: TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
            elevation: 5,
            shadowColor: Colors.black),
        body: cartItems.isEmpty
            ? const Center(
                child: Text('Cart list is empty'),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final items = cartItems[index];
                          return Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Card(
                                      elevation: 3,
                                      child: Row(
                                        children: [
                                          Flexible(
                                              child: Image.asset(items.image,
                                                  fit: BoxFit.fill)),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  items.title,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const Text('QTY 1'),
                                                Text(
                                                  items.price,
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () =>
                                                  _removeCart(items),
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.red))
                                        ],
                                      ))),
                            ],
                          );
                        }),
                  ),
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
                                  builder: (context) => const CheckOutPage(),
                                ));
                          }
                        },
                        child: const Center(child: Text('CHECK OUT'))),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}
