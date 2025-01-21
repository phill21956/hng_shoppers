import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.imageCard,
    required this.cardTitle,
    required this.cardPrice,
  });
  final String imageCard;
  final String cardTitle;
  final String cardPrice;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Expanded(
          child: Image.network(
            imageCard,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "₦ $cardPrice",
                ),
              ],
            )),
      ]),
    );
  }
}
