import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hng_shoppers/controllers/product_details_controller.dart';
import 'package:hng_shoppers/models/cart_model.dart';
import 'package:hng_shoppers/views/product_details/product_details.dart';

class CartListViewWidget extends StatelessWidget {
  const CartListViewWidget({
    super.key,
    required this.cartItems,
  });

  final List<Order> cartItems;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailsController());
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            final items = cartItems[index];
            return InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsPage(
                      imageUrl: items.productImage,
                      name: items.name,
                      price: items.unitPrice,
                      productId: items.productId,
                    ),
                  )),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Card(
                      elevation: 3,
                      child: Row(
                        children: [
                          Flexible(
                              child: Image.network(items.productImage,
                                  fit: BoxFit.fill)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text('Name : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    Text(items.name),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Qty: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    Text('${items.quantity}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Amt: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    Text(
                                      "₦ ${items.totalPrice}",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                removeProductMethd(context, controller, index);
                              },
                              icon: const Icon(Icons.delete, color: Colors.red))
                        ],
                      ))),
            );
          }),
    );
  }

  Future<dynamic> removeProductMethd(
      BuildContext context, ProductDetailsController controller, int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Order'),
          content: const Text('Do you want to remover this order?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                controller.deleteOrder(cartItems[index].id);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
