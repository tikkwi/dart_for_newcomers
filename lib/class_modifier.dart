// Class Modifiers in Dart (Deep Dive)

// ---------------------------------------------------------------------------
// 1. What is a "Contract"?
// ---------------------------------------------------------------------------
// In programming, a "contract" is a promise. 
// If a class says it "implements" an interface, it's promising the compiler:
// "I guarantee I have these specific methods and properties, so you can 
// safely call them."
//
// It allows for "Polymorphism": You can treat a FileStorage, CloudStorage,
// and MockStorage all as just 'Storage' because they all follow the same contract.

abstract interface class Storage {
  void save(String data); // The contract: "You must have a save method"
}

// ---------------------------------------------------------------------------
// 2. Interface Class: Why have implementations if they are "wasted"?
// ---------------------------------------------------------------------------
// An 'interface class' (without the 'abstract' keyword) can be instantiated.
//
// Is the implementation a waste?
// - NO, if you use the class directly: `var mock = MockLogger();`
// - YES, if you implement it: `class MyLogger implements MockLogger { ... }`
//
// The GOAL of 'interface' is to prevent "Backdoor Inheritance".
// It forces other developers to rewrite the logic, preventing them from 
// relying on your internal implementation details which might change later.

interface class MockLogger {
  void log(String msg) {
    print('Default Mock Log: $msg'); // Used if we do `MockLogger().log()`
  }
}

// When we 'implements', we ONLY take the signature (the contract).
// We are FORCED to provide a new body. The original body is ignored.
class CustomLogger implements MockLogger {
  @override
  void log(String msg) => print('Custom Log: $msg');
}

// ---------------------------------------------------------------------------
// 3. Implements vs Extends with Variables (Fields)
// ---------------------------------------------------------------------------
// "Does 'implements' only take the signature for variables too?"
// YES. In Dart, fields (variables) implicitly generate getters (and setters if not final).
// When you implement a class, you are promising to provide those getters/setters.
// You do NOT inherit the field's storage or value.

class A {
  final String val = "Value from A";
}

class B {
  final String val = "Value from B";
}

// C extends A: It INHERITS the implementation of 'val' from A.
// C implements B: It PROMISES to have a 'val' getter matching B's signature.
//
// Since C inherits 'val' from A, that inherited getter satisfies the promise made to B!
// So, C.val will return "Value from A".

class C extends A implements B {
  // No code needed! 
  // 'val' from A satisfies the interface requirement of B.
}

// What if we didn't extend A?
class D implements B {
  // Error: Missing concrete implementation of 'getter val'.
  // We must override it manually because we didn't inherit it.
  @override
  String get val => "Value from D"; 
}

// ---------------------------------------------------------------------------
// 4. Abstract vs Interface vs Abstract Interface
// ---------------------------------------------------------------------------

// A. ABSTRACT: "I have some logic to share, but I'm incomplete."
// - Can be extended (to reuse code).
// - Can be implemented (to ignore code and just take the contract).
abstract class BaseUpdater {
  void update() {
    print('Performing shared update logic...');
  }
  void onComplete(); // Subclass MUST define this.
}

// B. INTERFACE: "I am a full class, but I don't want you to inherit my guts."
// - Can be instantiated.
// - CANNOT be extended (outside library).
// - Must be implemented.
interface class Tool {
  void run() => print('Tool running');
}

// C. ABSTRACT INTERFACE: "I am a pure contract. No code, no instances."
// - Cannot be instantiated.
// - CANNOT be extended.
// - Must be implemented.
// - This is the cleanest way to define a "Contract".
abstract interface class Repository {
  void fetch();
}

// ---------------------------------------------------------------------------
// 5. Base Class: "I insist you inherit my guts."
// ---------------------------------------------------------------------------
// - CANNOT be implemented.
// - Must be extended.
// - This ensures your constructor logic always runs.
base class SecureConnection {
  SecureConnection() {
    print('Initializing secure handshake...');
  }
}

// ---------------------------------------------------------------------------
// 6. Sealed Class: "I have a fixed number of variations."
// ---------------------------------------------------------------------------
// Think of 'sealed' as a "Super Enum".
//
// - It is ABSTRACT: You cannot create a 'Shape' directly.
// - It is EXHAUSTIVE: The compiler knows EVERY possible subclass.
// - It is RESTRICTED: All subclasses must be in the SAME FILE (or library).
//
// Why use it?
// It forces you to handle every possible case in a switch statement.
// If you add a new subclass later, the compiler will ERROR in your switch
// statements, reminding you to handle the new case.

sealed class Shape {}

class Square extends Shape {
  final double side;
  Square(this.side);
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}

// If we add 'Triangle' here later, 'calculateArea' will show an error!
// class Triangle extends Shape {}

double calculateArea(Shape shape) {
  // Dart knows 'Shape' can ONLY be Square or Circle.
  // We don't need a 'default' case.
  return switch (shape) {
    Square(side: var s) => s * s,
    Circle(radius: var r) => 3.14 * r * r,
  };
}

// --- Use Case 2: State Management (like in Bloc/Riverpod) ---
// This is the most common real-world use case.
// You define a fixed set of states your UI can be in.

sealed class UiState {}

class Initial extends UiState {}
class Loading extends UiState {}
class Success extends UiState {
  final List<String> data;
  Success(this.data);
}
class Error extends UiState {
  final String message;
  Error(this.message);
}

String buildUi(UiState state) {
  // The compiler guarantees we handled Initial, Loading, Success, and Error.
  return switch (state) {
    Initial() => 'Welcome! Click to load.',
    Loading() => 'Spinner...',
    Success(data: var d) => 'Got ${d.length} items',
    Error(message: var m) => 'Oops: $m',
  };
}

void main() {
  // 1. Using the interface class directly (Implementation is NOT wasted here)
  var logger = MockLogger();
  logger.log('Hello');

  // 2. Using the implementation (Contract is fulfilled)
  MockLogger custom = CustomLogger();
  custom.log('World');

  // 3. Variable Inheritance Example
  var c = C();
  print('C.val: ${c.val}'); // Prints: Value from A

  // 4. Contract example
  Storage storage = FileStorage(); // Assuming FileStorage exists from previous example
  storage.save('Data');
  
  // 5. Sealed Class Example
  print('Area of square: ${calculateArea(Square(4))}');
  print('UI State: ${buildUi(Success(['A', 'B']))}');
}

class FileStorage implements Storage {
  @override
  void save(String data) => print('Saving $data to disk');
}
