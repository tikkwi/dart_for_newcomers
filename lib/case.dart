// here we can learn
// 1. advanced switch
// 2. difference destructuring
// 3. guard (when)

String switchMe(obj) {
  switch (obj) {
    case var a when [1, 2, 'hi'].contains(a):
      return "i'm special $a";
    case int _:
      return "i'm number";
    case String _:
      return "i'm string";
    case (int a, int b) when a > b:
      return "i'm object with $a $b and a is greater";
    case (int a, int b):
      return "i'm object with $a $b";
    case (a: int a, b: int b):
      return "i'm named object with $a $b";
    case Unnamed(:int a, :int b):
      return "i'm unnamed class with $a $b";
    case Named(:int a, :int b):
      return "i'm named class with $a $b";
    default:
      return "i'm unknown";
  }
}

class Unnamed {
  final int a;
  final int b;

  const Unnamed(this.a, this.b);
}

class Named {
  final int a;
  final int b;

  const Named({required this.a, required this.b});
}

main() {
  const arr = [
    10,
    'hello',
    [1, 2],
    (5, 10),
    (10, 5),
    (a: 10, b: 5),
    Unnamed(3, 4),
    Named(a: 5, b: 6),
  ];
  for (final obj in arr) {
    print(switchMe(obj));
  }

  // If-case examples: pattern matching in if statements without switch
  print('\nIf-case examples:');

  var data = {'user': ['Alice', 30]};
  if (data case {'user': [String name, int age]}) {
    print('Matched user: $name, age: $age');
  }

  var num = 42;
  if (num case int n when n > 40) {
    print('Number greater than 40: $n');
  }

  var point = (x: 10, y: 20);
  if (point case (x: int x, y: int y)) {
    print('Point: x=$x, y=$y');
  }

  var list = [1, 2, 3];
  if (list case [int a, int b, int c]) {
    print('List: $a, $b, $c');
  }
}
