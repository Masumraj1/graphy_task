import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graphy_task/app/utils/app_colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SpinKitCircle(
        color: AppColors.buttonColor,
        size: 60.0.sp,
      ),
    );
  }
}