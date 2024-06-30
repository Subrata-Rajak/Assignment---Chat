import 'package:chat/core/common/models/chat_room_model.dart';

abstract class ChatRoomScreenStates {}

class ChatRoomScreenInitialState extends ChatRoomScreenStates {}

class GettingChatsState extends ChatRoomScreenStates {}

class GettingChatsSuccessfulState extends ChatRoomScreenStates {
  ChatRoomModel chatRoomModel;

  GettingChatsSuccessfulState({required this.chatRoomModel});
}

class GettingChatsFailedState extends ChatRoomScreenStates {}
