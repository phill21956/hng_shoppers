import 'package:flutter/material.dart';
import 'package:hng_shoppers/constants/colors.dart';

class ServiceLoading extends StatelessWidget {
  const ServiceLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 190,
        child: Row(
          children: List.generate(
            5,
            (index) => Container(
              width: 190,
              height: 204,
              padding: const EdgeInsets.symmetric(vertical: 8),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(12),
                color: AppTheme.greyColor,
                backgroundColor: Colors.grey.shade100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
