import 'package:codeit/model/terms_condition_model.dart';
import 'package:codeit/services/terms_condition_service.dart';
import 'package:get/get.dart';

class TermsConditionController extends GetxController {
  var isLoading = false.obs;
  var terms = TermsConditionModel(sucess: false, data: null).obs;

  Future getTermsCondition() async {
    try{
      isLoading(true);
      var response = await TermsConditionService.fetchTermsCondition();
      var result = TermsConditionModel.fromJson(response.data);
      if(result.sucess == true){
        terms.value = result;
      }
    }finally{
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getTermsCondition();
  }
}