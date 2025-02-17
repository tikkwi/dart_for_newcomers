//generic
mixin Walk {
  void walk() => print("i'm walking");
}

mixin Run {
  void run() => print("i'm running");
}

//allow specific classes
mixin Dance on Artist {
  void dance() => print("i'm dancing");
}

/*
* there can also be mixin class with some restrictions
* 1. Mixins can't have extends or with clauses, so neither can a mixin class.
* 2. Classes can't have an on clause, so neither can a mixin class.
* */

abstract class Artist with Walk, Run {
  void perform();
}

class Singer extends Artist {
  @override
  void perform() => print("i'm singing");
}

class SingerDancer extends Singer with Dance {}

main() {
  //
  // dart's more concise way of this
  // final singer = Singer();
  // singer.perform();
  // singer.run()
  //
  Singer()
    ..perform()
    ..run();
  SingerDancer()
    ..perform()
    ..run()
    ..dance();
}
