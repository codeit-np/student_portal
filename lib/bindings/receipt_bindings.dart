import 'package:codeit/controller/receipt_controller.dart';
import 'package:get/get.dart';

class ReceiptBindings extends Bindings{
  @override
  void dependencies() {
   Get.put<ReceiptController>(ReceiptController(),permanent: true);
  }
}