import 'package:codeit/views/no_internet_view.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController extends GetxController {
  static ConnectivityController get to => Get.find();

  var isConnected = true.obs;
  bool _offlinePageOpen = false;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();
    _listenToConnectivityChanges();
  }

  void _checkInitialConnection() async {
    var result = await Connectivity().checkConnectivity();
    isConnected.value = result != ConnectivityResult.none;
    _handleOfflinePage();
  }

  void _listenToConnectivityChanges() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      isConnected.value = results.any((r) => r != ConnectivityResult.none);
      _handleOfflinePage();
    });
  }

  void _handleOfflinePage() {
    if (!isConnected.value && !_offlinePageOpen) {
      _offlinePageOpen = true;
      // Navigate to No Internet page
      Get.to(() => const NoInternetPage(), fullscreenDialog: true)?.then((_) {
        _offlinePageOpen = false;
      });
    } else if (isConnected.value && _offlinePageOpen) {
      // Automatically close No Internet page if open
      if (Get.isOverlaysOpen) Get.back();
      _offlinePageOpen = false;
    }
  }
}