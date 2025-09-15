
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// NotifierProvider family example
// A NotifierFamily is a class that extends FamilyNotifier<T, A> where T is the state type and A is the argument type

// ==========================================================================
// class CounterFamily extends FamilyNotifier<int, int> {
//   @override
//   int build(int arg) {
//     ref.onDispose(() {
//       print('[CounterFamily] disposed');
//     });
//     return arg;
//   }

//   void increment() {
//     state++;
//   }
// }

// // Constructor tear-off
// final counterFamilyProvider =
//     NotifierProvider.family<CounterFamily, int, int>(CounterFamily.new);
// ==========================================================================


// NotifierProvider autodispose family example
// ======================================================================================
// class CounterFamily extends AutoDisposeFamilyNotifier<int, int> {
//   @override
//   int build(int arg) {
//     ref.onDispose(() {
//       print('[CounterFamily] disposed');
//     });
//     return arg;
//   }

//   void increment() {
//     state++;
//   }
// }

// // Constructor tear-off
// final counterFamilyProvider =
//     NotifierProvider.autoDispose.family<CounterFamily, int, int>(CounterFamily.new);
// ======================================================================================


// NotifierProvider autodispose family generator way example

part 'counter_provider_notifer_family.g.dart';

@riverpod
class CounterFamilyGen extends _$CounterFamilyGen {
  @override
  int build(int initialValue) {
    ref.onDispose(() {
      print('[CounterFamilyGen] disposed');
    });
    return initialValue;
  }

  void increment() {
    state++;
  }
}
