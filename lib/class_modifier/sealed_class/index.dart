// sealed class
// with sealed class we can restrict subclassing for outside of the same library
// (base restrict outside of package which normally mean can extends freely in the
// same project)
//

library;

part 'bus.dart';
part 'truck.dart';

sealed class Vehicle {
  final String name;

  const Vehicle(this.name);

  void move() => print("$name is moving");
}

// And with sealed class we can do pattern matching like this

String getVehicleType(Vehicle vehicle) {
  return switch (vehicle) {
    Bus() => 'bus',
    Truck() => 'truck',
  };
}

main() {
  const truck = Truck('volvo');
  truck.move();
  print("vehicle type is ${getVehicleType(truck)}");
}
