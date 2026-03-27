import 'dart:io';

import 'package:codeit/controller/storage_controller.dart';
import 'package:codeit/utils/dio_connection.dart';
import 'package:dio/dio.dart';

class OrderService {

  //Order Service
  static Future<Response> placeOrder(File file, var enrollmentId) async {
    var token = StorageController().getToken();

    // final cartController = Get.find<CartController>();

    FormData formData = FormData.fromMap({
      "payment": await MultipartFile.fromFile(
        file.path,
        filename: file.path.split("/").last,
      ),
      "terms": true,
    });


    DioConnection.dio.options.headers['Authorization'] = "Bearer $token";

    var response = await DioConnection.dio.post("online-admission/$enrollmentId", data: formData);

    return response;
  }
}
