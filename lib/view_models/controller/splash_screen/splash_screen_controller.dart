import 'package:dentalscanpro/view/login_screen.dart';
import 'package:dentalscanpro/view/navigation_menu.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController{
  static SplashScreenController get find => Get.find();

  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 200));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 3000));
     Get.off(() =>  LoginScreen());
  }
}