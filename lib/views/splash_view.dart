import 'package:codeit/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppStrings.logo,width: 170.w,),
        8.verticalSpace,
        Text("Nepal's Most Affordable IT Training",style: TextStyle(fontSize: 14.sp),)
      ],
    )));
  }
}
