import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_strings.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0F1E),
              Color(0xFF1A1A2E),
              Color(0xFF2C1A1A),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppStrings.logo,
                width: 210.w,
              ),
              60.verticalSpace,
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Nepal's Most Affordable\n",
                      style: TextStyle(
                        fontSize: 18.5.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                    TextSpan(
                      text: "IT Training",
                      style: TextStyle(
                        fontSize: 38.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              90.verticalSpace,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 30.w,
                    height: 30.w,
                    child: CircularProgressIndicator(
                      color: const Color(0xFFF36F21),
                      strokeWidth: 4.5,
                      backgroundColor: Colors.white.withOpacity(0.15),
                    ),
                  ),
                  18.horizontalSpace,
                  Text(
                    "Getting Ready...",
                    style: TextStyle(
                      fontSize: 15.5.sp,
                      color: Colors.white60,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}