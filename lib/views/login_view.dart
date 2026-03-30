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
  // ✅ Keep form key outside build
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: EdgeInsets.all(16.0.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Image.asset(AppStrings.logo, width: 200.w),
                    16.verticalSpace,

                    // Header
                    Column(
                      children: [
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.sp,
                          ),
                        ),
                        8.verticalSpace,
                        Text(
                          "Sign in to your student portal",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                    16.verticalSpace,

                    // Login Form
                    SizedBox(
                      width: 428,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email Field
                            TextFormField(
                              controller: authController.email,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: "Enter your email address",
                                labelText: "Email Address",
                              ),
                              validator: (value) =>
                                  value!.isEmpty ? 'Email required' : null,
                            ),
                            8.verticalSpace,

                            // Password Field (Reactive)
                            Obx(
                              () => TextFormField(
                                controller: authController.password,
                                obscureText: authController.obsecure.value,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    onPressed: authController.visibility,
                                    icon: authController.obsecure.value
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                  ),
                                  hintText: "Enter your password",
                                  labelText: "Password",
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? 'Password required' : null,
                              ),
                            ),
                            16.verticalSpace,

                            // Remember + Forgot Password
                            Row(
                              children: [
                                Checkbox(
                                  value: false,
                                  onChanged: (value) {},
                                ),
                                Gap(2),
                                Text("Remember me"),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.forgotPassword);
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: AppColor.primaryOrange,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // 8.verticalSpace,

                            // Sign In Button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                color: AppColor.primaryOrange,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Loader.show(context);
                                    await authController.login();
                                    Loader.hide();
                                  }
                                },
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            16.verticalSpace,

                            // Create Account
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Gap(4),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.register);
                                  },
                                  child: Text(
                                    "Create Account",
                                    style: TextStyle(
                                      color: AppColor.primaryOrange,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    40.verticalSpace,

                    // Footer
                    const Text(
                      "© 2026 Code IT. All rights reserved.",
                      style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
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