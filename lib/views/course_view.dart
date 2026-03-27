import 'package:cached_network_image/cached_network_image.dart';
import 'package:codeit/controller/course_controller.dart';
import 'package:codeit/controller/video_controller.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CourseView extends GetView<CourseController> {
  const CourseView({super.key});

  @override
  Widget build(BuildContext context) {
    var videoController = Get.find<VideoController>();
    return Scaffold(
      appBar: AppBar(title: Text("Class Videos")),
      body: Obx(() {
        if (controller.isLoading.value == true) {
          return LinearProgressIndicator();
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                //Image
                SizedBox(
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl:
                        controller.course.value.courseDetails!.course!.image!,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),

                //Video List
                ListView.builder(
                  itemCount:
                      controller.course.value.courseDetails!.videos.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var video =
                        controller.course.value.courseDetails!.videos[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          videoController.initPlayer(video.videoId!);
                          Get.toNamed(AppRoutes.video, arguments: video);
                        },
                        leading: Icon(Icons.play_circle_fill),
                        title: Text(
                          video.title!,
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        subtitle: Row(
                          children: [
                            Icon(Icons.calendar_today_rounded, size: 14),
                            Gap(5),
                            Text(
                              "Date: ${video.posted}",
                              style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
