import 'package:codeit/controller/certificate_controller.dart';
import 'package:get/get.dart';

class CertificateBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<CertificateController>(CertificateController(),permanent: false);
  }

}