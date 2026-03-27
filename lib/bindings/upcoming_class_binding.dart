import 'package:codeit/controller/upcoming_class_controller.dart';
import 'package:get/get.dart';

class UpcomingClassBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<UpcomingClassController>(UpcomingClassController(),permanent: false);
  }
}