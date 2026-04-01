import 'package:codeit/controller/forgot_password_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ForgotPasswordController controller =
      Get.find<ForgotPasswordController>();

  bool obscureNew = true;
  bool obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Reset Password"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
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

  // Mobile UI
  Center _buildMobileUI(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_clock, size: 80),
              // Title & Subtitle
              Text(
                "Create New Password",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              12.verticalSpace,
              Text(
                "Your new password must be different from the previous one.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              30.verticalSpace,

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // New Password Field
                    _buildPasswordField(
                      controller: controller.newPasswordController,
                      label: "New Password",
                      hint: "Enter new password",
                      obscure: obscureNew,
                      onToggle: () => setState(() => obscureNew = !obscureNew),
                      icon: Icons.lock,
                    ),

                    20.verticalSpace,

                    // Confirm Password Field
                    _buildPasswordField(
                      controller: controller.confirmPasswordController,
                      label: "Confirm Password",
                      hint: "Confirm your new password",
                      obscure: obscureConfirm,
                      onToggle: () =>
                          setState(() => obscureConfirm = !obscureConfirm),
                      icon: Icons.lock_outline,
                    ),

                    20.verticalSpace,

                    // Reset Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Loader.show(context);
                            await controller.resetPassword();
                            controller.reset();
                            Loader.hide();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryOrange,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  // Tab UI
  Center _buildTabUI(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_clock, size: 80),
              // Title & Subtitle
              Text(
                "Create New Password",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              12.verticalSpace,
              Text(
                "Your new password must be different from the previous one.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              30.verticalSpace,

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // New Password Field
                    _buildPasswordField(
                      controller: controller.newPasswordController,
                      label: "New Password",
                      hint: "Enter new password",
                      obscure: obscureNew,
                      onToggle: () => setState(() => obscureNew = !obscureNew),
                      icon: Icons.lock,
                    ),

                    20.verticalSpace,

                    // Confirm Password Field
                    _buildPasswordField(
                      controller: controller.confirmPasswordController,
                      label: "Confirm Password",
                      hint: "Confirm your new password",
                      obscure: obscureConfirm,
                      onToggle: () =>
                          setState(() => obscureConfirm = !obscureConfirm),
                      icon: Icons.lock_outline,
                    ),

                    20.verticalSpace,

                    // Reset Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Loader.show(context);
                            await controller.resetPassword();
                            controller.reset();
                            Loader.hide();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryOrange,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  // Desktop UI
  Center _buildDesktopUI(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_clock, size: 80),
              // Title & Subtitle
              Text(
                "Create New Password",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              12.verticalSpace,
              Text(
                "Your new password must be different from the previous one.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              30.verticalSpace,

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // New Password Field
                    _buildPasswordField(
                      controller: controller.newPasswordController,
                      label: "New Password",
                      hint: "Enter new password",
                      obscure: obscureNew,
                      onToggle: () => setState(() => obscureNew = !obscureNew),
                      icon: Icons.lock,
                    ),

                    20.verticalSpace,

                    // Confirm Password Field
                    _buildPasswordField(
                      controller: controller.confirmPasswordController,
                      label: "Confirm Password",
                      hint: "Confirm your new password",
                      obscure: obscureConfirm,
                      onToggle: () =>
                          setState(() => obscureConfirm = !obscureConfirm),
                      icon: Icons.lock_outline,
                    ),

                    20.verticalSpace,

                    // Reset Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Loader.show(context);
                            await controller.resetPassword();
                            controller.reset();
                            Loader.hide();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryOrange,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Password Field Widget
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColor.primaryOrange),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey[600],
          ),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColor.primaryOrange, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        if (label == "New Password" && value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        if (label == "Confirm Password" &&
            value != this.controller.newPasswordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }
}
