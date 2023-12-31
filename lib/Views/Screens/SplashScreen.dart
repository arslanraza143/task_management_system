import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('')),
        ),
      ),
    );
  }
}
