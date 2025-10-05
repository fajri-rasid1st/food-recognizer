// analyzing_label.dart

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:food_recognizer/core/extensions/text_style_extension.dart';
import 'package:food_recognizer/src/ui/providers/analyzing_text_value_provider.dart';

class AnalyzingLabel extends StatelessWidget {
  const AnalyzingLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AnalyzingTextValue>.value(
      value: analyzingTextStream().map(AnalyzingTextValue.new),
      initialData: AnalyzingTextValue('Analyzing.'),
      child: _AnalyzingText(),
    );
  }
}

class _AnalyzingText extends StatelessWidget {
  const _AnalyzingText();

  @override
  Widget build(BuildContext context) {
    final text = context.watch<AnalyzingTextValue>();

    return Text(
      text.value,
      style: TextTheme.of(context).titleLarge!.bold.colorOnSurfaceVariant(context),
    );
  }
}
