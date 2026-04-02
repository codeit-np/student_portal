import 'package:codeit/bindings/controller_bindings.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_pages.dart';
import 'package:codeit/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
     designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Code IT',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: AppColor.primaryOrange)),
        home:  SplashView(),
        getPages: AppPages.routes,
        initialBinding: ControllerBindings(),
      ),
    );
  }
}
