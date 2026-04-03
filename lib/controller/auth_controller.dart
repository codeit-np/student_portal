import 'package:codeit/controller/certificate_controller.dart';
import 'package:codeit/controller/course_controller.dart';
import 'package:codeit/controller/storage_controller.dart';
import 'package:codeit/model/login_model.dart';
import 'package:codeit/model/profile_model.dart';
import 'package:codeit/services/auth_service.dart';
import 'package:codeit/utils/helper.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var name = TextEditingController();
  var email = TextEditingController();
  var whatsApp = TextEditingController();
  var password = TextEditingController();
  var countryCode = "+977".obs;
  var isRemember = false.obs;
  var isLoading = false.obs;
  var loginMessage = LoginModel(success: false, token: "", message: "").obs;
  var errorMessage = "".obs;
  var profile = ProfileModel(success: false, user: null).obs;
  var obsecure = true.obs;

  // Check Auth on Splash Screen Loading
  void checkAuth() {
    var token = StorageController().getToken();
    if (token != null) {
      Future.delayed(Duration(seconds: 2), () async {
        var courseController = Get.find<CourseController>();
        var certificateController = Get.find<CertificateController>();
        await getProfle();
        await certificateController.getCertificated();
        await courseController.getCourses();
        reset();
        Get.offAllNamed(AppRoutes.dashboard);
      });
    } else {
      Future.delayed(Duration(seconds: 2), () {
        Get.offAllNamed(AppRoutes.login);
      });
    }
  }

void remember(bool value){
  isRemember.value = value;
}
  void setCountryCode(String code) {
    countryCode.value = code;
  }

  void reset(){
    name.text = "";
    email.text = "";
    whatsApp.text = "";
    password.text = "";
    countryCode.value = "+977";
  }

  void visibility(){
    obsecure.value = !obsecure.value;
  }
  
  //Login Method
  Future login() async {
    try {
      isLoading(true);
      var response = await AuthService.loign(email.text.trim(), password.text.trim());
      loginMessage.value = LoginModel.fromJson(response.data);

      if (loginMessage.value.success == true) {
        //Store Token in local storage
        StorageController().saveLogin(loginMessage.value.token!);
        await getProfle();
        var courseController = Get.find<CourseController>();
        var certificateController = Get.find<CertificateController>();
        await courseController.getCourses();
        await certificateController.getCertificated();
        reset();
        Get.offNamed(AppRoutes.dashboard);
      }else{
        CustomDialogs.warning(title: "Error", message: "Invalid email or password. Please try again");
      }
    } finally {
      isLoading(false);
    }
  }

//Delete Account
Future deleteAccount() async{
  try{
    isLoading(true);
    var response = await AuthService.deleteAccount();
    var result = LoginModel.fromJson(response.data);

    if(result.success == true){
      var storageController = Get.find<StorageController>();
      storageController.deleteToken();
      Get.offAllNamed(AppRoutes.login);
    }
  }finally{
    isLoading(false);
  }
}
  

  //Register
  Future register() async {
    try {
      var response = await AuthService.register(
        name.text,
        email.text,
        whatsApp.text,
        password.text,
        countryCode.value,
      );

      loginMessage.value = LoginModel.fromJson(response.data);
      if (loginMessage.value.success == true) {
        //Store Token in local storage
        StorageController().saveLogin(loginMessage.value.token!);
        await getProfle();

        var courseController = Get.find<CourseController>();
        var certificateController = Get.find<CertificateController>();
        await courseController.getCourses();
        await certificateController.getCertificated();

        Get.offNamed(AppRoutes.dashboard);
      } else {
        errorMessage.value = loginMessage.value.message!;
        CustomDialogs.warning(title: "Error", message: errorMessage.value);
      }
    } finally {
      isLoading(false);
    }
  }

  //Get Student Profile
  Future getProfle() async {
    try {
      isLoading(true);
      var response = await AuthService.fetchProfile();
      var result = ProfileModel.fromJson(response.data);
      if (result.success == true) {
        profile.value = result;
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkAuth();
  }
}
