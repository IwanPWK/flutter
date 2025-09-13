import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';
import '../../providers/dio_provider.dart';

final userListProvider = FutureProvider<List<User>>((ref) async {
  ref.onDispose(() {
    print('[userListProvider] disposed');
  });
  final response = await ref.watch(dioProvider).get('/users');
  // Simulate an error
  // throw 'Fail to fetch user list';
  final List userList = response.data;
  print('userList: $userList');
  final users = [for (final user in userList) User.fromJson(user)];
  return users;
});
