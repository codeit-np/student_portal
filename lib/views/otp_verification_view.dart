import 'package:codeit/controller/auth_controller.dart';
import 'package:codeit/controller/forgot_password_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({super.key});

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ForgotPasswordController controller = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            if (width < 600) {
              return _buildMobileUI(context);
            } else if (width < 1024) {
              return _buildTabUI(context);
            } else {
              return _buildDesktopUI(context);
            }
          },
        ),
      ),
    );
  }

//Mobile UI
  Center _buildMobileUI(BuildContext context) {
    return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 24.h,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    children: [
                      // Icon
                      Container(
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          color: AppColor.primaryOrange.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified_user_rounded,
                          size: 64.sp,
                          color: AppColor.primaryOrange,
                        ),
                      ),
                      Gap(32),

                      // Header
                      Text(
                        "Verify OTP",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Gap(12.h),
                      Text(
                        "Enter the 6-digit code sent to your email",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Gap(8.h),

                      // Show Email (Fixed - No unnecessary Obx)
                      Text(
                        controller.emailController.text,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.primaryOrange,
                        ),
                      ),

                      Gap(40.h),

                      // Form Card
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // OTP Field
                            TextFormField(
                              controller: controller.otpController,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 12.w,
                              ),
                              decoration: InputDecoration(
                                labelText: "OTP Code",
                                prefixIcon: const Icon(
                                  Icons.security_outlined,
                                ),
                                counterText: "",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'OTP is required';
                                }
                                if (value.length != 6) {
                                  return 'OTP must be 6 digits';
                                }
                                return null;
                              },
                            ),
                            Gap(32.h),

                            // Verify Button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Loader.show(context);
                                    await controller.verifyOtp(
                                      controller.otpController.text.trim(),
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
                                  "Verify OTP",
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

                      Gap(32.h),

                      // Resend Option
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the code? ",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              var authController = Get.find<AuthController>();
                              Loader.show(context);
                              controller.sendOtp("${authController.profile.value.user!.email}");
                              Loader.hide();
                            },
                            child: Text(
                              "Resend",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryOrange,
                              ),
                            ),
                          ),
                        ],
                      )
      
                    ],
                  ),
                ),
              ),
            );
  }


//Desktop UI
  Center _buildTabUI(BuildContext context) {
    return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    children: [
                      // Icon
                      Container(
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          color: AppColor.primaryOrange.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified_user_rounded,
                          size: 64,
                          color: AppColor.primaryOrange,
                        ),
                      ),
                      Gap(32),

                      // Header
                      Text(
                        "Verify OTP",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Gap(12.h),
                      Text(
                        "Enter the 6-digit code sent to your email",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Gap(8.h),

                      // Show Email (Fixed - No unnecessary Obx)
                      Text(
                        controller.emailController.text,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.primaryOrange,
                        ),
                      ),

                      
                      16.verticalSpace,
                      // Form Card
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // OTP Field
                            TextFormField(
                              controller: controller.otpController,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 12,
                              ),
                              decoration: InputDecoration(
                                labelText: "OTP Code",
                                prefixIcon: const Icon(
                                  Icons.security_outlined,
                                ),
                                counterText: "",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'OTP is required';
                                }
                                if (value.length != 6) {
                                  return 'OTP must be 6 digits';
                                }
                                return null;
                              },
                            ),
                            Gap(32.h),

                            // Verify Button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Loader.show(context);
                                    await controller.verifyOtp(
                                      controller.otpController.text.trim(),
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
                                  "Verify OTP",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Gap(32.h),

                      // Resend Option
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the code? ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Gap(4),
                          GestureDetector(
                            onTap: () {
                              // TODO: Call resend OTP method when implemented in controller
                              // controller.resendOtp();
                            },
                            
                            child: Text(
                              "Resend",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryOrange,
                              ),
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

//Desktop UI
  Center _buildDesktopUI(BuildContext context) {
    return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    children: [
                      // Icon
                      Container(
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          color: AppColor.primaryOrange.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified_user_rounded,
                          size: 64,
                          color: AppColor.primaryOrange,
                        ),
                      ),
                      Gap(32),

                      // Header
                      Text(
                        "Verify OTP",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Gap(12.h),
                      Text(
                        "Enter the 6-digit code sent to your email",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Gap(8.h),

                      // Show Email (Fixed - No unnecessary Obx)
                      Text(
                        controller.emailController.text,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.primaryOrange,
                        ),
                      ),

                      
                      16.verticalSpace,
                      // Form Card
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // OTP Field
                            TextFormField(
                              controller: controller.otpController,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 12,
                              ),
                              decoration: InputDecoration(
                                labelText: "OTP Code",
                                prefixIcon: const Icon(
                                  Icons.security_outlined,
                                ),
                                counterText: "",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'OTP is required';
                                }
                                if (value.length != 6) {
                                  return 'OTP must be 6 digits';
                                }
                                return null;
                              },
                            ),
                            Gap(32.h),

                            // Verify Button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Loader.show(context);
                                    await controller.verifyOtp(
                                      controller.otpController.text.trim(),
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
                                  "Verify OTP",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Gap(32.h),

                      // Resend Option
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the code? ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Gap(4),
                          GestureDetector(
                            onTap: () {
                              // TODO: Call resend OTP method when implemented in controller
                              // controller.resendOtp();
                            },
                            
                            child: Text(
                              "Resend",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryOrange,
                              ),
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
