import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';
import '../../providers/dio_provider.dart';

part 'users_providers.g.dart';

@riverpod
Future<List<User>> userList(Ref ref) async {
  ref.onDispose(() {
    print('[userListProvider] disposed');
  });
  final response = await ref.watch(dioProvider).get('/users');
  final List userList = response.data;
  final users = [for (final user in userList) User.fromJson(user)];
  return users;
}

// can use autoDispose or not, depending on whether you want to cache the data or not
// final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
//   ref.onDispose(() {
//     print('[userListProvider] disposed');
//   });
//   final response = await ref.watch(dioProvider).get('/users');
//   // Simulate an error
//   // throw 'Fail to fetch user list';
//   final List userList = response.data;
//   // print('userList: $userList');
//   final users = [for (final user in userList) User.fromJson(user)];
//   return users;
// });

// family modifier allows us to pass parameters to the provider
// 30. FutureProvider - userDetailProvider, UserDetailPage, code generation
// can use autoDispose or not, depending on whether you want to cache the data or not
// final userDetailProvider = FutureProvider.family<User, int>((ref, id) async {
//   ref.onDispose(() {
//     print('[userDetailProvider($id)] disposed');
//   });
//   final response = await ref.watch(dioProvider).get('/users/$id');
//   final user = User.fromJson(response.data);
//   return user;
// });

// @riverpod
// Future<User> userDetail(UserDetail ref, int id) async {
//   ref.onDispose(() {
//     print('[userDetailProvider($id)] disposed');
//   });
//   final response = await ref.watch(dioProvider).get('/users/$id');
//   final user = User.fromJson(response.data);
//   return user;
// }
