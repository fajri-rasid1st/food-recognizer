// Flutter imports:
import 'package:flutter/material.dart';

class ResponseLoadingIndicator extends StatelessWidget {
  const ResponseLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}
