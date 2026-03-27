import 'dart:io';

import 'package:codeit/services/order_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OrderController extends GetxController {
  final ImagePicker picker = ImagePicker();
  var isLoading = false.obs;
  var terms = false.obs;
  // Reactive variable
  Rx<File?> image = Rx<File?>(null);

//Image Picker
  Future pickImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  void setTermsAndCondition(){
    terms.value = !terms.value;
  }

  Future placeOrder(File file, var enrollmentId) async {
    try {
      isLoading(true);
      var response = await OrderService.placeOrder(file,enrollmentId);
      
      if (response.statusCode == 200) {
        Get.snackbar("Message", "Your application has been submited");
      }
    } finally {
      isLoading(false);
    }
  }
}
