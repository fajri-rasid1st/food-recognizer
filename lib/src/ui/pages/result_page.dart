// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:food_recognizer/core/extensions/text_style_extension.dart';
import 'package:food_recognizer/src/ui/widget/scaffold_safe_area.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSafeArea(
      appBar: _ResultAppBar(),
      body: _ResultBody(),
    );
  }
}

class _ResultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ResultAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorScheme.of(context).inversePrimary,
      title: Text('Hasil Analisa'),
      titleTextStyle: TextTheme.of(context).titleLarge!.semiBold.colorOnSurface(context),
      titleSpacing: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 4);
}

class _ResultBody extends StatefulWidget {
  const _ResultBody();

  @override
  State<_ResultBody> createState() => _ResultBodyState();
}

class _ResultBodyState extends State<_ResultBody> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // todo-02: run the inference model based on user picture
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        Expanded(
          child: Center(
            child: Image.network(
              "https://github.com/dicodingacademy/assets/raw/refs/heads/main/flutter_ml/assets/nasi-lemak.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          // todo-03: show the inference result (food name and the confidence score)
          child: Row(),
        ),
      ],
    );
  }
}
