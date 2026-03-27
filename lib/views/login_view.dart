import 'package:codeit/controller/auth_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:codeit/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<FormState>();
    var authController = Get.find<AuthController>();
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
                    //Logo
                    Image.asset(AppStrings.logo, width: 200.w),
                    16.verticalSpace,
                    //SizedBox Header
                    SizedBox(
                      child: Column(
                        children: [
                          Text(
                            "Welcome Back!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.sp,
                            ),
                          ),
                          8.verticalSpace,
                          Text("Sign in to your student portal",style: TextStyle(fontSize: 16.sp),),
                        ],
                      ),
                    ),

                    16.verticalSpace,
                    //Login Form
                    SizedBox(
                      width: 428,
                      child: Form(
                        key: key,
                        child: Column(
                          children: [
                            //Email Address
                            TextFormField(
                              controller: authController.email,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hint: Text("Enter your email address"),
                                label: Text("Email Address"),
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                              ),
                              validator: (value) =>
                                  value!.isEmpty ? 'email required' : null,
                            ),
                            8.verticalSpace,

                          Obx((){
                            return TextFormField(
                              controller: authController.password,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    authController.visibility();
                                  },
                                  icon: authController.obsecure.value == true ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                                ),
                                hint: Text("Enter your password"),
                                label: Text("Password"),
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                              ),
                              obscureText: authController.obsecure.value,
                              validator: (value) =>
                                  value!.isEmpty ? 'password required' : null,
                            );
                          }),
                            

                            8.verticalSpace,

                            Row(
                              children: [
                                Checkbox(value: false, onChanged: (valuye) {}),
                                Gap(2),
                                Text("Remember me"),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {},
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
                            8.verticalSpace,
                            SizedBox(
                              width: double.infinity,

                              height: 50,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                color: AppColor.primaryOrange,
                                onPressed: () async {
                                  if (key.currentState!.validate()) {
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

                            //Don't have an Account
                            16.verticalSpace,

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    
                                  ),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
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
