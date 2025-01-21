import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hng_shoppers/constants/colors.dart';
import 'package:hng_shoppers/controllers/product_details_controller.dart';
import 'package:hng_shoppers/views/product_details/components/rounded_button_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,  
    required this.imageUrl,
    required this.name,
    required this.productId,
    required this.price,
  });
  final String imageUrl, name, productId;
  final int price;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailsController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 350,
                      child: Image.network(imageUrl, fit: BoxFit.fill),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "₦ ${controller.getPrice(price)}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const Spacer(),
                        RoundedIconBtn(
                          icon: Icons.remove,
                          press: controller.remove,
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "${controller.qty}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: RoundedIconBtn(
                            icon: Icons.add,
                            showShadow: true,
                            press: controller.add,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Obx(
                      () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.greenColor,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 48),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () => controller.addToCart(productId),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text('Add to Cart')),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'More Details',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Gear up with the latest collections from adidas Originals, Running, Football, Training. With over 20,000+ products, you will never run out of choice. Grab your favorites now. Secure Payments. 100% Original Products. Gear up with adidas.',
                        style: TextStyle(color: Color(0xffaaa8a8)),
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        color: AppTheme.greenColor,
                        shape: const CircleBorder(),
                        child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.arrow_back)),
                      ),
                      Card(
                        color: AppTheme.greenColor,
                        shape: const CircleBorder(),
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.share)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
