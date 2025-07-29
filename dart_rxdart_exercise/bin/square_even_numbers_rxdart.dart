import 'package:rxdart/rxdart.dart';

void main() {
  final numbers = BehaviorSubject<int>();

  numbers.stream
      .where((value) => value.isEven) // only even numbers pass
      .map((evenValue) => evenValue * evenValue) // square the even number
      .listen((result) {
        print('Received: $result');
      });

  // Add some numbers to the stream
  numbers.add(1);
  numbers.add(2);
  numbers.add(3);
  numbers.add(4);
  numbers.add(5);
  numbers.add(6);

  // Output will be:
  // Received: 4   (for input 2 -> 2*2)
  // Received: 16  (for input 4 -> 4*4)
  // Received: 36  (for input 6 -> 6*6)
}
