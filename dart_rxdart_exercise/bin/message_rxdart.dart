import 'package:rxdart/rxdart.dart';

void main() {
  // A stream of chat messages
  final messageStream = BehaviorSubject<String>();

  // Subscriber 1: UI component that shows the message
  messageStream.listen((msg) {
    print('UI: New message -> "$msg"');
  });

  // Subscriber 2: Another component (say, a logger or analytics)
  messageStream.listen((msg) {
    print('Logger: Received message -> "$msg"');
  });

  // Simulate incoming messages
  messageStream.add('Hello, world!');
  messageStream.add('RxDart is pretty cool 😎');

  // Output:
  // UI: New message -> "Hello, world!"
  // Logger: Received message -> "Hello, world!"
  // UI: New message -> "RxDart is pretty cool 😎"
  // Logger: Received message -> "RxDart is pretty cool 😎"
}
