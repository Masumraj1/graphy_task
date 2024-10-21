
import 'package:get/get.dart';
import 'package:graphy_task/app/modules/product_screen/views/home_screen.dart';


class AppRoute {
  AppRoute._();
  ///==================== Initial Routes ====================
  static const String homeScreen = "/HomeScreen";




  static List<GetPage> routes = [
    ///==================== Initial Routes ====================
    GetPage(name: homeScreen, page: () =>  HomeScreen(),),

  ];
}