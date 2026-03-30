import 'package:codeit/model/receipt_model.dart';
import 'package:codeit/services/receipt_service.dart';
import 'package:get/get.dart';

class ReceiptController extends GetxController{
  var isLoading = false.obs;
  var receipts = ReceiptModel(success: false, data: []).obs;

  Future getReceipts() async {
    try{
      isLoading(true);
      var response = await ReceiptService.fetchReceipts();
      var result = ReceiptModel.fromJson(response.data);
      if(result.success == true){
        receipts.value = result;
      }
    }finally{
      isLoading(false);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getReceipts();
  }
}