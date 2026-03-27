import 'package:codeit/controller/storage_controller.dart';
import 'package:codeit/utils/dio_connection.dart';
import 'package:dio/dio.dart';

class AuthService {
  static Future<Response> loign(String email,String password) async{
    var response = await DioConnection.dio.post("login",queryParameters:{"email" : email,"password": password} );
    return response;
  }

   static Future<Response> register(String name, String email,String whatsApp,String password,String countryCode) async{
    
    var response = await DioConnection.dio.post("register",queryParameters:{"name":name,  "email" : email, "whatsapp": whatsApp, "password": password,"country_code" : countryCode} );
    return response;
  }



  static Future<Response> fetchProfile() async{
    var token = StorageController().getToken();
    DioConnection.dio.options.headers['Authorization'] = "Bearer $token";

    var response = await DioConnection.dio.get("profile");
    return response;
  }
}