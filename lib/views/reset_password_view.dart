import 'package:codeit/controller/forgot_password_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ForgotPasswordController controller = Get.find<ForgotPasswordController>();
  bool obscureNew = true;
  bool obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password"), centerTitle: true, elevation: 0, backgroundColor: Colors.transparent, foregroundColor: Colors.black),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: EdgeInsets.all(16.0.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppStrings.logo, width: 200.w),
                    16.verticalSpace,
                    Text(
                      "Reset Your Password",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
                    ),
                    8.verticalSpace,
                    Text(
                      "Enter your new password below",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    32.verticalSpace,
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.newPasswordController,
                            obscureText: obscureNew,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(obscureNew ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    obscureNew = !obscureNew;
                                  });
                                },
                              ),
                              hintText: "Enter new password",
                              labelText: "New Password",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Password required';
                              if (value.length < 6) return 'Password too short';
                              return null;
                            },
                          ),
                          16.verticalSpace,
                          TextFormField(
                            controller: controller.confirmPasswordController,
                            obscureText: obscureConfirm,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(obscureConfirm ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    obscureConfirm = !obscureConfirm;
                                  });
                                },
                              ),
                              hintText: "Confirm your password",
                              labelText: "Confirm Password",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Confirm password required';
                              if (value != controller.newPasswordController.text) return 'Passwords do not match';
                              return null;
                            },
                          ),
                          24.verticalSpace,
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              color: AppColor.primaryOrange,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.resetPassword();
                                }
                              },
                              child: const Text(
                                "Reset Password",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
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
