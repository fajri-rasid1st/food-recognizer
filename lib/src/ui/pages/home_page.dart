// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:food_recognizer/src/ui/widget/scaffold_safe_area.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSafeArea(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Food Recognizer App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: _HomeBody(),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: () {
                // todo-01: tap this icon to open image picker feature
              },
              child: Align(
                alignment: Alignment.center,
                child: Icon(Icons.image, size: 100),
              ),
            ),
          ),
        ),
        FilledButton.tonal(
          onPressed: () {
            // context.read<HomeController>().goToResultPage(context);
          },
          child: Text("Analyze"),
        ),
      ],
    );
  }
}
