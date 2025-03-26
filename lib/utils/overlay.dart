import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/common/widgets/indicator.dart';

showOverlay({required Future<Null> Function() asyncFunction}) =>
    Get.showOverlay(
        loadingWidget: Indicators.progressIndicator,
        asyncFunction: asyncFunction);

extension CustomSnackBar on GetInterface {
  void success(String title, String message) {
    closeAllSnackbars();
    snackbar(
      title,
      message,
      backgroundColor: Colors.green.shade300,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void error(String title, String message) {
    closeAllSnackbars();
    snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade300,
        duration: Duration(seconds: 1));
  }
}
