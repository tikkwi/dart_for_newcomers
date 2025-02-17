// base
// base restrict subclassing for outside of the same package
// as same package mean same pubspec(which is one for one project normally), the
// real use-case of base class is typically for library or module

// interface
// the only difference between interface and normal class is interfaces can't extends
// and we must implement instead, and even though interface (without abstract keyword)
// can't have no body method, the implementation aren't required and don't take account
// even we did becz we must override in subclass.
// why i show example together with abstract class is becz i wanna highlight that
// abstract can do everything interface can do (even more, they can have method with
// or without body, child can extends or implement).
// if we need real interface (intent purpose), we should combine with abstract keyword
// to be able to include method with no body

interface class Animal {
  final String name;

  const Animal(this.name);

  void feed() {}
}

abstract class LivingThing {
  void eat();
}

class Dog implements Animal, LivingThing {
  final String dogName;

  const Dog(this.dogName);

  @override
  void feed() => print('feeding..');

  @override
  String get name => dogName;

  @override
  void eat() => print('eating..');
}

// final
// to prevent subclassing

main() {
  final dog = Dog('rex');
  dog.feed();
}
