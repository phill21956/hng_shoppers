import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hng_shoppers/constants/colors.dart';
import 'package:hng_shoppers/controllers/product_details_controller.dart';
import 'package:hng_shoppers/views/cart_page/cart_page.dart';
import 'package:hng_shoppers/views/product_page/productPage.dart';

class BottomNavigations extends StatefulWidget {
  const BottomNavigations({super.key});

  @override
  State<BottomNavigations> createState() => _BottomNavigationsState();
}

class _BottomNavigationsState extends State<BottomNavigations> {
  int _selectedTab = 0;

  final List _pages = [ProductPage(), const CartPage()];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsController());
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: AppTheme.greenColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
        ],
      ),
    );
  }
}
