import 'package:codeit/controller/forgot_password_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ForgotPasswordController controller = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8FAFC),
              Color(0xFFEEF2FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  children: [
                    // Logo
                    Image.asset(AppStrings.logo, width: 180.w),
                    Gap(40.h),

                    // Icon / Illustration Area
                    Container(
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: AppColor.primaryOrange.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_reset_rounded,
                        size: 64.sp,
                        color: AppColor.primaryOrange,
                      ),
                    ),
                    Gap(32.h),

                    // Header
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Gap(12.h),
                    Text(
                      "Enter your email address and we'll send you an OTP to reset your password.",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(40.h),

                    // Form Card
                    Container(
                      padding: EdgeInsets.all(24.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email Field
                            TextFormField(
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Email Address",
                                hintText: "you@example.com",
                                prefixIcon: const Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide(color: Colors.grey.shade200),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide(
                                    color: AppColor.primaryOrange,
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                }
                                if (!GetUtils.isEmail(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            Gap(32.h),

                            // Send OTP Button
                            SizedBox(
                              width: double.infinity,
                              height: 56.h,
                              child: ElevatedButton(
                                onPressed: () async{
                                  if (_formKey.currentState!.validate())  {
                                    Loader.show(context);
                                    await controller.sendOtp(
                                      controller.emailController.text.trim(),
                                    );
                                    Loader.hide();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primaryOrange,
                                  foregroundColor: Colors.white,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                ),
                                child: Text(
                                  "Send OTP",
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Gap(40.h),

                    // Footer
                    Text(
                      "© 2026 Code IT. All rights reserved.",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}