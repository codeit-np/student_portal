import 'package:codeit/controller/order_controller.dart';
import 'package:get/get.dart';

class OrderBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<OrderController>(OrderController(),permanent: true);
  }
}