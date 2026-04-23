import 'package:codeit/controller/auth_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:codeit/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            if (width < 600) {
              return _buildMobileUI(context, key);
            } else if (width < 1024) {
              return _buildTabUI(context, key);
            } else {
              return _buildDesktopUI(context, key);
            }
          },
        ),
      ),
    );
  }

  //Mobile UI
  Padding _buildMobileUI(BuildContext context, GlobalKey<FormState> key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Logo
            Image.asset(AppStrings.logo, width: 142),
            8.verticalSpace,
            Text(
              "Student Portal",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            4.verticalSpace,
            Text(
              "Sign in to your student portal",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            16.verticalSpace,

            Form(
              key: key,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.email,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      labelText: 'Email address',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),

                  8.verticalSpace,

                  Obx(() {
                    return TextFormField(
                      obscureText: controller.obsecure.value,
                      controller: controller.password,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_open_outlined),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.visibility();
                          },
                          icon: controller.obsecure.value == true
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                    );
                  }),

                  8.verticalSpace,

                  Obx(() {
                    return Row(
                      children: [
                        Checkbox(
                          value: controller.isRemember.value,
                          onChanged: (value) {
                            controller.remember(value!);
                          },
                        ),
                        Text("Remember me"),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.forgotPassword);
                          },
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  }),

                  8.verticalSpace,

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColor.primaryOrange,
                      ),
                      onPressed: () async{
                         if (key.currentState!.validate()) {
                            Loader.show(context);
                            await controller.login();
                            Loader.hide();
                          }
                      },
                      child: Text("Sign in "),
                    ),
                  ),

                  // 16.verticalSpace,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text("New Student?"),
                  //     Gap(4),
                  //     GestureDetector(
                  //       onTap: () {
                  //       controller.reset();
                  //         Get.toNamed(AppRoutes.register);
                  //       },
                  //       child: Text(
                  //         "Create Account",
                  //         style: TextStyle(fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                 
                  // SizedBox(
                  //   width: 300,
                  //   child: Column(
                  //     children: [
                  //       Text("Note",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
                  //       Text("Enter the email and password you used when enrolling on the website.",style:Theme.of(context).textTheme.labelMedium,textAlign:  TextAlign.center,),
                  //     ],
                  //   ))
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Tab UI
  Padding _buildTabUI(BuildContext context, GlobalKey<FormState> key) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Logo
              Image.asset(AppStrings.logo, width: 220),
              8.verticalSpace,
              Text(
                "Student Portal",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              4.verticalSpace,
              Text(
                "Sign in to your student portal",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Gap(12),

              Form(
                key: key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        labelText: 'Email address',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'email required' : null,
                    ),

                    8.verticalSpace,

                    Obx(() {
                      return TextFormField(
                        obscureText: controller.obsecure.value,
                        controller: controller.password,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_open_outlined),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.visibility();
                            },
                            icon: controller.obsecure.value == true
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'password required' : null,
                      );
                    }),

                    8.verticalSpace,

                    Obx(() {
                      return Row(
                        children: [
                          Checkbox(
                            value: controller.isRemember.value,
                            onChanged: (value) {
                              controller.remember(value!);
                            },
                          ),
                          Text("Remember me"),
                          Spacer(),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    }),

                    8.verticalSpace,

                    SizedBox(
                      height: 32.h,
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColor.primaryOrange,
                        ),
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            Loader.show(context);
                            await controller.login();
                            Loader.hide();
                          }
                        },
                        child: Text("Sign in ", style: TextStyle(fontSize: 18)),
                      ),
                    ),

                    // 16.verticalSpace,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text("New Student?"),
                    //     Gap(4),
                    //     GestureDetector(
                    //       onTap: () {
                    //         controller.reset();
                    //         Get.toNamed(AppRoutes.register);
                    //       },
                    //       child: Text(
                    //         "Create Account",
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Desktop UI
  Padding _buildDesktopUI(BuildContext context, GlobalKey<FormState> key) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Logo
              Image.asset(AppStrings.logo, width: 220),
              8.verticalSpace,
              Text(
                "Student Portal",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              4.verticalSpace,
              Text(
                "Sign in to your student portal",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Gap(12),

              Form(
                key: key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        labelText: 'Email address',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'email required' : null,
                    ),

                    8.verticalSpace,

                    Obx(() {
                      return TextFormField(
                        obscureText: controller.obsecure.value,
                        controller: controller.password,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_open_outlined),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.visibility();
                            },
                            icon: controller.obsecure.value == true
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'password required' : null,
                      );
                    }),

                    8.verticalSpace,

                    Obx(() {
                      return Row(
                        children: [
                          Checkbox(
                            value: controller.isRemember.value,
                            onChanged: (value) {
                              controller.remember(value!);
                            },
                          ),
                          Text("Remember me"),
                          Spacer(),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    }),

                    8.verticalSpace,

                    SizedBox(
                      height: 32.h,
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColor.primaryOrange,
                        ),
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            Loader.show(context);
                            await controller.login();
                            Loader.hide();
                          }
                        },
                        child: Text("Sign in ", style: TextStyle(fontSize: 18)),
                      ),
                    ),

                    // 16.verticalSpace,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text("New Student?"),
                    //     Gap(4),
                    //     GestureDetector(
                    //       onTap: () {
                    //         controller.reset();
                    //         Get.toNamed(AppRoutes.register);
                    //       },
                    //       child: Text(
                    //         "Create Account",
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
