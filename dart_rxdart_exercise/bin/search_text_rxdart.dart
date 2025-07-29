import 'package:rxdart/rxdart.dart';

void main() async {
  // A BehaviorSubject to act as our search text input stream
  final searchText = BehaviorSubject<String>();

  // Set up the reactive search pipeline:
  searchText.stream
      .debounceTime(Duration(milliseconds: 300)) // Wait 300ms of inactivity
      .where((query) => query.isNotEmpty) // Only continue if query is not empty
      .listen((query) {
        // This is where we'd normally call an API. For now, just print.
        print('🔍 Searching for "$query"');
      });

  // Simulate the user typing "hel" -> "hell" -> "hello"
  searchText.add('hel');
  await Future.delayed(Duration(milliseconds: 100));
  searchText.add('hell');
  await Future.delayed(Duration(milliseconds: 100));
  searchText.add('hello');
  // Now wait a bit longer than 300ms to let the debounce timer complete
  await Future.delayed(Duration(milliseconds: 500));

  // Expected output (after ~300ms of pause once typing stops):
  // 🔍 Searching for "hello"
}
