import 'package:codeit/controller/course_controller.dart';
import 'package:codeit/controller/video_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoView extends StatelessWidget {
  VideoView({super.key});

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
        return  Scaffold(
          appBar: AppBar(title: const Text("Class Video")),
          body: SingleChildScrollView(
            child: Column(
              children: [
                player,
                const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade200
                      )
                     )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("You are Watching",style: TextStyle(fontWeight: FontWeight.bold,color: AppColor.primaryOrange),),
                         Gap(4),
                           Icon(Icons.play_circle_fill,size: 16,color: AppColor.primaryOrange,)
                        ],
                      ),

                      Text("${video.title}",style: TextStyle(fontWeight: FontWeight.normal),),
                    ],
                  )),
              ),
              ListView.builder(
                itemCount: courseController.course.value.courseDetails!.videos.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index){
                  var video = courseController.course.value.courseDetails!.videos[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                     border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade200
                      )
                     )
                    ),
                    child: ListTile(
                      onTap: ()  {
                          controller.initPlayer(video.videoId!);
                          Get.back();
                       Get.toNamed(AppRoutes.video,arguments: video);
                      },
                      leading: Icon(Icons.play_circle_fill),
                      title: Text(video.title!,style: TextStyle(fontWeight: FontWeight.normal),),
                      subtitle: Row(
                        children: [
                          Icon(Icons.calendar_today_rounded,size: 12,),
                          Gap(5),
                          Text("Posted on: ${video.posted}",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),),
                        ],
                      ),
                    ),
                  );
                })
                
               
              ],
            ),
          ),
        );
      },
    );
 
  }
}