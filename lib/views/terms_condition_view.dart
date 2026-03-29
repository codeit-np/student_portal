import 'package:codeit/controller/terms_condition_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TermsConditionView extends GetView<TermsConditionController> {
  const TermsConditionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text("Terms & Condition"),
         backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
       
      ),
      body: SafeArea(child: Obx((){
        if(controller.isLoading.value == true){
          return LinearProgressIndicator();
        }else{
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Html(data: controller.terms.value.data)
                ],
              ),
            ),
          );
        }
      })),
    );
  }
}