import 'package:codeit/controller/auth_controller.dart';
import 'package:codeit/controller/storage_controller.dart';
import 'package:codeit/model/forgot_password_model.dart';
import 'package:codeit/services/auth_service.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:codeit/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;
  var message  = ForgotPasswordModel(success: false).obs;
  // Send OTP Method
  Future<void> sendOtp(String email) async {
    if (email.isEmpty) return;
    try {
      isLoading(true);
      var response = await AuthService.forgotPassword(email.trim());
      var result = ForgotPasswordModel.fromJson(response.data);
      if (result.success == true) {
        CustomDialogs.success(title: "Success", message: "OTP sent to your email",
        onConfirm: () => Get.toNamed(AppRoutes.otpVerification),
        );
        
      } else {
        CustomDialogs.warning(title: "Error", message: "We can't find a user with that email address.");
        
      }
    } finally{
        isLoading(false);
    }
  }

  //Verify OTP Method
  Future<void> verifyOtp(String otp) async {
    if (otp.length != 6) return;
    try {
      var response = await AuthService.verifyOtp(emailController.text, otp);
      if (response.statusCode == 200 || response.statusCode == 201) {
       CustomDialogs.success(title: "Success", message: "OTP verified successfully",
       onConfirm: ()=>Get.toNamed(AppRoutes.resetPassword)
       );
        
        
      } else {
        CustomDialogs.warning(title: "Error", message: "Invalid OTP");
      }
    } catch (e) {
       CustomDialogs.warning(title: "Error", message: "Invalid OTP");
    }
  }

  //Rest TextFormField After Success
  void reset(){
    emailController.text = "";
    otpController.text = "";
    newPasswordController.text = "";
    confirmPasswordController.text = "";
  }

  //Reset Password Method
  Future<void> resetPassword() async {
    if (newPasswordController.text != confirmPasswordController.text) {
      CustomDialogs.warning(title: "Error", message: "Passwords do not match");
      return;
    }
    try {
      var token = StorageController().getToken();
      var authController = Get.find<AuthController>();
      var response = await AuthService.resetPassword(
        token == null ? emailController.text.trim() : authController.profile.value.user!.email!.trim(),
        newPasswordController.text.trim(),
        confirmPasswordController.text.trim(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
      CustomDialogs.success(title: "Success", message: "Password reset successfully",
      onConfirm: () {
        reset();
        Get.offAllNamed(AppRoutes.login);
      },
      );
       
       
      } else {
        CustomDialogs.warning(title: "Error", message: "Failed to reset password");
      }
    } catch (e) {
      CustomDialogs.warning(title: "Error", message: "Failed to reset password");
      
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
