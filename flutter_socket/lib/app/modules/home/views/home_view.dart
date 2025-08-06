import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../models/model.dart';
import '../../../routes/app_pages.dart';
import '../../chat/views/chat_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    print('cek nilai Get.arguments ${Get.arguments}');
    final Map<String, dynamic> args = Get.arguments;
    final List<ChatModel> chatModels = args['chatModels'];
    final ChatModel sourceChat = args['sourceChat'];
    return Scaffold(
      appBar: AppBar(title: Text('HomeView'), centerTitle: true),
      body: ListView.builder(
        itemCount: chatModels.length,
        itemBuilder:
            (contex, index) => InkWell(
              onTap: () {
                final ChatModel chatModel = chatModels[index];
                print('cek chatModel $chatModel');
                print('cek sourceChat $sourceChat');
                // print(sourceChat!.id.toString());
                // print(sourceChat!.name.toString());
                Get.toNamed(
                  Routes.chat,
                  arguments: {'chatModel': chatModel, 'sourceChat': sourceChat},
                );
              },
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blueGrey,
                      child: SvgPicture.asset(
                        chatModels[index].isGroup
                            ? "assets/groups.svg"
                            : "assets/person.svg",
                        color: Colors.white,
                        height: 36,
                        width: 36,
                      ),
                    ),
                    title: Text(
                      chatModels[index].name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Icon(Icons.done_all),
                        SizedBox(width: 3),
                        Text(
                          chatModels[index].currentMessage,
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    trailing: Text(chatModels[index].time),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 80),
                    child: Divider(thickness: 1),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
