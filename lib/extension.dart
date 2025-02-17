//method extension
extension NumberParsing on String {
  int parseInt() => int.parse(this);

  void printMe() => print("here you go $this");
}

//
//extension type
//we use extension type for
//1. warp primitive type for better type safety
//2. encapsulate validation logic / constraint
//3. prevent unit confusion
//

//
// eg-1
// class User {
//   final String email;
//   User(this.email);
// }
//
// void main() {
//   var user = User("not_an_email"); // ❌ No validation
// }
//

extension type Email._(String data) {
  factory Email(String value) {
    if (!value.contains('@')) {
      throw ArgumentError('Invalid email: $value');
    }
    return Email._(value);
  }

  String get domain => data.split('@').last;
}

class User {
  final Email email;

  User(this.email);
}

//
// eg-2
// double distanceInMeters = 1000;
// double distanceInKilometers = 1;
//
// double totalDistance = distanceInMeters + distanceInKilometers; // ❌ Wrong unit mix-up!
// print(totalDistance); // 1001 (incorrect calculation)
//
//
//  the limitation of extension is that we can't do sth like that...
//  operator +(Object other) {
//    if (other is Meter) {
//      return Meter(data + other.data);
//    } else if (other is Kilometer) {
//      return Kilometer(kilometer + other.data); // Convert Meter to Kilometer
//    }
//    throw ArgumentError('Unsupported type');
//  }
// becz dart just treat extended type as wrapped primitive (which mean int here)
// so we'll get unexpected result, we can only achieve this by using class
//

extension type Meter(int data) {
  get kilometer => data / 1000;
}

extension type KiloMeter(int data) {
  get meter => data * 1000;
}

main() {
  const String num = '13';
  num.printMe();
  print(num.parseInt());

  //ext type eg-1
  final user = User(Email('ddd@example.com'));
  print(user.email.domain);

  //ext type eg-2
  final mt = Meter(1500);
  final km = KiloMeter(3);
  print(mt.data + km.meter);
}
