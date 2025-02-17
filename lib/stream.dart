// stream in simplest term is the array version of future (async)

Stream<int> sumStream(Stream<int> stream) async* {
  int sum = 0;
  await for (final value in stream) {
    print("emitted $value");
    yield sum += value;
  }
}

main() {
  Stream<int> stream = Stream.periodic(
    const Duration(seconds: 1),
    (i) => i * i,
  ).take(10);
  sumStream(stream).listen((value) => print("sum now $value"));
}
