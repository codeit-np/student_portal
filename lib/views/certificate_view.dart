import 'package:codeit/controller/certificate_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CertificateView extends GetView<CertificateController> {
  const CertificateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("My Certificates"),
      ),
      body: Obx((){
        if(controller.isLoading.value == true){
          return LinearProgressIndicator();
        }else{
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  itemCount: controller.certificates.value.data.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                   itemBuilder: (BuildContext context, int index){
                    var certificate = controller.certificates.value.data[index];
                    return ListTile(
                      leading: Icon(Icons.yard_outlined,size: 40,),
                      trailing: IconButton(onPressed: (){
                        Get.defaultDialog(
                          title: "Confirmation",
                          content: Text("Do you want us to send your certificate to your registered email?"),
                          actions: [
                            OutlinedButton(onPressed: (){
                              Get.back();
                            }, child: Text("Cancel")),

                            FilledButton(onPressed: () async{
                              Get.back();
                              Loader.show(context);
                               await controller.getCertificate(certificate.certicateId);
                               Loader.hide();
                            }, child: Text("Yes"))
                          ]
                        );
                      }, icon: Icon(Icons.mail)),
                      title: Text("${certificate.courseName}",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Issue To: "),
                              Text("${certificate.issuedTo}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Issue Date: "),
                              Text("${certificate.courseCompletionDate}"),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
             
              ],
            )
          );
        }
      }),
    );
  }
}
