import 'package:flutter/material.dart';
import 'package:hng_shoppers/views/bottom_nav_bar.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/check.png', fit: BoxFit.contain),
          const SizedBox(height: 20),
          const Text(
            'Order Succesfully Checked Out!!!',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavigations(),
                      ));
                },
                child: const Center(child: Text('Go back to Home'))),
          ),
        ],
      )),
    );
  }
}
