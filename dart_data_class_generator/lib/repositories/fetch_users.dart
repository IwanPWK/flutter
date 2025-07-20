import 'package:dio/dio.dart';

import '../models/user.dart';

Future<List<User>> fetchUsers() async {
  try {
    // await Future.delayed(const Duration(seconds: 1));
    final Response response = await Dio().get(
      'https://jsonplaceholder.typicode.com/users',
    );
    final List<dynamic> userList = response.data as List;
    print(userList[0]);
    final users = [for (final user in userList) User.fromMap(user)];
    return users;
  } catch (e) {
    print(e);
    rethrow;
  }
}
