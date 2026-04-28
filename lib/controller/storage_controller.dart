import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController  extends GetxController{
  final box = GetStorage();
  final box1 = GetStorage();

  Future saveLogin(String token,String email,String password) async{
    await box.write("token", token);
    await box.write('email', email);
    await box.write('password', password);
  }

  Future saveBiometric() async{
    await box1.write("biometric", true);
  }

   bool? getBiometric(){
    return box1.read("biometric");
  }


  String? getToken(){
    return box.read("token");
  }

   String? getEmail(){
    return box.read("email");
  }

   String? getPassword(){
    return box.read("password");
  }



  void deleteToken(){
    box.erase();
  }

   void deleteBiometric(){
    box1.erase();
  }
}