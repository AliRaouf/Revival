import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastUtils {
  static void showSuccessToast(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(message),
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 3),
      style: ToastificationStyle.flat,
    );
  }

  static void showErrorToast(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(message),
      type: ToastificationType.error,
      autoCloseDuration: const Duration(seconds: 4),
      style: ToastificationStyle.flat,
    );
  }

  static void showInfoToast(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(message),
      type: ToastificationType.info,
      autoCloseDuration: const Duration(seconds: 3),
      style: ToastificationStyle.flat,
    );
  }

  static void showWarningToast(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(message),
      type: ToastificationType.warning,
      autoCloseDuration: const Duration(seconds: 4),
      style: ToastificationStyle.flat,
    );
  }

  // Convenience method to replace snackbar with appropriate toast type
  static void showToast(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    if (isError) {
      showErrorToast(context, message);
    } else {
      showSuccessToast(context, message);
    }
  }
}
