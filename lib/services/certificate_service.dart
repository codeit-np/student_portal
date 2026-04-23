import 'package:codeit/controller/storage_controller.dart';
import 'package:codeit/utils/dio_connection.dart';
import 'package:dio/dio.dart';

class CertificateService {
  static Future<Response> fetchCertificates() async{
    var token = StorageController().getToken();
    DioConnection.dio.options.headers['Authorization'] = "Bearer $token";
    
    var response = await DioConnection.dio.get("certificates");
    return response;
  }

  static Future<Response> emailCertificate(var id) async{
     var token = StorageController().getToken();
    DioConnection.dio.options.headers['Authorization'] = "Bearer $token";
    var response = await DioConnection.dio.get("sendcertificate/$id");
    return response;
  }
}