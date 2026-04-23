import 'package:codeit/model/certificate_message_model.dart';
import 'package:codeit/model/certificate_model.dart';
import 'package:codeit/services/certificate_service.dart';
import 'package:codeit/utils/helper.dart';
import 'package:get/get.dart';

class CertificateController extends GetxController {
  var isLoading = false.obs;
  var certificates = CertificateModel(sucess: false, data: []).obs;

  Future getCertificated() async {
    try {
      
      isLoading(true);
      var response = await CertificateService.fetchCertificates();
      var result = CertificateModel.fromJson(response.data);
      if (result.sucess == true) {
        certificates.value = result;
        
      }
    } finally {
      isLoading(false);
    }
  }

  Future getCertificate(dynamic id) async {
    try {
      isLoading(true);
      var response = await CertificateService.emailCertificate(id);
      var result = CertificateMessageModel.fromJson(response.data);
      print("Id  is $id");
      if (result.success == true) {
        CustomDialogs.success(title: "Success", message: "Your certificate has been successfully delivered to your registered email address. Kindly check your inbox for details.");
      } else {
        CustomDialogs.warning(title: "Error", message: result.message!);
      }
    } finally {
      isLoading(false);
    }
  }
}
