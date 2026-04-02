import 'package:codeit/controller/auth_controller.dart';
import 'package:codeit/controller/order_controller.dart';
import 'package:codeit/utils/app_color.dart';
import 'package:codeit/utils/app_routes.dart';
import 'package:codeit/utils/app_strings.dart';
import 'package:codeit/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

class CheckoutView extends GetView<AuthController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    var orderController = Get.find<OrderController>();
    var course = Get.arguments;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text("Checkout"),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Checkout Summary Header
                        Row(
                          children: [
                            const Icon(
                              Icons.shopping_cart,
                              color: AppColor.primaryOrange,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Checkout Summary',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Details Rows
                        _buildDetailRow(
                          'Course:',
                          '${course.courseName}',
                          isBoldValue: true,
                          fontSizeValue: 16,
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow('Batch Starts:', '${course.startDate}'),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                          'Duration:',
                          '${course.courseDuration}',
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow('Mode:', 'Online (Google Meet)'),

                        const SizedBox(height: 24),
                        const Divider(color: Color(0xFFE2E8F0)),
                        const SizedBox(height: 24),

                        // Total Amount Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: Text(
                                'Total Amount:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Rs. ${course.offerPrice}/-",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primaryOrange,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'Rs.${course.actualPrice}',
                                      style: TextStyle(
                                        fontSize: 12,
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
                                        'Save ${course.discount}',
                                        style: TextStyle(
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
                          ],
                        ),

                        const SizedBox(height: 24),
                        const Divider(
                          color: Color.fromRGBO(243, 111, 33, 0.3),
                        ), // Orange tint divider
                        const SizedBox(height: 24),

                        // Student Details Header
                        Row(
                          children: [
                            const Icon(
                              Icons.account_circle,
                              color: AppColor.primaryOrange,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Student Details',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Student Details Box
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildStudentDetailBoxItem(
                                'Full Name',
                                '${controller.profile.value.user!.name}',
                              ),
                              const SizedBox(height: 16),
                              _buildStudentDetailBoxItem(
                                'Email',
                                '${controller.profile.value.user!.email}',
                              ),
                              const SizedBox(height: 16),
                              _buildStudentDetailBoxItem(
                                'Whatsapp',
                                '${controller.profile.value.user!.phone}',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Divider(color: Color(0xFFE2E8F0)),
                        const SizedBox(height: 24),

                        // Payment Section Box
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color.fromRGBO(243, 111, 33, 0.3),
                            ), // Soft orange boundary
                          ),
                          child: Column(
                            children: [
                              // Mocking the Fonepay Logo

                              // Mock QR Code Box
                              Container(
                                width: 400,
                                height: 400,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.primaryOrange,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // The actual dashed border container
                                    SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),

                                    // In real app, put Image.asset or network image of QR here
                                    Image.asset(AppStrings.fonepay),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Bank Transfer Box
                        _buildBankTransferBox(),

                        // const SizedBox(height: 24),

                        // Upload Payment Receipt
                        // _buildUploadReceiptBox(),
                        const SizedBox(height: 24),

                        // Terms & Conditions Checkbox
                        Column(
                          children: [
                            Obx(() {
                              return Column(
                                children: [
                                  orderController.image.value != null
                                      ? GestureDetector(
                                          onTap: () {
                                            orderController.pickImage();
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: const Color(
                                                0xFFFFF7F2,
                                              ), // Very light orange/peach background
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: const Color.fromRGBO(
                                                  243,
                                                  111,
                                                  33,
                                                  0.3,
                                                ),
                                              ),
                                            ),
                                            child: Image.file(
                                              orderController.image.value!,
                                              height: 200,
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            orderController.pickImage();
                                          },
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 160,
                                            child: Stack(
                                              children: [
                                                // Dashed border
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  child: CustomPaint(
                                                    painter:
                                                        DashedBorderPainter(
                                                          color: const Color(
                                                            0xFF94A3B8,
                                                          ),
                                                          strokeWidth: 1.5,
                                                          dashWidth: 6.0,
                                                          dashSpace: 6.0,
                                                          borderRadius: 12.0,
                                                        ),
                                                  ),
                                                ),
                                                // Content
                                                Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(
                                                        Icons
                                                            .cloud_upload_outlined,
                                                        color: Color(
                                                          0xFF64748B,
                                                        ),
                                                        size: 40,
                                                      ),
                                                      SizedBox(height: 12),
                                                      Text(
                                                        'Tap here',
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xFF1E293B,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        '(PNG, JPG • Max 2MB)',
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xFF94A3B8,
                                                          ),
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              );
                            }),

                            // FilledButton(
                            //   onPressed: () {
                            //     orderController.pickImage();
                            //   },
                            //   child: Text("Pick Image"),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        Row(
                          children: [
                            Checkbox(
                              value: orderController.terms.value,
                              onChanged: (value) {
                                orderController.terms.value = value!;
                              },
                            ),

                            Expanded(child: Text("I agree to the Terms and Conditions.")),
                          ],
                        ),
                        // Confirm Payment & Button
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {
                              if (orderController.image.value != null) {
                                if (orderController.terms.value == false) {
                                  CustomDialogs.warning(
                                    title: "Warning",
                                    message:
                                        "You have not accepted the Terms and Conditions.",
                                  );
                                } else {
                                  CustomDialogs.confirmation(
                                    title: "Confirmation",
                                    message:
                                        "Are you sure you want to continue?",
                                    onConfirm: () async {
                                      if (orderController.terms.value == true) {
                                        Get.back();
                                        Loader.show(context);
                                        await orderController.placeOrder(
                                          orderController.image.value!,
                                          course.upcomingId,
                                        );
                                        Loader.hide();
                                        Get.offAndToNamed(
                                          AppRoutes.confirmation,
                                        );
                                      }
                                    },
                                  );
                                }
                              } else {
                                CustomDialogs.warning(title: "Warning", message: "Please upload your payment receipt to continue.");
                              
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryOrange,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Confirm Payment & Enroll',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Bottom Footer Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.lock,
                              color: Color(0xFF94A3B8),
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 13,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'Secure payment • Fast verification • Lifetime\naccess after confirmation',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'By completing this payment, you agree to our terms and conditions. Verification may take up to 24 hours. You\'ll receive WhatsApp group invite and portal access upon verification.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF94A3B8),
                              fontSize: 12,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBankTransferBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7F2), // Very light orange/peach background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromRGBO(243, 111, 33, 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.account_balance, color: Color(0xFF1E293B)),
              SizedBox(width: 8),
              Text(
                'Bank Transfer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildBankDetailRow('Bank:', 'Nepal Bank Limited'),
          const SizedBox(height: 8),
          _buildBankDetailRow('Account Name:', 'Code IT'),
          const SizedBox(height: 8),
          _buildBankDetailRow('Ac/No:', '01600106885462000001'),
          const SizedBox(height: 8),
          _buildBankDetailRow('Branch:', 'Dharan'),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '* ',
                style: TextStyle(
                  color: AppColor.primaryOrange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 2.0),
                  child: Text(
                    'Please take a screenshot after the payment.',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Color(0xFF1E293B), fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadReceiptBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            text: 'Upload Payment Receipt ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: AppColor.primaryOrange),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 160,
          child: Stack(
            children: [
              // Dashed border
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: CustomPaint(
                  painter: DashedBorderPainter(
                    color: const Color(0xFF94A3B8),
                    strokeWidth: 1.5,
                    dashWidth: 6.0,
                    dashSpace: 6.0,
                    borderRadius: 12.0,
                  ),
                ),
              ),
              // Content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.cloud_upload_outlined,
                      color: Color(0xFF64748B),
                      size: 40,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Click or drag receipt here',
                      style: TextStyle(
                        color: Color(0xFF1E293B),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '(PNG, JPG • Max 2MB)',
                      style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isBoldValue = false,
    double fontSizeValue = 15,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: const TextStyle(fontSize: 15, color: Color(0xFF64748B)),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: fontSizeValue,
              fontWeight: isBoldValue ? FontWeight.bold : FontWeight.w500,
              color: const Color(0xFF1E293B),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStudentDetailBoxItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 15, color: Color(0xFF1E293B)),
        ),
      ],
    );
  }
}

// Custom painter for dashed border with rounded corners
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.dashWidth = 8.0,
    this.dashSpace = 6.0,
    this.borderRadius = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    var path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
        ),
      );

    var dashPath = Path();
    for (var pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
