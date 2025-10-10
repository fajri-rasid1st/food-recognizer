// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:food_recognizer/core/extensions/text_style_extension.dart';

class ErrorText extends StatelessWidget {
  final String? message;

  const ErrorText(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message ?? '-',
        textAlign: TextAlign.center,
        style: TextTheme.of(context).bodyMedium!.medium.colorOutline(context),
      ),
    );
  }
}
