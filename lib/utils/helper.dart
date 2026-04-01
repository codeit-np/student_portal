import 'package:codeit/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DialogType { success, warning, confirmation }

class CustomDialogs {
  // Main method to show modern dialog
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
        accentColor = Colors.green.shade600;
        icon = Icons.check_circle_rounded;
        defaultConfirmText = "Great!";
        break;
      case DialogType.warning:
        accentColor = Colors.orange.shade600;
        icon = Icons.warning_amber_rounded;
        defaultConfirmText = "I Understand";
        break;
      case DialogType.confirmation:
        accentColor = AppColor.primaryOrange;
        icon = Icons.help_outline_rounded;
        defaultConfirmText = "Confirm";
        break;
    }

    final confirmBtnText = confirmText ?? defaultConfirmText;
    final cancelBtnText = cancelText ?? "Cancel";

    Get.dialog(
      ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(
            parent: AnimationController(
              vsync: Navigator.of(Get.overlayContext!, rootNavigator: true),
              duration: const Duration(milliseconds: 250),
            )..forward(),
            curve: Curves.easeOutBack,
          ),
        ),
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600
            ),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon with background
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 68, color: accentColor),
                  ),
                  const SizedBox(height: 24),
                    
                  // Title
                  Text(
                    title,
                    style: Get.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                    
                  // Message
                  Text(
                    message,
                    style: Get.textTheme.bodyLarge?.copyWith(
                      color: Get.theme.textTheme.bodyLarge?.color?.withOpacity(
                        0.75,
                      ),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                    
                  // Action Buttons
                  Row(
                    children: [
                      if (type == DialogType.confirmation ||
                          type == DialogType.warning) ...[
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                              onCancel?.call();
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              cancelBtnText,
                              style: TextStyle(
                                fontSize: 16,
                                color: Get.theme.textTheme.bodyLarge?.color
                                    ?.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                            onConfirm?.call();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            confirmBtnText,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withOpacity(0.5),
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
      cancelText: cancelText ?? "Cancel",
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }
}
