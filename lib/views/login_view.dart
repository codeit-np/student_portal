import 'package:codeit/controller/auth_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:codeit/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Image.asset(
                      AppStrings.logo,
                      width: 180.w,
                    ),
                    Gap(32.h),

                    // Header
                    Text(
                      "Student Portal",
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Gap(8.h),
                    Text(
                      "Sign in to continue your learning journey",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(40.h),

                    // Login Card
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Email Field
                            TextFormField(
                              controller: authController.email,
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
                                  borderSide: BorderSide(color: AppColor.primaryOrange, width: 2),
                                ),
                              ),
                              validator: (value) =>
                                  value!.isEmpty ? 'Email is required' : null,
                            ),
                            Gap(20.h),

                            // Password Field
                            Obx(
                              () => TextFormField(
                                controller: authController.password,
                                obscureText: authController.obsecure.value,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  hintText: "Enter your password",
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                    onPressed: authController.visibility,
                                    icon: Icon(
                                      authController.obsecure.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide(color: Colors.grey.shade200),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide(color: AppColor.primaryOrange, width: 2),
                                  ),
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? 'Password is required' : null,
                              ),
                            ),
                            Gap(16.h),

                            // Remember + Forgot
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx((){
                                  return  Row(
                                  children: [
                                    Checkbox(
                                      value: authController.isRemember.value, // You can make this reactive later
                                      onChanged: (value) {
                                        authController.remember(value!);
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.r),
                                      ),
                                    ),
                                    Text(
                                      "Remember me",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                );
                               
                                }),
                                
                                GestureDetector(
                                  onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: AppColor.primaryOrange,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gap(32.h),

                            // Sign In Button
                            SizedBox(
                              width: double.infinity,
                              height: 56.h,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Loader.show(context);
                                    await authController.login();
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
                                  "Sign In",
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

                    Gap(32.h),

                    // Create Account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Gap(6.w),
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.register),
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              color: AppColor.primaryOrange,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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