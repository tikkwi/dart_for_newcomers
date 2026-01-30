// Error Handling in Dart

// Dart uses exceptions for error handling.
// Key concepts: try, catch, finally, throw, custom exceptions.

void main() {
  // Basic try-catch
  try {
    int result = 10 ~/ 0; // Integer division by zero throws
    print('Result: $result');
  } catch (e) {
    print('Caught error: $e');
  }

  // Catching specific exception types
  try {
    throw FormatException('Invalid format');
  } on FormatException catch (e) {
    print('FormatException caught: $e');
  } on Exception catch (e) {
    print('General Exception: $e');
  }

  // Finally block always executes
  try {
    print('Trying something...');
    throw 'An error';
  } catch (e) {
    print('Caught: $e');
  } finally {
    print('Finally block executed');
  }

  // Throwing exceptions
  try {
    checkAge(-5);
  } catch (e) {
    print('Thrown exception: $e');
  }

  // Custom exception
  try {
    validateUser('invalid');
  } catch (e) {
    print('Custom exception: $e');
  }
}

// Function that throws an exception
void checkAge(int age) {
  if (age < 0) {
    throw ArgumentError('Age cannot be negative');
  }
  print('Age is valid: $age');
}

// Custom exception class
class InvalidUserException implements Exception {
  final String message;
  InvalidUserException(this.message);

  @override
  String toString() => 'InvalidUserException: $message';
}

// Function using custom exception
void validateUser(String username) {
  if (username != 'admin') {
    throw InvalidUserException('User $username is not authorized');
  }
  print('User validated: $username');
}
