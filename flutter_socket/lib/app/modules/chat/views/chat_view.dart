import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../models/model.dart';
import '../../widgets/own_message_card_widget.dart';
import '../../widgets/reply_card_widget.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  // List<ChatModel> chatmodels;
  // final ChatModel chatModel;
  // final ChatModel sourceChat;

  const ChatView({super.key});

  // final ChatController chatController = Get.put(
  //   ChatController(),
  // ); // Controller dependency injected

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    print('chat model ChatView ${args['chatModel']}');
    final ChatModel chatModel = args['chatModel'];
    final ChatModel sourceChat = args['sourceChat'];
    controller.connect(sourceChat.id);
    // print(sourceChat.id);
    // chatController.connect(sourceChat.id);

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/whatsapp_Back.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AppBar(
                leadingWidth: 70,
                titleSpacing: 0,
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back, size: 24),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blueGrey,
                        child: SvgPicture.asset(
                          chatModel.isGroup
                              ? "assets/groups.svg"
                              : "assets/person.svg",
                          color: Colors.white,
                          height: 36,
                          width: 36,
                        ),
                      ),
                    ],
                  ),
                ),
                title: InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatModel.name,
                          style: TextStyle(
                            fontSize: 18.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "last seen today at 12:05",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
                  IconButton(icon: Icon(Icons.call), onPressed: () {}),
                  PopupMenuButton<String>(
                    padding: EdgeInsets.all(0),
                    onSelected: (value) {},
                    itemBuilder: (BuildContext contesxt) {
                      return [
                        PopupMenuItem(
                          value: "View Contact",
                          child: Text("View Contact"),
                        ),
                        PopupMenuItem(
                          value: "Media, links, and docs",
                          child: Text("Media, links, and docs"),
                        ),
                        PopupMenuItem(
                          value: "Whatsapp Web",
                          child: Text("Whatsapp Web"),
                        ),
                        PopupMenuItem(value: "Search", child: Text("Search")),
                        PopupMenuItem(
                          value: "Mute Notification",
                          child: Text("Mute Notification"),
                        ),
                        PopupMenuItem(
                          value: "Wallpaper",
                          child: Text("Wallpaper"),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PopScope(
                child: Column(
                  children: [
                    Expanded(
                      // height: MediaQuery.of(context).size.height - 150,
                      child: Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          controller: controller.scrollController,
                          itemCount: controller.messages.length + 1,
                          itemBuilder: (context, index) {
                            if (index == controller.messages.length) {
                              return Container(height: 70);
                            }
                            if (controller.messages[index].type == "source") {
                              return OwnMessageCard(
                                message: controller.messages[index].message,
                                time: controller.messages[index].time,
                              );
                            } else {
                              return ReplyCard(
                                message: controller.messages[index].message,
                                time: controller.messages[index].time,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 70,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    child: Card(
                                      margin: EdgeInsets.only(
                                        left: 2,
                                        right: 2,
                                        bottom: 8,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Obx(
                                        () => TextFormField(
                                          controller: controller.textController,
                                          focusNode: controller.focusNode,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 5,
                                          minLines: 1,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              controller.sendButton.value =
                                                  true;
                                              controller.update();
                                            } else {
                                              controller.sendButton.value =
                                                  false;
                                              controller.update();
                                            }
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Type a message",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            prefixIcon: IconButton(
                                              icon: Icon(
                                                controller.show.value
                                                    ? Icons.keyboard
                                                    : Icons
                                                        .emoji_emotions_outlined,
                                              ),
                                              onPressed: () {},
                                            ),
                                            suffixIcon: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.attach_file),
                                                  onPressed: () {
                                                    // showModalBottomSheet(
                                                    //     backgroundColor:
                                                    //     Colors.transparent,
                                                    //     context: context,
                                                    //     builder: (builder) =>
                                                    //         bottomSheet());
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.camera_alt),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                            contentPadding: EdgeInsets.all(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 8,
                                      right: 2,
                                      left: 2,
                                    ),
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Color(0xFF128C7E),
                                      child: IconButton(
                                        icon: Obx(
                                          () => Icon(
                                            controller.sendButton.value
                                                ? Icons.send
                                                : Icons.mic,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: () {
                                          if (controller.sendButton.value) {
                                            controller.scrollController
                                                .animateTo(
                                                  controller
                                                      .scrollController
                                                      .position
                                                      .maxScrollExtent,
                                                  duration: Duration(
                                                    milliseconds: 300,
                                                  ),
                                                  curve: Curves.easeOut,
                                                );
                                            controller.sendMessage(
                                              controller.textController.text,
                                              sourceChat.id,
                                              chatModel.id,
                                            );
                                            controller.textController.clear();
                                            controller.sendButton.value = false;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onPopInvokedWithResult: (didPop, result) {
                  if (controller.show.value) {
                    controller.show.value = false;
                  } else if (didPop) {
                    Navigator.pop(context);
                  }
                  // return Future.value(false);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
