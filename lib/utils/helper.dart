import 'dart:ui';

import 'package:codeit/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DialogType { success, warning, confirmation }

class CustomDialogs {
  // Main method to show modern compact dialog
  static void showModernDialog({
    required DialogType type,
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    Color accentColor;
    IconData icon;
    String defaultConfirmText = "OK";

    switch (type) {
      case DialogType.success:
        accentColor = const Color(0xFF10B981);
        icon = Icons.check_circle_rounded;
        defaultConfirmText = "Got it";
        break;
      case DialogType.warning:
        accentColor = const Color(0xFFF59E0B);
        icon = Icons.warning_rounded;
        defaultConfirmText = "Okay";
        break;
      case DialogType.confirmation:
        accentColor = AppColor.primaryOrange;
        icon = Icons.question_mark_rounded;
        defaultConfirmText = "Yes";
        break;
    }

    final confirmBtnText = confirmText ?? defaultConfirmText;
    final cancelBtnText = cancelText ?? "No";

    Get.dialog(
      Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // Transparent background with blur
            Container(
              color: Colors.black.withOpacity(0.4),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: const SizedBox.expand(),
              ),
            ),
            
            // Dialog
            Center(
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 300),
                tween: Tween<double>(begin: 0.9, end: 1.0),
                curve: Curves.easeOutCubic,
                builder: (context, double scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: FadeTransition(
                      opacity: AlwaysStoppedAnimation(scale),
                      child: Container(
                        width: 320,
                        constraints: const BoxConstraints(minWidth: 280),
                        decoration: BoxDecoration(
                          color: Get.theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 24,
                              spreadRadius: 0,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Top accent line
                            Container(
                              height: 4,
                              width: 60,
                              margin: const EdgeInsets.only(top: 16),
                              decoration: BoxDecoration(
                                color: accentColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Icon circle
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: accentColor.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      icon,
                                      size: 32,
                                      color: accentColor,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  
                                  // Title
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.3,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  
                                  // Message
                                  Text(
                                    message,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Get.theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
                                      height: 1.4,
                                      letterSpacing: -0.2,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 24),
                                  
                                  // Action Buttons
                                  Row(
                                    children: [
                                      if (type == DialogType.confirmation ||
                                          type == DialogType.warning) ...[
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.back();
                                              onCancel?.call();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  cancelBtnText,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey.shade700,
                                                    letterSpacing: -0.2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.back();
                                            onConfirm?.call();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            decoration: BoxDecoration(
                                              color: accentColor,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Text(
                                                confirmBtnText,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                  letterSpacing: -0.2,
                                                ),
                                              ),
                                            ),
                                          ),
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
            ),
          ],
        ),
      ),
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.transparent,
    );
  }

  // Quick toast-style dialogs
  static void quickSuccess({
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    Get.closeCurrentSnackbar();
    Get.rawSnackbar(
      message: message,
      backgroundColor: const Color(0xFF10B981),
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      snackStyle: SnackStyle.FLOATING,
      duration: duration,
      icon: const Icon(Icons.check_circle, color: Colors.white, size: 20),
      snackPosition: SnackPosition.TOP,
    );
  }

  static void quickError({
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    Get.closeCurrentSnackbar();
    Get.rawSnackbar(
      message: message,
      backgroundColor: const Color(0xFFEF4444),
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      snackStyle: SnackStyle.FLOATING,
      duration: duration,
      icon: const Icon(Icons.error_outline, color: Colors.white, size: 20),
      snackPosition: SnackPosition.TOP,
    );
  }

  static void quickInfo({
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    Get.closeCurrentSnackbar();
    Get.rawSnackbar(
      message: message,
      backgroundColor: const Color(0xFF3B82F6),
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      snackStyle: SnackStyle.FLOATING,
      duration: duration,
      icon: const Icon(Icons.info_outline, color: Colors.white, size: 20),
      snackPosition: SnackPosition.TOP,
    );
  }

  // Convenience methods
  static void success({
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onConfirm,
  }) {
    showModernDialog(
      type: DialogType.success,
      title: title,
      message: message,
      confirmText: buttonText,
      onConfirm: onConfirm,
    );
  }

  static void warning({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    showModernDialog(
      type: DialogType.warning,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  static void confirmation({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    showModernDialog(
      type: DialogType.confirmation,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText ?? "No",
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }
}