import 'package:get/get.dart';

import '../../../models/model.dart';

class LoginController extends GetxController {
  late ChatModel sourceChat;
  List<ChatModel> chatmodels = [];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print('add data user');
    addDataUser();
  }

  void addDataUser() {
    chatmodels.add(
      ChatModel(
        name: "Bayu",
        isGroup: false,
        currentMessage: "Hi Everyone",
        time: "4:00",
        icon: "person.svg",
        id: 1,
      ),
    );
    chatmodels.add(
      ChatModel(
        name: "Nugroho",
        isGroup: false,
        currentMessage: "Hi Everyone",
        time: "4:00",
        icon: "person.svg",
        id: 2,
      ),
    );
    update();
  }
}
