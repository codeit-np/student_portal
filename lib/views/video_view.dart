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
  final video = Get.arguments; // Current playing video

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller.playerController,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: AppColor.backgroundColor,
          appBar: AppBar(
            title: Text("Class Videos"),
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: Column(
            children: [
              // YouTube Player (Fixed at top)
              AspectRatio(
                aspectRatio: 3/2,
                child: player),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Currently Watching Section
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Now Playing",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primaryOrange,
                                    fontSize: 15,
                                  ),
                                ),
                                const Gap(8),
                                Icon(
                                  Icons.play_circle_fill,
                                  size: 18,
                                  color: AppColor.primaryOrange,
                                ),
                              ],
                            ),
                            const Gap(8),
                            Text(
                              video.title ?? "Untitled Video",
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Gap(28),

                      // Other Videos Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Up Next",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${courseController.course.value.courseDetails?.videos.length ?? 0} Videos",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),

                      const Gap(16),

                      // Modern Video List
                      ListView.builder(
                        itemCount:
                            courseController
                                .course
                                .value
                                .courseDetails
                                ?.videos
                                .length ??
                            0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final otherVideo = courseController
                              .course
                              .value
                              .courseDetails!
                              .videos[index];
                          final isCurrentVideo =
                              otherVideo.videoId == video.videoId;

                          return VideoListItem(
                            video: otherVideo,
                            isPlaying: isCurrentVideo,
                            onTap: () {
                              if (!isCurrentVideo) {
                                controller.initPlayer(otherVideo.videoId!);
                                Get.back();
                                Get.toNamed(
                                  AppRoutes.video,
                                  arguments: otherVideo,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Modern Video List Item
class VideoListItem extends StatelessWidget {
  final dynamic video;
  final bool isPlaying;
  final VoidCallback onTap;

  const VideoListItem({
    super.key,
    required this.video,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isPlaying ? 1 : 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isPlaying ? Colors.white : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Play Icon / Indicator
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isPlaying
                          ? AppColor.primaryOrange.withOpacity(0.15)
                          : Colors.grey.shade50,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Icon(
                    isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                    size: 42,
                    color: isPlaying
                        ? AppColor.primaryOrange
                        : Colors.grey.shade700,
                  ),
                ],
              ),

              const Gap(16),

              // Video Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title ?? "Untitled Video",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: isPlaying
                            ? FontWeight.bold
                            : FontWeight.w600,
                        color: isPlaying ? AppColor.primaryOrange : null,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const Gap(6),
                        Text(
                          "Posted: ${video.posted ?? 'N/A'}",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Current Playing Indicator
              if (isPlaying)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.primaryOrange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Playing",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
