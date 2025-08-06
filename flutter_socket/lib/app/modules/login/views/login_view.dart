import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../home/views/home_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    print('controller.chatmodels.length ${controller.chatmodels.length}');
    return Scaffold(
      appBar: AppBar(title: Text('LoginView'), centerTitle: true),
      body: ListView.builder(
        itemCount: controller.chatmodels.length,
        itemBuilder:
            (contex, index) => InkWell(
              onTap: () {
                controller.sourceChat = controller.chatmodels.removeAt(index);
                print(
                  'cek nilai ${controller.sourceChat} ${controller.chatmodels}',
                );
                Get.toNamed(
                  Routes.home,
                  arguments: {
                    'chatModels': controller.chatmodels,
                    'sourceChat': controller.sourceChat,
                  },
                );
              },
              child: ListTile(
                leading: CircleAvatar(
                  radius: 23,
                  backgroundColor: Color(0xFF25D366),
                  child: Icon(Icons.person, size: 26, color: Colors.white),
                ),
                title: Text(
                  controller.chatmodels[index].name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
      ),
    );
  }
}
