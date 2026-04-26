import 'package:codeit/controller/certificate_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

class CertificateView extends GetView<CertificateController> {
  const CertificateView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "My Certificates",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () => controller.getCertificated(),
              icon: const Icon(Icons.refresh_rounded),
              style: IconButton.styleFrom(
                backgroundColor: Colors.grey.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryOrange),
            ),
          );
        }

        final certificates = controller.certificates.value.data;

        if (certificates.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColor.primaryOrange.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.workspace_premium_outlined,
                    size: 80,
                    color: AppColor.primaryOrange.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "No certificates yet",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Complete courses to earn certificates",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.primaryOrange, AppColor.primaryOrange.withOpacity(0.8)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Browse Courses",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.getCertificated();
          },
          color: AppColor.primaryOrange,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColor.primaryOrange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${certificates.length} Certificates",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppColor.primaryOrange,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final cert = certificates[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CertificateCard(
                          certificate: cert,
                          onEmailPressed: () async {
                            CustomDialogs.confirmation(
                              title: "Send Certificate",
                              message: "Do you want us to send this certificate to your registered email?",
                              confirmText: "Send",
                              cancelText: "Cancel",
                              onConfirm: () async {
                                Loader.show(context);
                                Get.back();
                                await controller.getCertificate(cert.certicateId);
                                Loader.hide();
                              },
                            );
                          },
                        ),
                      );
                    },
                    childCount: certificates.length,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// Modern Certificate Card
class CertificateCard extends StatelessWidget {
  final dynamic certificate;
  final VoidCallback onEmailPressed;

  const CertificateCard({
    super.key,
    required this.certificate,
    required this.onEmailPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              children: [
                // Icon Container
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColor.primaryOrange.withOpacity(0.15),
                        AppColor.primaryOrange.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.workspace_premium,
                    size: 32,
                    color: AppColor.primaryOrange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Certificate of Completion",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primaryOrange,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        certificate.courseName ?? "Course Name",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColor.primaryOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColor.primaryOrange.withOpacity(0.2),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        size: 12,
                        color: AppColor.primaryOrange,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "Verified",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primaryOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Divider with gradient
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade200,
                    Colors.grey.shade100,
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Details Row
            Row(
              children: [
                Expanded(
                  child: _buildInfoTile(
                    icon: Icons.person_outline_rounded,
                    label: "Issued To",
                    value: certificate.issuedTo ?? "N/A",
                    theme: theme,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInfoTile(
                    icon: Icons.calendar_today_rounded,
                    label: "Issue Date",
                    value: certificate.courseCompletionDate ?? "N/A",
                    theme: theme,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Send to Email Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onEmailPressed,
                icon: const Icon(Icons.email_rounded, size: 18),
                label: const Text("Send to Email"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: AppColor.primaryOrange.withOpacity(0.7),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}