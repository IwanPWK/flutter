import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// NotifierProvider example
// A Notifier is a class that extends Notifier<T> where T is the state type

// =========================================================================
// class Counter extends Notifier<int> {
//   @override
//   int build() {
//     ref.onDispose(() {
//       print('[counterProvider] disposed');
//     });
//     return 0;
//   }

//   void increment() {
//     state++;
//   }
// }

// // Constructor tear-off
// final counterProvider =
//     NotifierProvider<Counter, int>(Counter.new);

// Original way
// final counterProvider = NotifierProvider<Counter, int>(){
//   return Counter();
// });

// =========================================================================


// Usage: we can watch the counterProvider in a ConsumerWidget (watch for state changes)
// as an argument to ref.watch

// === final counter  = ref.watch(counterProvider); ===

// We can also read the counterProvider in a ConsumerWidget (do not watch for state changes)
// or want to call a method on the Notifier instance itself
// as an argument to ref.read

// === final counterNotifier = ref.read(counterProvider.notifier).increment(); ===


// NotifierProvider autodispose example

// ======================================================================
class Counter extends AutoDisposeNotifier<int> {
  @override
  int build() {
    ref.onDispose(() {
      print('[counterProvider] disposed');
    });
    return 0;
  }

  void increment() {
    state++;
  }
}

// Constructor tear-off
final counterProvider =
    NotifierProvider.autoDispose<Counter, int>(Counter.new);
// ======================================================================

