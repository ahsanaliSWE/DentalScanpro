import 'package:dentalscanpro/view_models/controller/splash_screen/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dentalscanpro/constants/image_string.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final SplashScreenController controller = Get.put(SplashScreenController());

    controller.startAnimation(); 

    return Scaffold(
      backgroundColor: Colors.lightBlue[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => AnimatedOpacity(
              duration: const Duration(milliseconds: 1500),
              opacity: controller.animate.value ? 1.0 : 0,
              child: Image.asset(whiteTeeth, height: 200, width: 200),
            )),
            Obx(() => AnimatedContainer(
              width: controller.animate.value ? 300 : 0,
              duration: const Duration(milliseconds: 1500),
              child: Image.asset(textLogowhite, width: 300),
            )),
          ],
        ),
      ),
    );
  }
}
