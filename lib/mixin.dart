// Mixins in Dart
//
// Mixins are a way of reusing a class's code in multiple class hierarchies.
// They provide a way to "mix in" functionality to a class without using inheritance.
//
// Key characteristics:
// 1. Defined using the 'mixin' keyword.
// 2. Cannot be instantiated directly.
// 3. Can have methods and properties.
// 4. Can use 'on' to restrict which classes can use the mixin.

// ---------------------------------------------------------------------------
// 1. Basic Mixin Usage
// ---------------------------------------------------------------------------

mixin Musical {
  bool canPlayInstrument = true;

  void entertain() {
    if (canPlayInstrument) {
      print('Playing music!');
    } else {
      print('Humming a tune...');
    }
  }
}

mixin Aggressive {
  void attack() => print('Attacking!');
}

class Performer {
  void perform() => print('Performing...');
}

// A class can mix in multiple mixins using 'with'.
class Musician extends Performer with Musical {
  void showTime() {
    perform();
    entertain();
  }
}

// ---------------------------------------------------------------------------
// 2. Restricting Mixins with 'on'
// ---------------------------------------------------------------------------
// The 'on' keyword restricts which classes can use this mixin.
// It also allows the mixin to call methods from that superclass.

class Animal {
  void breathe() => print('Breathing...');
}

// This mixin can ONLY be used on classes that extend Animal.
mixin Flyer on Animal {
  void fly() {
    // We can call breathe() because we know 'this' is an Animal.
    breathe(); 
    print('Flying high!');
  }
}

class Bird extends Animal with Flyer {}

// Error: 'Car' does not extend 'Animal', so it cannot use 'Flyer'.
// class Car with Flyer {} 

// ---------------------------------------------------------------------------
// 3. Mixin vs Interface vs Abstract Class
// ---------------------------------------------------------------------------
// - Abstract Class: "Is-a" relationship. Use for shared base logic in a hierarchy.
// - Interface: "Can-do" relationship (Contract). Use for defining API boundaries.
// - Mixin: "Has-a" capability. Use for sharing code across unrelated classes.

void main() {
  print('--- Basic Mixin ---');
  var musician = Musician();
  musician.showTime();
  // musician.entertain(); // Available because of 'with Musical'

  print('\n--- Restricted Mixin ---');
  var bird = Bird();
  bird.fly(); // Calls breathe() internally
}
