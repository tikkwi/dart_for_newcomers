// JS Interop in Dart (Web)
//
// To run this:
// 1. Compile this file: dart compile js -o web/main.dart.js lib/js_interop.dart
// 2. Open web/index.html in a browser.

import 'dart:js_interop';

// 1. Declare external functions that match the JavaScript functions
// defined in web/js_functions.js.
// The @JS annotation binds the Dart function to the JS function of the same name.

@JS()
external void showJsAlert(JSString message);

@JS()
external int calculateSum(int a, int b);

// 2. You can also interact with built-in browser objects like 'console'
@JS('console.log')
external void consoleLog(JSAny? message);

void main() {
  consoleLog('Dart started!'.toJS);

  // Call the external JS function
  // We need to convert Dart String to JSString using .toJS
  showJsAlert('Hello from Dart!'.toJS);

  // Call the calculation function
  // Primitives like int, double, bool are automatically converted
  int result = calculateSum(10, 20);
  
  consoleLog('Result from JS calculateSum: $result'.toJS);
}
