import 'package:cached_network_image/cached_network_image.dart';
import 'package:codeit/controller/course_controller.dart';
import 'package:codeit/controller/video_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CourseView extends GetView<CourseController> {
  const CourseView({super.key});

  @override
  Widget build(BuildContext context) {
    final videoController = Get.find<VideoController>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text("Recorded Videos"),
         backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
       
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return LinearProgressIndicator();
        }

        final courseDetails = controller.course.value.courseDetails;
        final videos = courseDetails?.videos ?? [];

        return RefreshIndicator(
          onRefresh: () async{
            controller.getCourse(int.parse(courseDetails!.course!.id.toString()));
          },
          child: CustomScrollView(
            slivers: [
              // Beautiful Course Banner
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16/9,
                      child: SizedBox(
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: courseDetails?.course?.image ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey.shade200,
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image_not_supported, size: 60),
                          ),
                        ),
                      ),
                    ),
                    // Gradient Overlay
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black54,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Course Title on Banner
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Text(
                        courseDetails?.course?.name ?? "Course Videos",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(color: Colors.black87, blurRadius: 8),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
          
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const Gap(8),
          
                    // Video Count
                    Row(
                      children: [
                        Icon(Icons.video_library_rounded, color: theme.colorScheme.primary),
                        const Gap(8),
                        Text(
                          "${videos.length} Video Lessons",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
          
                    const Gap(24),
          
                    // Section Title
                    Text(
                      "Course Content",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          
                    const Gap(16),
          
                    // Modern Video List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        final video = videos[index];
                        return VideoCard(
                          video: video,
                          onTap: () {
                            videoController.initPlayer(video.videoId!);
                            Get.toNamed(AppRoutes.video, arguments: video);
                          },
                        );
                      },
                    ),
                  ]),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// Modern & Clean Video Card
class VideoCard extends StatelessWidget {
  final dynamic video;
  final VoidCallback onTap;

  const VideoCard({
    super.key,
    required this.video,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: Colors.grey.shade50,
      margin: const EdgeInsets.only(bottom: 12),
      elevation: .5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Thumbnail + Play Button
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 100,
                      height: 62,
                      color: Colors.grey.shade50,
                      child: const Icon(Icons.play_circle_outline, size: 40, color: Colors.grey),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),

              const Gap(16),

              // Video Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title ?? "Video Title",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_rounded,
                            size: 16, color: theme.textTheme.bodySmall?.color),
                        const Gap(6),
                        Text(
                          "Posted: ${video.posted ?? 'N/A'}",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}