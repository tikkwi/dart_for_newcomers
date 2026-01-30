// Metadata (Annotations) Cheatsheet & Demo
//
// Metadata gives additional information about your code to the compiler,
// tools, or runtime. It always starts with the '@' character.

import 'dart:mirrors';

// ===========================================================================
// 1. WHAT IS METADATA? (Side Effect vs Decorator)
// ===========================================================================
// Q: "Is metadata side-effect only? Can it manipulate the target?"
// A: YES, in Dart, metadata is PASSIVE.
//    - It is just "data attached to code".
//    - It CANNOT wrap, modify, or replace the function it sits on (unlike JS/Python decorators).
//    - It does NOTHING unless an external tool (Compiler, Linter, Runtime) reads it.
//
//    JS Decorator:   @Log func() { ... }  -> Wraps func() automatically.
//    Dart Metadata:  @Log func() { ... }  -> Just sits there. You must write code to find it.

// ===========================================================================
// 2. BUILT-IN ANNOTATIONS (The Essentials)
// ===========================================================================

class Base {
  void method() {}
}

class Child extends Base {
  // @override
  // Tells compiler this method replaces one from the parent.
  // Benefit: Catches typos (e.g., if parent method is renamed, this errors).
  @override
  void method() => print('Child method');

  // @Deprecated
  // Warns users that this feature will be removed.
  // Benefit: IDEs will strike-through usages: child.oldMethod();
  @Deprecated('Use method() instead')
  void oldMethod() => print('Old method');
}

// ===========================================================================
// 3. DEFINING CUSTOM ANNOTATIONS
// ===========================================================================
// An annotation is simply a class with a 'const' constructor.

// Example A: Simple Tag
class Test {
  const Test();
}

// Example B: Annotation with Data
class Route {
  final String path;
  final String method;
  const Route(this.path, {this.method = 'GET'});
}

// Example C: Meta-data for developers
class Todo {
  final String who;
  final String what;
  const Todo(this.who, this.what);
}

// ===========================================================================
// 4. APPLYING ANNOTATIONS
// ===========================================================================

@Todo('DevTeam', 'Refactor this class later')
class ApiController {
  
  @Route('/users')
  void getUsers() => print('-> 200 OK: Returning list of users...');

  @Route('/users', method: 'POST')
  void createUser() => print('-> 201 Created: User added.');

  @Route('/health')
  void healthCheck() => print('-> 200 OK: System operational.');
  
  // This method has NO annotation, so the framework should ignore it.
  void internalHelper() => print('Internal helper (not a route)');
}

// ===========================================================================
// 5. REAL-WORLD DEMO: MINI WEB FRAMEWORK (Runtime Reflection)
// ===========================================================================
// Since annotations are passive, we need to write a "Processor" to make them useful.
//
// Below is a mini-framework that finds methods annotated with @Route
// and executes them based on a simulated request.

void handleRequest(Object controller, String path, String method) {
  print('\n[Server] Incoming Request: $method $path');
  
  // 1. Reflect on the controller object to inspect its structure
  final mirror = reflect(controller);
  bool found = false;

  // 2. Iterate over all methods in the class
  for (var func in mirror.type.instanceMembers.values) {
    // 3. Check metadata (annotations) on each method
    for (var annotation in func.metadata) {
      // Check if the annotation is of type 'Route'
      if (annotation.reflectee is Route) {
        var route = annotation.reflectee as Route;
        
        // 4. Match logic: Does the annotation match the request?
        if (route.path == path && route.method == method) {
          print('[Server] Match found! Invoking method: ${MirrorSystem.getName(func.simpleName)}');
          mirror.invoke(func.simpleName, []); // Execute the method
          found = true;
        }
      }
    }
  }

  if (!found) {
    print('[Server] 404 Not Found: No route matches this request.');
  }
}

// ===========================================================================
// MAIN EXECUTION
// ===========================================================================

void main() {
  // 1. Built-in Annotation Demo
  print('--- Built-in Annotations ---');
  final c = Child();
  c.method();
  // c.oldMethod(); // Uncomment to see deprecation warning in IDE

  // 2. Custom Annotation Demo (Mini Router)
  print('\n--- Custom Annotation Demo (Mini Router) ---');
  final api = ApiController();

  // Simulate incoming HTTP requests
  handleRequest(api, '/users', 'GET');   // Should call getUsers
  handleRequest(api, '/users', 'POST');  // Should call createUser
  handleRequest(api, '/health', 'GET');  // Should call healthCheck
  handleRequest(api, '/admin', 'GET');   // Should be 404
}
