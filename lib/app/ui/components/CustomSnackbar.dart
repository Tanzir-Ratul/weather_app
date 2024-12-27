import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void showSnackbar({
    required String title,
    required String message,
    int seconds = 3,
    Color? colorText = Colors.white,
    Color? backgroundColor = Colors.red,
    Widget? icon,
  }) {
    Get.snackbar(
      title,
      message,
      colorText: colorText,
      backgroundColor: backgroundColor,
      icon: icon,
      snackPosition: SnackPosition.BOTTOM, // Optional: Set position
      duration: Duration(seconds: seconds),

    );
  }
}
