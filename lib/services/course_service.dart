import 'package:codeit/controller/storage_controller.dart';
import 'package:codeit/utils/dio_connection.dart';
import 'package:dio/dio.dart';

class CourseService {
  
  static Future<Response> fetchCourses() async{
    var token = StorageController().getToken();
    DioConnection.dio.options.headers['Authorization'] = "Bearer $token";
    var response = await DioConnection.dio.get("courses");
    return response;
  } 


    // Get Single Courase
    static Future<Response> fetchCourse(int id) async{
    var token = StorageController().getToken();
    DioConnection.dio.options.headers['Authorization'] = "Bearer $token";
    var response = await DioConnection.dio.get("course/$id");
    return response;
  } 
}