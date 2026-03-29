import 'package:codeit/model/certificate_message_model.dart';
import 'package:codeit/model/certificate_model.dart';
import 'package:codeit/services/certificate_service.dart';
import 'package:get/get.dart';

class CertificateController extends GetxController{
  var isLoading = false.obs;
  var certificates = CertificateModel(sucess: false, data: []).obs;

  Future getCertificated() async{
    try{
      isLoading(true);
      var response = await CertificateService.fetchCertificates();
      var result = CertificateModel.fromJson(response.data);
      if(result.sucess == true){
        certificates.value = result;
      }
    }finally{
      isLoading(false);
    }
  }

  Future getCertificate(var id) async{
    try{
      isLoading(true);
      var response = await CertificateService.emailCertificate(id);
      var result = CertificateMessageModel.fromJson(response.data);
      if(result.success == true){
        Get.snackbar("Message", result.message!);
      }else{
        Get.snackbar("Message", result.message!);
      }
    }finally{
      isLoading(false);
    }
  }

  
}