import 'package:dentalscanpro/view/appointement_screen.dart';
import 'package:dentalscanpro/view/education_screen.dart';
import 'package:dentalscanpro/view/home_screen.dart';
import 'package:dentalscanpro/view/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Obx(
        () => Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (value) {
            setState(() {
              controller.selectedIndex.value = value;
            });
          },
          selectedIndex: NavigationController.instance.selectedIndex.value,
          indicatorColor: Colors.lightBlueAccent,
          surfaceTintColor: Colors.white,
          
                  
          elevation: 0,
          destinations: const  [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.search), label: 'Scan'),
            NavigationDestination(icon: Icon(Icons.schedule_rounded), label: 'Appointemnt'),
            NavigationDestination(icon: Icon(Icons.menu_book_rounded), label: 'Library'),
          ],
        ),
        body: controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}


class NavigationController extends GetxController{
  static NavigationController get instance => Get.find();

  RxInt selectedIndex = 0.obs;

  List<Widget> screens = [
     HomeScreen(),
    const ScanScreen(),
          AppointmentScreen(),
          const EducationScreen()
  ];
}
