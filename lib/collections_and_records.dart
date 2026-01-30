// Collections and Records in Dart

// Records are immutable data structures that allow grouping multiple values.
// They can have positional or named fields.

void main() {
  // Creating a record with named fields
  var person = (name: 'Alice', age: 25);
  print('Person: ${person.name}, Age: ${person.age}');

  // Record with positional fields
  var point = (10, 20);
  print('Point: x=${point.$1}, y=${point.$2}');

  // Destructuring a record
  var (:name, :age) = person;
  print('Destructured: $name is $age years old');

  // Collections: Lists, Sets, Maps

  // List - ordered collection of items
  var fruits = ['apple', 'banana', 'cherry'];
  print('Fruits: $fruits');

  // Set - unordered collection of unique items
  var uniqueNumbers = {1, 2, 3, 1}; // Duplicates are ignored
  print('Unique numbers: $uniqueNumbers');

  // Map - key-value pairs
  var capitals = {'USA': 'Washington', 'France': 'Paris'};
  print('Capitals: $capitals');

  // Collection if - conditional inclusion of items
  bool includeExtra = true;
  var items = [
    'first',
    if (includeExtra) 'extra item',
    'last',
  ];
  print('Items with condition: $items');

  // Collection for - transforming collections
  var numbers = [1, 2, 3, 4];
  var doubled = [for (var num in numbers) num * 2];
  print('Doubled numbers: $doubled');

  // Spread operator - expanding collections
  var moreFruits = ['orange', ...fruits, 'grape'];
  print('More fruits: $moreFruits');

  // For maps
  var moreCapitals = {
    'Germany': 'Berlin',
    ...capitals,
    'Italy': 'Rome',
  };
  print('More capitals: $moreCapitals');

  // Set with spreads and conditions
  var combinedSet = {
    1, 2,
    if (includeExtra) 3,
    ...{4, 5},
  };
  print('Combined set: $combinedSet');
}
