import 'package:codeit/controller/forgot_password_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ForgotPasswordController controller =
      Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(
                padding: EdgeInsets.all(16.0.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppStrings.logo, width: 200.w),
                    16.verticalSpace,
                    Text(
                      "Reset your password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      "Enter your email to receive an OTP",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    32.verticalSpace,
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: "Enter your email address",
                              labelText: "Email Address",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Email required';
                              if (!GetUtils.isEmail(value))
                                return 'Enter valid email';
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
                                  controller.sendOtp(
                                    controller.emailController.text,
                                  );
                                }
                              },
                              child: const Text(
                                "Send OTP",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
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
