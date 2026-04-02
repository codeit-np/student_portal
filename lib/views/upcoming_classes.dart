import 'package:cached_network_image/cached_network_image.dart';
import 'package:codeit/controller/order_controller.dart';
import 'package:codeit/controller/upcoming_class_controller.dart';
import 'package:codeit/controller/video_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpcomingClasses extends GetView<UpcomingClassController> {
  const UpcomingClasses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text("Upcoming Classes"),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),

      body: Obx(() {
        if (controller.isLoading.value == true) {
          return LinearProgressIndicator();
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                            height: 1.2,
                          ),
                          children: [
                            TextSpan(
                              text: 'Upcoming Classes in Google Meet ',
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.videocam,
                                color: AppColor.primaryOrange,
                                size: 32,
                              ), // Mocking Google Meet icon
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Miss a live class? No problem—recorded videos will be available for every session.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
          
                // Classes List Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    padding: EdgeInsets.all(4),
                    itemCount:
                        controller.upcomingClasses.value.data.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var course =
                          controller.upcomingClasses.value.data[index];
                      return Column(
                        children: [
                          _buildClassCard(
                            course: course,
                            title: '${course.courseName}',
                            startsIn: '${course.startsIn}',
                            startDate: '${course.startDate}',
                            duration: '${course.courseDuration}',
                            classTime: '${course.classTime}',
                            seatsLeft: '${course.availableSeats}',
                            price: 'Rs.${course.offerPrice}',
                            originalPrice: 'Rs.${course.actualPrice}',
                            discount: '${course.discount} off',
                            bannerWidget: _buildMernBanner(
                              "${course.courseImage}",
                            ),
                            videoID: course.demoVideoId!,
                          ),
                      
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildClassCard({
    required dynamic course,
    required String title,
    required String startsIn,
    required String startDate,
    required String duration,
    required String classTime,
    required String seatsLeft,
    required String price,
    required String originalPrice,
    required String discount,
    required Widget bannerWidget,
    required String videoID,
  }) {
    var orderController = Get.find<OrderController>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner Area
          SizedBox(
            child: Stack(
              children: [
                // Banner Background/Content
                bannerWidget,

                // Starts In Badge
                Positioned(
                  top: 16,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColor.primaryOrange,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.rocket_launch,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          startsIn,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Details Area
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),

                // Info Rows
                _buildInfoRow(
                  Icons.calendar_today_outlined,
                  'Starts: $startDate',
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.laptop_mac,
                      size: 18,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 8),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(text: 'Mode: '),
                          TextSpan(
                            text: 'Online ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          TextSpan(text: '(Google Meet) '),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.videocam,
                              color: Colors.green,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.hourglass_empty, 'Duration:  $duration'),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.access_time, 'Class Time: $classTime'),
                const SizedBox(height: 12),

                // Seats Left
                Row(
                  children: [
                    const Icon(
                      Icons.people_alt,
                      size: 18,
                      color: AppColor.primaryOrange,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      seatsLeft,
                      style: const TextStyle(
                        color: AppColor.primaryOrange,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 20),

                // Price and Action Area
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              originalPrice,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF94A3B8),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCFCE7),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                discount,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF16A34A),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        orderController.image.value = null;
                        Get.toNamed(AppRoutes.checkout, arguments: course);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryOrange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'Enroll Now',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom Action
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: TextButton.icon(
              onPressed: () {
                var videoController = Get.find<VideoController>();
                videoController.initPlayer(videoID);
                Get.toNamed(AppRoutes.demoVideo, arguments: title);
              },
              icon: const Icon(
                Icons.play_circle_fill,
                color: AppColor.primaryOrange,
              ),
              label: const Text(
                'Watch Demo Video',
                style: TextStyle(
                  color: AppColor.primaryOrange,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF64748B)),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 14, color: Color(0xFF475569)),
        ),
      ],
    );
  }

  // Mocking the MERN Stack banner content since we don't have images
  Widget _buildMernBanner(String image) {
    return AspectRatio(
      aspectRatio: 16/9,
      child: SizedBox(
        width: double.infinity,
        child: CachedNetworkImage(
          imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildMockTechIcon(String letter, Color color, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 4),
        Text(
          letter,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
