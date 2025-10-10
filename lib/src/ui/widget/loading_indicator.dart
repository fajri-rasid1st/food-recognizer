// Flutter imports:
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double radius;

  const LoadingIndicator({
    super.key,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          valueColor: AlwaysStoppedAnimation<Color>(ColorScheme.of(context).primary),
        ),
      ),
    );
  }
}
