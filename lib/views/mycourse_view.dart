import 'package:cached_network_image/cached_network_image.dart';
import 'package:codeit/controller/course_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class MycourseView extends GetView<CourseController> {
  const MycourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Text("My Courses"),
      ),
      body: Obx(() {
        if (controller.isLoading.value == true) {
          return LinearProgressIndicator();
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb Navigation
                  const SizedBox(height: 20),

                  // Course Lists
                  ListView.builder(
                    itemCount: controller.courses.value.data.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),

                    itemBuilder: (BuildContext context, int index) {
                      var course = controller.courses.value.data[index];
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              controller.getCourse(course.enrollmentId!);
                              Get.toNamed(AppRoutes.course);
                            },
                            title: Text(course.courseName!,style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Mentor: ${course.mentorName}",style: TextStyle(fontSize: 12),),
                                Row(
                                  children: [
                                    Text("Status:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                                    course.status == "pending" ? Row(
                                      children: [
                                        Icon(Icons.pending_rounded,size: 12,color: AppColor.primaryOrange,),
                                        Text("Pending",style: TextStyle(fontSize: 12),),
                                      ],
                                    ) : Icon(Icons.check_circle,color: Colors.green,size: 12,),
                                    course.status == "pending" ? SizedBox() : Text("Approved",style: TextStyle(fontSize: 12),)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.play_circle_fill,
                                      size: 14,
                                      color: AppColor.primaryOrange,
                                    ),
                                    Gap(4),
                                    Text(
                                      "${course.lessons} Videos",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            leading: SizedBox(
                              width: 80,
                              height: 80,
                              child: CachedNetworkImage(
                                imageUrl: "${course.courseImage}",
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Center(
                                          child: CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                          ),
                                        ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                          Divider(),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
