import 'package:codeit/controller/storage_controller.dart';
import 'package:codeit/utils/dio_connection.dart';
import 'package:dio/dio.dart';

class GoogleMeetService {
  static Future<Response> fetchLiveClasses() async {
    var token = StorageController().getToken();
    DioConnection.dio.options.headers['Authorization'] = "Bearer $token";

    var response = await DioConnection.dio.get("google-meet");
    return response;
  }
}
