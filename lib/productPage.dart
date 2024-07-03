import 'package:flutter/material.dart';
import 'package:hng_shoppers/prodCardWidget.dart';
import 'package:hng_shoppers/product_details.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});
  final products = [
    const ProductCardWidget(
      imageCard: 'assets/shoe1.png',
      cardTitle: 'Adidas Shoe',
      cardPrice: '₦ 200,000',
    ),
    const ProductCardWidget(
      imageCard: 'assets/shoe1.png',
      cardTitle: 'Adidas Shoe',
      cardPrice: '₦ 200,000',
    ),
    const ProductCardWidget(
      imageCard: 'assets/shoe2.png',
      cardTitle: 'Adidas Shoe',
      cardPrice: '₦ 200,000',
    ),
    const ProductCardWidget(
      imageCard: 'assets/watch.png',
      cardTitle: 'Smart Watch',
      cardPrice: '₦ 5,000',
    ),
    const ProductCardWidget(
      imageCard: 'assets/shoe1.png',
      cardTitle: 'Adidas Shoe',
      cardPrice: '₦ 200,000',
    ),
    const ProductCardWidget(
      imageCard: 'assets/watch.png',
      cardTitle: 'Smart Watch',
      cardPrice: '₦ 5,000',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('SHOPPERS',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 5,
          shadowColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemCount: products.length,
          itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsPage(products: products[index]),
                  )),
              child: products[index]),
        ),
      ),
    );
  }
}
