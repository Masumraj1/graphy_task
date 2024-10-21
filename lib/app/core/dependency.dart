
import 'package:get/get.dart';
import 'package:graphy_task/app/modules/product_screen/controllers/home_controller.dart';


class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController(), fenix: true);
  }
}