enum Vehicle {
  car(tires: 4, passengers: 4, carbon: 600),
  bus(tires: 6, passengers: 15, carbon: 1200),
  bicycle(tires: 2, passengers: 1, carbon: 0);

  const Vehicle({
    required this.tires,
    required this.passengers,
    required this.carbon,
  });

  final int tires;
  final int passengers;
  final int carbon;

  bool get isTwoWheel => this == Vehicle.bicycle;

  int get carbonFootPrint => (carbon * passengers).round();
}

enum Simple { car, bicycle, bus }

main() {
  const car = Vehicle.car;
  const bicycle = Vehicle.bicycle;
  print(
    "car is${car.isTwoWheel ? '' : 'no'} two wheels and has ${car.carbonFootPrint} carbon footprint ",
  );
  print(
    "bicycle is${bicycle.isTwoWheel ? '' : 'no'} two wheels and has ${bicycle.carbonFootPrint} carbon footprint ",
  );
}
