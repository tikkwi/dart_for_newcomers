// Generators in Dart

import 'dart:async';

// ---------------------------------------------------------------------------
// 1. Synchronous Generator (sync*) - The "Ping Pong" Execution
// ---------------------------------------------------------------------------

// Q: "Look like double processing?"
// A: No. It is "Interleaved" processing.
//    The code jumps back and forth between the Generator (INSIDE) and the Main Loop (OUTSIDE).
//    It's like a game of Ping Pong.

Iterable<int> generateId(int max) sync* {
  print('    [GEN] INSIDE: Start');
  for (int i = 1; i <= max; i++) {
    print('    [GEN] INSIDE: Computing $i');
    yield i; // <--- PAUSE HERE! Pass ball to Main.
    print('    [GEN] INSIDE: Resuming after yielding $i');
  }
  print('    [GEN] INSIDE: Done');
}

// ---------------------------------------------------------------------------
// 2. Recursive Generator (yield*)
// ---------------------------------------------------------------------------

// Q: "Why use generic (List<dynamic>)?"
// A: Because the list contains mixed types: Integers AND other Lists.
//    [1, [2, 3]] -> Contains '1' (int) and '[2, 3]' (List).
//    So the list type must be dynamic or Object.

// Q: "Why can also do without?"
// A: You CAN do it without generators, but it uses more memory.
//    See 'flattenStandard' below. It creates a new list at every step.
//    The generator version 'flattenLazy' just streams values one by one.

// Option A: The Generator Way (Memory Efficient)
Iterable<int> flattenLazy(List<dynamic> list) sync* {
  for (var element in list) {
    if (element is List) {
      // yield* is a shortcut for: "Loop through this sub-list and yield everything"
      yield* flattenLazy(element); 
    } else {
      yield element as int;
    }
  }
}

// Option B: The Standard Way (Eager / Uses more memory)
List<int> flattenStandard(List<dynamic> list) {
  var result = <int>[]; // Allocates memory for a list
  for (var element in list) {
    if (element is List) {
      result.addAll(flattenStandard(element)); // Allocates MORE memory for sub-results
    } else {
      result.add(element as int);
    }
  }
  return result;
}

// ---------------------------------------------------------------------------
// 3. Asynchronous Generator (async*) - Streams
// ---------------------------------------------------------------------------
// Returns a Stream<T>.
// Used when values are produced over time (e.g., Timer, Network, File I/O).

// Use Case: Countdown Timer
// Emits a value every second. This cannot be done with a simple List or Iterable
// because it involves time delays.
Stream<int> countdown(int from) async* {
  for (int i = from; i >= 0; i--) {
    await Future.delayed(Duration(seconds: 1)); // Simulate work/delay
    yield i;
  }
}

// Use Case: Paginated Data Fetching
// Imagine fetching data from an API page by page.
// The consumer (listener) gets items one by one as they arrive,
// without waiting for ALL pages to load.
Stream<String> fetchPaginatedData() async* {
  for (int page = 1; page <= 3; page++) {
    print('  [Network] Fetching page $page...');
    await Future.delayed(Duration(milliseconds: 500)); // Simulate network request
    
    // Yielding multiple items from this "page"
    yield 'Item A (Page $page)';
    yield 'Item B (Page $page)';
  }
}

// ---------------------------------------------------------------------------
// Main Execution
// ---------------------------------------------------------------------------

void main() async {
  print('--- 1. Understanding the Flow (Ping Pong) ---');
  
  print('[MAIN] Calling function...');
  // NOTE: If you add .toList() here, it runs EVERYTHING immediately!
  // final ids = generateId(3).toList(); // <--- This would cause "Double Processing" look
  final ids = generateId(3); 
  print('[MAIN] Function returned iterable. (Notice NO logs from [GEN] yet)');
  
  print('[MAIN] Starting loop...');
  for (var id in ids) {
    print('[MAIN] OUTSIDE: Got $id'); // <--- Pass ball back to Generator
  }
  print('[MAIN] Loop finished.');


  print('\n--- 2. Recursive Example ---');
  var nested = [1, [2, 3], [[4, 5], 6]];
  
  print('Lazy Flatten (Generator):');
  // This doesn't build a giant list in memory. It finds numbers one by one.
  for (var num in flattenLazy(nested)) {
    print(num);
  }

  print('\nStandard Flatten (List):');
  // This builds the FULL list [1, 2, 3, 4, 5, 6] in memory before printing.
  var fullList = flattenStandard(nested); 
  print(fullList);

  // --- Async Generator Example ---
  print('\n--- 3. Async Generator (Countdown) ---');
  // await for loop handles the stream subscription automatically
  await for (var tick in countdown(3)) {
    print('T-minus $tick');
  }
  print('Blast off!');

  print('\n--- 4. Async Generator (Data Fetching) ---');
  // We can also listen manually
  final stream = fetchPaginatedData();
  await stream.forEach((item) {
    print('Processed: $item');
  });
}
