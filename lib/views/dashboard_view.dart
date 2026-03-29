import 'package:cached_network_image/cached_network_image.dart';
import 'package:codeit/controller/auth_controller.dart';
import 'package:codeit/controller/certificate_controller.dart';
import 'package:codeit/controller/course_controller.dart';
import 'package:codeit/controller/storage_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:codeit/utils/app_strings.dart';
import 'package:codeit/views/mycourse_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    var courseController = Get.find<CourseController>();
    var authController = Get.find<AuthController>();
    var certificateController = Get.find<CertificateController>();
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: AppColor.textColor),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),

        title: _buildLogo(),
        actions: [
          Text("Beta Version",style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
          Gap(16)
        ],
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16.0),
        //     child:  Row(
        //       children: [
        //         const Icon(Icons.person, color: AppColor.textColor),
        //         const SizedBox(width: 8),
        //         Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Obx((){
        //               return  
        //               authController.isLoading.value == true ? Text("Loading...") : Text(
        //               '${authController.profile.value.user!.name}',
        //               style: TextStyle(
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.bold,
        //                 color: AppColor.textColor,
        //               ),
        //             );
        //             }),
        //             Text(
        //               'Edit Profile',
        //               style: TextStyle(
        //                 fontSize: 12,
        //                 color: AppColor.subtitleColor,
        //               ),
        //             ),
                 
        //           ],
        //         ),
              
        //       ],
        //     )
          
           
        //   ),
        // ],
       
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColor.borderColor, height: 1.0),
        ),
      ),
      drawer: Drawer(
        backgroundColor: AppColor.primaryOrange,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    const Icon(Icons.code, color: Colors.white, size: 28),
                    const SizedBox(width: 8),
                    const Text(
                      'CODE IT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  dense: true,
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.dashboard,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: const Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              const SizedBox(height: 8),
              _buildDrawerItem(
                icon: Icons.menu_book,
                title: 'My Courses',
                onTap: () {
                  Get.back();
                  courseController.getCourses();
                  Get.toNamed(AppRoutes.mycourse);
                },
              ),
              _buildDrawerItem(
                onTap: (){
                  Get.back();
                  Get.toNamed(AppRoutes.certificates);
                },
                icon: Icons.card_membership,
                title: 'Certificates',
              ),
              // _buildDrawerItem(
              //   icon: Icons.receipt_long,
              //   title: 'Payment Receipts',
              // ),
              // _buildDrawerItem(icon: Icons.headset_mic, title: 'Support'),
              // _buildDrawerItem(
              //   icon: Icons.chat_bubble_outline,
              //   title: 'Suggestions',
              // ),
              _buildDrawerItem(
                onTap: (){
                  Get.toNamed(AppRoutes.terms);
                },
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
              ),
              // _buildDrawerItem(icon: Icons.person_outline, title: 'Profile'),
              const Spacer(),
              const Divider(color: Colors.white38, height: 1),
              _buildDrawerItem(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {
                  Get.defaultDialog(
                    title: "Logout",
                    content: Text("Do you want to continue?"),
                    actions: [
                      OutlinedButton(onPressed: (){}, child: Text("Cancel")),
                      FilledButton(onPressed: (){
                          StorageController().deleteToken();
                       Get.offAllNamed(AppRoutes.login);
                      }, child: Text("Yes")),
                    ]
                  );
                
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (courseController.isLoading.value == true) {
          return LinearProgressIndicator();
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                   Text(
                    'Welcome back, ${authController.profile.value.user!.name!.split(" ")[0]}! 👋',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Here's your learning snapshot today.",
                    style: TextStyle(fontSize: 16, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(AppRoutes.upcoming);
                    },
                    icon: const Icon(Icons.add, size: 20),
                    label: const Text(
                      'Enroll in a Course',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryOrange,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildLiveClassCard(),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.mycourse);
                    },
                    child: _buildStatCard(
                      icon: Icons.menu_book,
                      iconColor: Colors.blue,
                      iconBgColor: Colors.blue.shade50,
                      title: 'Active Courses',
                      value: '${courseController.courses.value.data.length}',
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: (){
                      Get.toNamed(AppRoutes.certificates);
                    },
                    child: _buildStatCard(
                      icon: Icons.card_membership,
                      iconColor: Colors.purple,
                      iconBgColor: Colors.purple.shade50,
                      title: 'Certificates',
                      value: "${certificateController.certificates.value.data.length}",
                    ),
                  ),
                  // const SizedBox(height: 16),
                  // _buildStatCard(
                  //   icon: Icons.receipt_long,
                  //   iconColor: Colors.orange,
                  //   iconBgColor: Colors.orange.shade50,
                  //   title: 'Payments',
                  //   value: '13',
                  // ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColor.borderColor),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'My Courses',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                courseController.getCourses();
                                Get.to(MycourseView());
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                       ListView.builder(
  itemCount: courseController.courses.value.data.length > 3
      ? 3
      : courseController.courses.value.data.length,
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemBuilder: (BuildContext context, int index) {
    final course = courseController.courses.value.data[index];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: .5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          courseController.getCourse(course.enrollmentId!);
          Get.toNamed(AppRoutes.course);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CachedNetworkImage(
                    imageUrl: course.courseImage ?? '',
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        strokeWidth: 2,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.error_outline, size: 32),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Course Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course Name
                    Text(
                      course.courseName ?? 'Untitled Course',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Mentor
                    Row(
                      children: [
                        const Icon(Icons.person, size: 16, color: Colors.grey),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "Mentor: ${course.mentorName ?? 'N/A'}",
                            style: const TextStyle(fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Status
                    Row(
                      children: [
                        Text(
                          "Status: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                        if (course.status?.toLowerCase() == "pending")
                          const Row(
                            children: [
                              Icon(Icons.pending_rounded,
                                  size: 16, color: AppColor.primaryOrange),
                              SizedBox(width: 4),
                              Text(
                                "Pending",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.primaryOrange,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        else
                          const Row(
                            children: [
                              Icon(Icons.check_circle,
                                  size: 16, color: Colors.green),
                              SizedBox(width: 4),
                              Text(
                                "Approved",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Lessons Count
                    Row(
                      children: [
                        Icon(
                          Icons.play_circle_fill,
                          size: 18,
                          color: AppColor.primaryOrange,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "${course.lessons ?? 0} Videos",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
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
  },
),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 24),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(16),
                  //     border: Border.all(color: AppColor.borderColor),
                  //   ),
                  //   padding: const EdgeInsets.all(20),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           const Text(
                  //             'Recent Payments',
                  //             style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold,
                  //               color: Color(0xFF1E293B),
                  //             ),
                  //           ),
                  //           TextButton(
                  //             onPressed: () {},
                  //             style: TextButton.styleFrom(
                  //               padding: EdgeInsets.zero,
                  //               minimumSize: Size.zero,
                  //               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //             ),
                  //             child: const Text(
                  //               'See All',
                  //               style: TextStyle(
                  //                 fontSize: 14,
                  //                 color: Color(0xFF1E293B),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(height: 16),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(12),
                  //           border: Border.all(color: AppColor.borderColor),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.black.withOpacity(0.02),
                  //               blurRadius: 8,
                  //               offset: const Offset(0, 2),
                  //             ),
                  //           ],
                  //         ),
                  //         padding: const EdgeInsets.all(16),
                  //         child: Column(
                  //           children: [
                  //             _buildPaymentItem(
                  //               title: 'Advanced Excel',
                  //               amount: 'Rs.1,999',
                  //               date: 'Feb 20, 2026',
                  //             ),
                  //             const Divider(
                  //               color: AppColor.borderColor,
                  //               height: 32,
                  //             ),
                  //             _buildPaymentItem(
                  //               title: 'Web Design',
                  //               amount: 'Rs.1',
                  //               date: 'Feb 08, 2026',
                  //             ),
                  //             const Divider(
                  //               color: AppColor.borderColor,
                  //               height: 32,
                  //             ),
                  //             _buildPaymentItem(
                  //               title: 'Flutter',
                  //               amount: 'Rs.1,999',
                  //               date: 'Jan 05, 2026',
                  //               isLast: true,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 32), // extra space for bottom
               
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildLiveClassCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 100, // Approximate height
            decoration: const BoxDecoration(
              color: Color(0xFF10B981), // Green border
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Advanced Excel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Sita Katuwal',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Class Time: 8:00 - 9:30 pm',
                    style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981), // Green color
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('Join Live Class'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentItem({
    required String title,
    required String amount,
    required String date,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: isLast ? 0 : 0.0,
      ), // padding is handled by Divider or we can leave it
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.receipt_long, color: Colors.blue, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Amount: $amount | Date: $date',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(AppStrings.logo,width: 120.w,);
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: ListTile(
        dense: true,
        horizontalTitleGap: 0,
        leading: Icon(icon, color: Colors.white, size: 20),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        onTap: onTap ?? () {},
      ),
    );
  }
}
