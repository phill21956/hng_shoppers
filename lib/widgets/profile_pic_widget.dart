import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hng_shoppers/constants/colors.dart';
import 'package:hng_shoppers/controllers/product_controller.dart';

class PicturePickerWidget extends StatelessWidget {
  const PicturePickerWidget({
    super.key,
    required this.controller,
  });
  final ProductController controller;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Obx(() {
            return SizedBox(
              height: 96,
              width: 96,
              child: CircleAvatar(
                backgroundImage: controller.selectedImage.value != null
                    ? FileImage(controller.selectedImage.value!)
                    : const AssetImage('assets/empty.png') as ImageProvider,
              ),
            );
          }),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(shape: BoxShape.rectangle),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: controller.pickImage,
                  icon: const Icon(Icons.add_a_photo_outlined),
                  color: AppTheme.darkColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
