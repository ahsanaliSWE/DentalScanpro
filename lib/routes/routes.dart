import 'package:dentalscanpro/routes/routes_name.dart';
import 'package:dentalscanpro/view/home_screen.dart';
import 'package:dentalscanpro/view/login_screen.dart';
import 'package:dentalscanpro/view/registration_screen.dart';
import 'package:dentalscanpro/view/splash_screen.dart';
import 'package:get/get.dart';


class AppRoutes {
    
    static appRoutes () => [
      GetPage(
        name: RouteName.SplashScreen, 
        page: () => const SplashScreen(),
        transitionDuration: const Duration(milliseconds: 500),
        transition: Transition.leftToRight
        ),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
       
    ];
}

