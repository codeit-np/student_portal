import 'package:codeit/controller/auth_controller.dart';
import 'package:codeit/controller/certificate_controller.dart';
import 'package:codeit/controller/course_controller.dart';

import 'package:codeit/controller/storage_controller.dart';
import 'package:codeit/controller/video_controller.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<StorageController>(StorageController(),permanent: true);
    Get.put<AuthController>(AuthController());
    Get.put<CourseController>(CourseController(),permanent: true);
    Get.put<VideoController>(VideoController(),permanent: true);
    Get.put<CertificateController>(CertificateController(),permanent: true);
  }
}