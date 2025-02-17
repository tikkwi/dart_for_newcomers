### Do name types using `UpperCamelCase`
Classes, enum types, typedefs, name extensions, and type parameters should capitalize the first letter of each word (including the first word), and use no separators.
</br>
```
class SliderMenu {
    ...
}

typedef Predicate<T> = bool Function(T value);

class Foo {
  const Foo([Object? arg]);
}

@Foo(anArg)
class A {
   ...
}

extension MyFancyList<T> on List<T> {
   ...
}
```

### Do packages, directories, and source files using `lowercase_with_underscore`

``` 
my_package
└─ lib
   └─ file_system.dart
   └─ slider_menu.dart
```

### Do other names with `lowerCamelCase`
Class members, constant names, top-level definitions, variables, parameters, and named parameters should capitalize the first letter of each word except the first word, and use no separators.
``` 
var count = 3;

HttpRequest httpRequest;

void align(bool clearItems) {
  // ...
}

const pi = 3.14;
const defaultTimeout = 1000;
final urlScheme = RegExp('^([a-z]+):');

class Dice {
  static final numberGenerator = Random();
}
```

### PREFER using _, __, etc. for unused callback parameters
>thanks to the latest dart, we no longer need __, ___ for unused multi args, can use just singe _ for all args 

``` 
futureOfVoid.then((_) {
  print('Operation complete.');
});
```

### DON'T use a leading underscore for identifiers that aren't private

### Import ordering
- DO place `dart:` imports before other imports
- DO place `package:` imports before relative imports
- DO specify `exports` in a separate section after all imports

