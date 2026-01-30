// Variables in Dart

// Dart has several ways to declare variables: var, final, const, late, dynamic.
// This demonstrates their differences, especially demystifying const and final.

void main() {
  // var: Type is inferred, can be reassigned
  var name = 'Alice';
  print('var name: $name');
  name = 'Bob'; // OK
  print('Reassigned name: $name');

  // final: Assigned once at runtime, cannot be reassigned
  final age = 25;
  print('final age: $age');
  // age = 26; // Error: can't assign to final

  // const: Compile-time constant, must be known at compile time
  const pi = 3.14159;
  print('const pi: $pi');
  // pi = 3.14; // Error: can't assign to const

  // Difference: final can be set at runtime, const cannot
  final now = DateTime.now(); // OK, set at runtime
  print('final now: $now');
  // const compileTimeNow = DateTime.now(); // Error: not compile-time constant

  // const can be used for immutable collections
  const numbers = [1, 2, 3]; // Immutable list
  print('const numbers: $numbers');
  // numbers.add(4); // Error: cannot modify const list

  // final list can be modified
  final modifiableList = [1, 2, 3];
  modifiableList.add(4); // OK
  print('final modifiableList: $modifiableList');

  // late: Lazy initialization, assigned later
  late String lazyValue;
  // print(lazyValue); // Error: not initialized
  lazyValue = 'Initialized now';
  print('late lazyValue: $lazyValue');

  // dynamic: Can hold any type, type checking at runtime
  dynamic anything = 'string';
  print('dynamic anything: $anything');
  anything = 42;
  print('dynamic anything now: $anything');

  // Type annotations
  int explicitInt = 10;
  String explicitString = 'hello';
  print('explicit int: $explicitInt, string: $explicitString');

  // Nullable variables
  String? nullableString;
  print('nullableString: $nullableString'); // null
  nullableString = 'not null';
  print('nullableString now: $nullableString');
}
