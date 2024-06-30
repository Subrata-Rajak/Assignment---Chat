import 'dart:async';

import 'package:chat/feature/chat/domain/usecases/create_chat_room_usecase.dart';
import 'package:chat/feature/chat/presentation/blocs/chat_room_screen_bloc/chat_room_screen_events.dart';
import 'package:chat/feature/chat/presentation/blocs/chat_room_screen_bloc/chat_room_screen_states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomScreenBloc
    extends Bloc<ChatRoomScreenEvents, ChatRoomScreenStates> {
  final CreateChatRoomUsecase createChatRoomUsecase;
  ChatRoomScreenBloc({
    required this.createChatRoomUsecase,
  }) : super(ChatRoomScreenInitialState()) {
    on<GetChatsEvent>(getChats);
  }

  FutureOr<void> getChats(
    GetChatsEvent event,
    Emitter<ChatRoomScreenStates> emit,
  ) async {
    emit(GettingChatsState());
    try {} catch (error) {
      emit(GettingChatsFailedState());

      debugPrint("Error while creating chat room --BLOC: $error");
    }
  }
}
