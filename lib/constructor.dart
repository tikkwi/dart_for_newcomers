// Constructors in Dart
//
// Dart provides several types of constructors to handle object initialization.
//
// 1. Generative Constructor (Standard)
// 2. Named Constructor
// 3. Redirecting Constructor
// 4. Constant Constructor
// 5. Factory Constructor

// Global constant (Record) used in the example below
const origin = (x: 10, y: 20);

// ---------------------------------------------------------------------------
// 1. Point Class: Generative, Named, Redirecting, Const
// ---------------------------------------------------------------------------

class Point {
  final int x;
  final int y;

  // A. Generative Constructor (Standard)
  // 'const' allows creating compile-time constants (canonical instances).
  // 'this.x' is syntactic sugar for initializing fields.
  const Point(this.x, this.y);

  // B. Named Constructor
  // Used to provide multiple ways to initialize an object.
  // Initializer list (: x = ..., y = ...) runs BEFORE the constructor body.
  // Here we use the global 'origin' record.
  Point.origin()
      : x = origin.x,
        y = origin.y;

  // C. Named Constructor with Logic in Initializer List
  Point.fromXY({required int a, bool isX = true})
      : x = isX ? a : 0,
        y = isX ? 0 : a;

  // D. Redirecting Constructor
  // Delegates to another constructor in the same class using 'this(...)'.
  // Useful for avoiding code duplication (DRY).
  //
  // Q: "Why bother redirecting? Just call the main one."
  // A: It allows you to reuse the logic of another constructor.
  //    Here, we reuse 'fromXY' instead of rewriting the assignment logic.
  //
  // Q: "Can I do conditional redirect? (p==1 ? const1 : const2)"
  // A: NO. A standard redirecting constructor (`: this(...)`) CANNOT have logic.
  //    It must be a direct mapping. If you need logic, use a FACTORY (see Message class below).
  Point.fromPoint(Point p) : this.fromXY(a: p.x, isX: true);

  // Special method: 'call()' allows the instance to be called like a function.
  void call() => print("i'm point with $x $y");

  @override
  String toString() => "($x, $y)";

  // Operator overloading
  @override
  bool operator ==(Object other) =>
      other is Point && x == other.x && y == other.y;

  Point operator +(Point other) => Point(x + other.x, y + other.y);
}

// ---------------------------------------------------------------------------
// 2. Logger Class: Factory Constructor (Singleton & Caching)
// ---------------------------------------------------------------------------
// Use 'factory' when:
// 1. You don't always want to create a NEW instance (e.g., Singleton, Caching).
// 2. You want to return a subtype (e.g., returning a specific implementation).
// 3. You need to perform logic before creating the instance.

// Q: "Is factory more like a function?"
// A: YES. It looks like a constructor to the caller, but acts like a static method.
//    It HAS a body, MUST return an instance, and does NOT create 'this' automatically.

class Logger {
  final String name;
  
  // Static cache to store instances
  static final Map<String, Logger> _cache = {};

  // Private generative constructor
  // Clients cannot call this directly.
  Logger._internal(this.name) {
    print('  [Logger] Creating new instance for "$name"');
  }

  // E. Factory Constructor
  // Looks like a constructor, but acts like a static method that returns an instance.
  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      print('  [Logger] Returning cached instance for "$name"');
      return _cache[name]!;
    } else {
      final logger = Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  void log(String msg) => print('$name: $msg');
}

// ---------------------------------------------------------------------------
// 3. Shape Class: Factory returning Subtypes
// ---------------------------------------------------------------------------

abstract class Shape {
  // Factory constructor can return a subclass instance!
  factory Shape(String type) {
    if (type == 'circle') return Circle(2);
    if (type == 'square') return Square(2);
    throw ArgumentError("Can't create $type");
  }
  
  double get area;
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);
  @override
  double get area => 3.14 * radius * radius;
}

class Square implements Shape {
  final double side;
  Square(this.side);
  @override
  double get area => side * side;
}

// ---------------------------------------------------------------------------
// 4. Message Class: Factory with Logic (Conditional Creation)
// ---------------------------------------------------------------------------
// This answers the "p == 1 ? const1 : const2" question.

class Message {
  final String content;
  Message._(this.content);

  // Factory can decide WHICH class or constructor to return based on logic.
  factory Message.create(int type) {
    if (type == 1) {
      return Message._("Hello");
    } else {
      return Message._("Goodbye");
    }
  }
}

// ---------------------------------------------------------------------------
// Main Execution
// ---------------------------------------------------------------------------

void main() {
  print('--- 1. Point Constructors ---');
  const p1 = Point(10, 20); // Const constructor
  var p2 = Point.origin();  // Named constructor using global record
  var p3 = Point.fromXY(a: 5, isX: true); // Named with logic
  var p4 = Point.fromPoint(p1); // Redirecting

  print('p1: $p1');
  print('p2: $p2');
  print('p3: $p3');
  print('p4: $p4');
  
  // Using the 'call' method
  p1(); 

  print('\n--- 2. Factory Constructor (Caching) ---');
  var log1 = Logger('UI');
  var log2 = Logger('Network');
  var log3 = Logger('UI'); // Should return cached instance

  print('Is log1 same object as log3? ${identical(log1, log3)}'); // true

  print('\n--- 3. Factory Constructor (Subtypes) ---');
  var s1 = Shape('circle');
  var s2 = Shape('square');
  
  print('Shape 1 is ${s1.runtimeType} with area ${s1.area}');
  print('Shape 2 is ${s2.runtimeType} with area ${s2.area}');

  print('\n--- 4. Factory Logic (Conditional) ---');
  var m1 = Message.create(1);
  var m2 = Message.create(99);
  print('Message 1: ${m1.content}');
  print('Message 2: ${m2.content}');
}
