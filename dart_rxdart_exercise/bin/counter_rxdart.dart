import 'package:rxdart/rxdart.dart';

void main() {
  // Create a BehaviorSubject with an initial value (seeded value) of 0
  final counter = BehaviorSubject<int>.seeded(0);

  // Subscribe to the counter stream to print values whenever it changes
  counter.listen((value) {
    print('Counter value: $value');
  });

  // The moment we subscribed, BehaviorSubject emitted the initial value:
  // Output: "Counter value: 0"

  // Now, let's simulate some increments to the counter:
  counter.add(1);
  counter.add(2);
  counter.add(3);

  // Each time we call add(), the new value is emitted, and our listener prints it:
  // Output: "Counter value: 1"
  //         "Counter value: 2"
  //         "Counter value: 3"
}
