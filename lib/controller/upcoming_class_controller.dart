import 'package:codeit/model/upcoming_class_model.dart';
import 'package:codeit/services/upcoming_class_service.dart';
import 'package:get/get.dart';

class UpcomingClassController extends GetxController{
  var isLoading = false.obs;
  var upcomingClasses = UpcomingClassesModel(sucess: false, data: []).obs;

  Future getUpcomingClasses() async{
    try{
      isLoading(true);
      var response = await UpcomingClassService.fetchUpcomingClasses();
      var result = UpcomingClassesModel.fromJson(response.data);
      if(result.sucess == true){
        upcomingClasses.value = result;
      }
    }finally{
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUpcomingClasses();
  }
}