class ChatModel {
  final String name;
  final String icon;
  final bool isGroup;
  final String time;
  final String currentMessage;
  // String? status;
  bool select = false;
  final int id;
  ChatModel({
    required this.name,
    required this.icon,
    required this.isGroup,
    required this.time,
    required this.currentMessage,
    // this.status,
    required this.id,
  });

  @override
  String toString() {
    return 'ChatModel(name: $name, icon: $icon, isGroup: $isGroup, time: $time, currentMessage: $currentMessage, select: $select, id: $id)';
  }
}

class MessageModel {
  final String type;
  final String message;
  final String time;
  MessageModel({required this.type, required this.message, required this.time});

  @override
  String toString() =>
      'MessageModel(type: $type, message: $message, time: $time)';
}
