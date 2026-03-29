import 'package:codeit/model/googlemeet_model.dart';
import 'package:codeit/services/googlemeet_service.dart';
import 'package:get/get.dart';

class GoogleMeetController extends GetxController {
  var isLoading = false.obs;
  var liveClasses = <Datum>[].obs;

  Future getLiveClasses() async {
    try {
      isLoading(true);
      var response = await GoogleMeetService.fetchLiveClasses();
      var result = GooglemeetModel.fromJson(response.data);
      if (result.success == true) {
        liveClasses.value = result.data;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch live classes');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getLiveClasses();
  }
}
