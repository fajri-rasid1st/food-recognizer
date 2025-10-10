// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:food_recognizer/core/utilities/navigator_key.dart';
import 'package:food_recognizer/src/ui/widget/loading_indicator.dart';

class ModalUtils {
  ModalUtils._();

  static void showLoadingDialog() {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: kDebugMode,
      builder: (_) => LoadingIndicator(radius: 20),
    );
  }

  static void hideLoadingDialog() {
    navigatorKey.currentState!.pop();
  }
}
