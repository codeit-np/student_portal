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
        title: Text("My Certificates"),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return LinearProgressIndicator();
        }

        final certificates = controller.certificates.value.data;

        if (certificates.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.workspace_premium_outlined,
                  size: 80,
                  color: theme.colorScheme.primary.withOpacity(0.6),
                ),
                const SizedBox(height: 16),
                Text(
                  "No certificates yet",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Complete courses to earn certificates",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.getCertificated();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${certificates.length} Certificates",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  itemCount: certificates.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final cert = certificates[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CertificateCard(
                        certificate: cert,
                        onEmailPressed: () async {
                          CustomDialogs.confirmation(
                            title: "Confirmation",
                            message:
                                "Do you want us to send this certificate to your registered email?",

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
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// Reusable beautiful certificate card
class CertificateCard extends StatelessWidget {
  final dynamic certificate; // Replace with your actual model type
  final VoidCallback onEmailPressed;

  const CertificateCard({
    super.key,
    required this.certificate,
    required this.onEmailPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: theme.colorScheme.shadow.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          // Optional: Navigate to certificate detail/preview
          // Get.to(() => CertificateDetailView(certificate: certificate));
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon + course name
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.workspace_premium,
                      size: 32,
                      color: AppColor.primaryOrange,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      certificate.courseName ?? "Course Name",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Details
              _buildDetailRow(
                context,
                icon: Icons.person_outline,
                label: "Issued To",
                value: certificate.issuedTo ?? "N/A",
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                context,
                icon: Icons.calendar_today_outlined,
                label: "Issue Date",
                value: certificate.courseCompletionDate ?? "N/A",
              ),

              const SizedBox(height: 28),

              // Action Button
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: onEmailPressed,
                  icon: const Icon(Icons.email_outlined, size: 20),
                  label: const Text("Send to Email"),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColor.primaryOrange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary.withOpacity(0.7)),
        const SizedBox(width: 12),
        Text(
          "$label: ",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodySmall?.color,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
