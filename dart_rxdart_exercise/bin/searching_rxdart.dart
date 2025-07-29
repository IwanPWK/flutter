import 'package:rxdart/rxdart.dart';

void main() async {
  // Our fake database of fruits
  final List<String> allFruits = [
    'apple',
    'banana',
    'orange',
    'grape',
    'pineapple',
    'blueberry',
  ];

  // Subject that will emit search queries (what the user types)
  final querySubject = BehaviorSubject<String>();

  // Stream pipeline: take queries, wait for a pause, filter empty, then map to search results
  querySubject.stream
      .debounceTime(Duration(milliseconds: 300))
      .where((q) => q.isNotEmpty)
      .map((query) {
        // Simulate an API search by filtering the list of fruits
        final results =
            allFruits
                .where((fruit) => fruit.contains(query.toLowerCase()))
                .toList();
        return results;
      })
      .listen((results) {
        print('Search results: $results');
      });

  // Simulate the user searching for "ap"
  querySubject.add('ap');
  await Future.delayed(Duration(milliseconds: 100));
  querySubject.add('app');
  await Future.delayed(Duration(milliseconds: 500));
  querySubject.add('ap'); // user cleared and typed 'ap' again
  await Future.delayed(Duration(milliseconds: 100));
  querySubject.add('apple');
  await Future.delayed(Duration(milliseconds: 500));
  querySubject.add('ap'); // user cleared and typed 'ap' again

  // Expected output:
  // Search results: [apple, grape, pineapple]   (after user stopped typing "app" -> actually "app" yields those containing "app")
  // Search results: [apple, grape, pineapple]   (for "apple", same results here because "apple" fully contains "app")
  // Search results: [apple, grape, pineapple]   (after typing "ap" and stopping at that, it yields fruits containing "ap")
}
