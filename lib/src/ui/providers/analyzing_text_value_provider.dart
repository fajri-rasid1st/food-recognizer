class AnalyzingTextValue {
  final String value;

  const AnalyzingTextValue(this.value);
}

Stream<String> analyzingTextStream({
  String base = 'Analyzing',
  int minDots = 1,
  int maxDots = 3,
  Duration interval = const Duration(milliseconds: 500),
}) async* {
  assert(minDots >= 0 && maxDots >= minDots);

  var i = 0;

  while (true) {
    final dotsCount = minDots + (i % (maxDots - minDots + 1));

    yield '$base${'.' * dotsCount}';

    await Future.delayed(interval);

    i++;
  }
}
