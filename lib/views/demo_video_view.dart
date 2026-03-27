import 'package:codeit/controller/course_controller.dart';
import 'package:codeit/controller/video_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DemoVideoView extends StatelessWidget {
  DemoVideoView({super.key});

  final controller = Get.find<VideoController>();
  final courseController = Get.find<CourseController>();
  var video = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller.playerController,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(title: const Text("Demo Video")),
          body: SingleChildScrollView(
            child: Column(
              children: [
                player,
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Currently Watching",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryOrange,
                          ),
                        ),

                        Text("Demo video of $video"),
                      ],
                    ),
                  ),
                ),

                // ListView.builder(
                //   itemCount: courseController.course.value.courseDetails!.videos.length,
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemBuilder: (BuildContext context, int index){
                //     var video = courseController.course.value.courseDetails!.videos[index];
                //     return Container(
                //       margin: EdgeInsets.symmetric(vertical: 10),
                //       decoration: BoxDecoration(
                //        border: Border(
                //         bottom: BorderSide(
                //           color: Colors.grey.shade200
                //         )
                //        )
                //       ),
                //       child: ListTile(
                //         onTap: ()  {
                //             controller.initPlayer(video.videoId!);
                //             Get.back();
                //          Get.toNamed(AppRoutes.video,arguments: video);
                //         },
                //         leading: Icon(Icons.play_circle_fill),
                //         title: Text(video.title!,style: TextStyle(fontWeight: FontWeight.w400),),
                //         subtitle: Row(
                //           children: [
                //             Icon(Icons.calendar_today_rounded,size: 14,),
                //             Gap(5),
                //             Text("Posted on: ${video.posted}",style: TextStyle(fontWeight: FontWeight.w300),),
                //           ],
                //         ),
                //       ),
                //     );
                //   })
              ],
            ),
          ),
        );
      },
    );
  }
}
