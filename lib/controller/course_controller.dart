import 'package:codeit/model/course_model.dart';
import 'package:codeit/model/courses_model.dart';
import 'package:codeit/services/course_service.dart';
import 'package:get/get.dart';

class CourseController extends GetxController{
  var isLoading = false.obs;
  var courses = CoursesModel(success: false, data: []).obs;
  var course = CourseModel(success: false, courseDetails: null).obs;

  Future getCourses() async{
    try{
      isLoading(true);
      var response = await CourseService.fetchCourses();
      //Converteded response to JSON to check success field
      var result = CoursesModel.fromJson(response.data);
      if(result.success == true){
        courses.value = result;
      }
    }finally{
      isLoading(false);
    }
  }


  Future getCourse(int id) async{
    try{
      isLoading(true);
      var response = await CourseService.fetchCourse(id);
      //Converteded response to JSON to check success field
      var data = CourseModel.fromJson(response.data);
      if(data.success == true){
        course.value = data;
      }
    }finally{
      isLoading(false);
    }
  }

}