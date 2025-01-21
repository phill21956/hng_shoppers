import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hng_shoppers/controllers/product_controller.dart';
import 'package:hng_shoppers/models/product_model.dart';
import 'package:hng_shoppers/views/product_details/product_details.dart';
import 'package:hng_shoppers/widgets/prodCardWidget.dart';

class ProductViewBuilder extends StatelessWidget {
  const ProductViewBuilder({
    super.key,
    required this.productItemModel,
  });
  final List<Product> productItemModel;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: productItemModel.length,
        itemBuilder: (context, index) => GestureDetector(
            onLongPress: () {
              removeProductMethd(context, controller, index);
            },
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                    imageUrl: productItemModel[index].productImageUrl,
                    name: productItemModel[index].product,
                    price: productItemModel[index].price,
                    productId: productItemModel[index].id,
                  ),
                )),
            child: ProductCardWidget(
                imageCard: productItemModel[index].productImageUrl,
                cardTitle: productItemModel[index].product,
                cardPrice: productItemModel[index].price.toString())),
      ),
    );
  }

  Future<dynamic> removeProductMethd(
      BuildContext context, ProductController controller, int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: const Text('Do you want to delete this product?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                controller.deleteProduct(productItemModel[index].id);
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
