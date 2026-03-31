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
  var message  = ForgotpasswordModel(success: false, message: null).obs;

  // Send OTP Method
  Future<void> sendOtp(String email) async {
    if (email.isEmpty) return;
    try {
      isLoading(true);
      var response = await AuthService.forgotPassword(email);
      var result = ForgotpasswordModel.fromJson(response.data);
   
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
      var response = await AuthService.resetPassword(
        emailController.text,
        newPasswordController.text,
        confirmPasswordController.text,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
      CustomDialogs.success(title: "Success", message: "Password reset successfully",
      onConfirm: () =>  Get.offAllNamed(AppRoutes.login),
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
