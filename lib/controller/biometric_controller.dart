import 'package:codeit/controller/auth_controller.dart';
import 'package:codeit/controller/certificate_controller.dart';
import 'package:codeit/controller/course_controller.dart';
import 'package:codeit/controller/storage_controller.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:codeit/utils/helper.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class BiometricController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  var hasFace = false.obs;
  var hasFingerprint = false.obs;
  var supported = false.obs;

  var authenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkBiometric();
  }

  Future<void> checkBiometric() async {
    try {
      bool canCheck = await auth.canCheckBiometrics;

      bool deviceSupported = await auth.isDeviceSupported();

      supported.value = canCheck && deviceSupported;

      if (!supported.value) {
        return;
      }

      List<BiometricType> available = await auth.getAvailableBiometrics();

      hasFace.value = available.contains(BiometricType.face);

      hasFingerprint.value =
          available.contains(BiometricType.fingerprint) ||
          available.contains(BiometricType.strong);
    } catch (e) {
      print(e);
    }
  }

  Future<void> biometricLogin() async {
    try {
      final bool result = await auth.authenticate(
        localizedReason: 'Scan your fingerprint or face',
        biometricOnly: true,
        sensitiveTransaction: true,
        persistAcrossBackgrounding: true,
      );

      authenticated.value = result;
       
      if (authenticated.value == true) {
        // Get.snackbar("Success", "Biometric login successful");

        var authController = Get.find<AuthController>();
        var storageController = Get.find<StorageController>();
        var courseController = Get.find<CourseController>();
        var certificateController = Get.find<CertificateController>();
        var token = storageController.getToken();

        if (token != null) {
          await authController.getProfle();
          await courseController.getCourses();
          await certificateController.getCertificated();
          Get.offAllNamed(AppRoutes.dashboard);
        }else{
           CustomDialogs.quickError(message: "Please login with your credentials");
        }
      } else {
        CustomDialogs.quickError(message: "Please login with your credentials");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      CustomDialogs.quickError(message: "Please login with your credentials");
    }
  }
}
