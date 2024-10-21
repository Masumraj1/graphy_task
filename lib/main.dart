import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:graphy_task/app/core/app_routes.dart';
import 'package:graphy_task/app/core/dependency.dart';
import 'package:graphy_task/app/global/helper/device_utils/device_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('products');
  DeviceUtils.lockDevicePortrait();
  DependencyInjection di = DependencyInjection();
  di.dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 200),
        initialRoute: AppRoute.homeScreen,
        navigatorKey: Get.key,
        getPages: AppRoute.routes,
      ),
    );
  }
}






