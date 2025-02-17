const origin = (x: 10, y: 20);

class Point {
  final int x;
  final int y;

  //special method for instance()
  call() => print("i'm point with $x $y");

  //generic
  const Point(this.x, this.y);

  //named
  Point.origin() : x = origin.x, y = origin.y;

  Point.fromXY({required int a, bool isX = true})
    : x = isX ? a : 0,
      y = isX ? 0 : a;

  //redirect
  Point.fromPoint(Point p) : this.fromXY(a: p.x, isX: true);

  //overriding default method, operator
  @override
  String toString() => "($x, $y)";

  @override
  bool operator ==(Object other) =>
      other is Point && x == other.x && y == other.y;

  operator +(Point other) => Point(x + other.x, y + other.y);
}

// factory constructor
// use factory when
// 1. we need singleton // named constructor create new instance everytime
// 2. wanna return existing (from cache)
// 3. wanna return subclass of current class // can't in named constructor

class Animal {
  static final Animal _instance = Animal._internal();
  static final Map<String, Animal> _cache = {};

  const Animal();

  Animal._internal();

  //singleton
  factory Animal.get() => _instance;

  //return subclass
  factory Animal.type(String type, String name) {
    if (type == 'cat') return Cat(name);
    if (type == 'dog') return Dog(name);
    throw ArgumentError('unknown type $type');
  }

  //return existing
  factory Animal.cache(String type, String name) {
    return _cache.putIfAbsent(type, () => Animal.type(type, name));
  }
}

class Cat extends Animal {
  final String name;

  const Cat(this.name) : super();

  @override
  String toString() => "i'm cat named $name";
}

class Dog extends Animal {
  final String name;

  const Dog(this.name) : super();

  @override
  String toString() => "i'm dog named $name";
}

main() {
  const point = Point(10, 4);
  point();
  final cat1 = Animal.cache('cat', 'tom');
  final cat2 = Animal.cache('cat', 'jimmy');
  final dog = Animal.cache('dog', 'rex');
  print("$cat1 $cat2 $dog, is both cat1 and cat2 are cat = ${cat1 == cat2}");
}
