# Dart Class Modifiers Reference

This table shows the valid combinations of class modifiers in Dart.

| Modifier Combination | Construct? | Extend? | Implement? | Mix in? | Exhaustive? |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **(No modifier)** | Yes | Yes | Yes | No | No |
| **`abstract`** | No | Yes | Yes | No | No |
| **`base`** | Yes | Yes | No | No | No |
| **`interface`** | Yes | No | Yes | No | No |
| **`final`** | Yes | No | No | No | No |
| **`sealed`** | No | No | No | No | Yes |
| **`abstract base`** | No | Yes | No | No | No |
| **`abstract interface`** | No | No | Yes | No | No |
| **`abstract final`** | No | No | No | No | No |
| **`mixin`** | No | No | Yes | Yes | No |
| **`base mixin`** | No | No | No | Yes | No |
| **`abstract mixin`** | No | No | Yes | Yes | No |
| **`abstract base mixin`** | No | No | No | Yes | No |
| **`mixin class`** | Yes | Yes | Yes | Yes | No |
| **`base mixin class`** | Yes | Yes | No | Yes | No |
| **`abstract mixin class`** | No | Yes | Yes | Yes | No |
| **`abstract base mixin class`** | No | Yes | No | Yes | No |

## Key Definitions

*   **Construct**: Can you create an instance? (`new Class()`)
*   **Extend**: Can you create a subclass? (`class Sub extends Class`)
*   **Implement**: Can you implement the interface? (`class Sub implements Class`)
*   **Mix in**: Can you use it as a mixin? (`class Sub with Class`)
*   **Exhaustive**: Does the compiler know all possible subclasses? (Useful for `switch`)

## Notes

*   **`sealed`** classes are implicitly `abstract`.
*   **`mixin`** declarations define a mixin that can be used with `with`.
*   **`mixin class`** defines a class that is usable as both a regular class and a mixin.
*   **`base`** guarantees that the class constructor is called, enforcing inheritance.
*   **`interface`** guarantees that the class implementation is hidden/ignored when implemented, enforcing a contract.
