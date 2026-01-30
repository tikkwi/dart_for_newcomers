// External Functions in Dart

// External functions are declared but implemented outside Dart,
// typically in native code using FFI (Foreign Function Interface) or JavaScript (on the web).
// Use the 'external' keyword to declare them.

import 'dart:ffi' as ffi;

// --- 1. Native (C/C++) Interop Example ---

// Example: Declaring an external function
// This would be implemented in C or another language
external int nativeAdd(int a, int b);

// External in a class
class MathUtils {
  external static int multiply(int a, int b);
  external int divide(int a, int b);
}

// Working FFI example: Calling a C function from libc
// On macOS, libc functions are in libSystem.dylib
// We'll call the 'abs' function which returns the absolute value of an int

// First, declare the native function signature
typedef AbsC = ffi.Int32 Function(ffi.Int32);
typedef AbsDart = int Function(int);

// Load the library
// Note: This runs on the Dart VM (command line), not in the browser.
void runFfiExample() {
  try {
    final lib = ffi.DynamicLibrary.open('/usr/lib/libSystem.dylib');
    final absPtr = lib.lookup<ffi.NativeFunction<AbsC>>('abs');
    final abs = absPtr.asFunction<AbsDart>();

    int result = abs(-42);
    print('FFI: abs(-42) = $result');
  } catch (e) {
    print('FFI Example skipped: $e');
  }
}

// --- 2. JavaScript Interop Example (Web) ---

// External functions are heavily used in web development to interact with JavaScript.
// Since we cannot run web code directly in this console app, see 'lib/js_interop.dart'
// and 'web/js_functions.js' for a full working example.

// Conceptual example of what it looks like:
/*
import 'dart:js_interop';

@JS()
external void showJsAlert(JSString message);

@JS()
external int calculateSum(int a, int b);
*/

void main() {
  print('External functions are declared with \'external\' keyword.');
  print('They are implemented in native code (FFI) or JavaScript (Web).');

  // Run the FFI example
  runFfiExample();

  print('\nFor JS Interop example, please check:');
  print('- lib/js_interop.dart');
  print('- web/js_functions.js');
  print('- web/index.html');
}
