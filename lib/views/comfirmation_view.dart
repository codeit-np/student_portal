import 'package:codeit/controller/course_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConfirmationView extends StatelessWidget {
  const ConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    final courseController = Get.find<CourseController>();

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Success Icon with Circle
                Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade50,
                  ),
                  child: Icon(
                    Icons.check_circle_rounded,
                    size: 100.w,
                    color: Colors.green.shade600,
                  ),
                ),

                32.verticalSpace,

                // Thank You Text
                Text(
                  "Thank You!",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                      ),
                ),

                8.verticalSpace,

                Text(
                  "Your course purchase was successful",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                  textAlign: TextAlign.center,
                ),

                40.verticalSpace,

                // Course Info Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.school_rounded, size: 48.w, color: Colors.deepPurple),
                      16.verticalSpace,
                 Text(
                            "Premium Course",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                 ),
                      8.verticalSpace,
                      Text(
                        "You are now enrolled!",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                40.verticalSpace,

                // Success Message Box
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.green.shade700, size: 28.w),
                      16.horizontalSpace,
                      Expanded(
                        child: Text(
                          "Your payment has been received successfully.\nYou can start learning immediately.",
                          style: TextStyle(
                            fontSize: 15.sp,
                            height: 1.4,
                            color: Colors.green.shade800,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),

                50.verticalSpace,

                // Action Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: FilledButton.icon(
                    onPressed: () async {
                      Get.offAndToNamed(AppRoutes.dashboard);
                      Loader.show(context);
                      await courseController.getCourses();
                      Loader.hide();
                    },
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: Text(
                      "Go to My Courses",
                      style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ),
                ),

                20.verticalSpace,

                // Secondary Button
                TextButton(
                  onPressed: () => Get.offAndToNamed(AppRoutes.dashboard),
                  child: Text(
                    "Back to Home",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}