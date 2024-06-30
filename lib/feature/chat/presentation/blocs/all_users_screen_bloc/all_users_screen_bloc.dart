import 'dart:async';

import 'package:chat/feature/chat/domain/usecases/create_chat_room_usecase.dart';
import 'package:chat/feature/chat/domain/usecases/get_all_users_data_usecase.dart';
import 'package:chat/feature/chat/presentation/blocs/all_users_screen_bloc/all_users_screen_events.dart';
import 'package:chat/feature/chat/presentation/blocs/all_users_screen_bloc/all_users_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersScreenBloc
    extends Bloc<AllUsersScreenEvents, AllUsersScreenStates> {
  final CreateChatRoomUsecase createChatRoomUsecase;
  final GetAllUsersDataUsecase getAllUsersDataUsecase;

  AllUsersScreenBloc({
    required this.getAllUsersDataUsecase,
    required this.createChatRoomUsecase,
  }) : super(AllUsersScreenInitialState()) {
    on<GetAllUsersEvent>(getAllUsers);
    on<CreateChatRoomEvent>(createChatRoom);
  }

  FutureOr<void> getAllUsers(
    GetAllUsersEvent event,
    Emitter<AllUsersScreenStates> emit,
  ) async {
    emit(GettingAllUsersState());

    try {
      var allUsers = await getAllUsersDataUsecase.getAllUsersData();

      if (allUsers.isNotEmpty) {
        emit(
          GettingAllUsersSuccessfulState(
            allUsers: allUsers,
          ),
        );
      } else {
        emit(GettingAllUsersFailedState());
      }
    } catch (error) {
      debugPrint("Error while fetching all users --BLOC: $error");
      emit(GettingAllUsersFailedState());
    }
  }

  FutureOr<void> createChatRoom(
    CreateChatRoomEvent event,
    Emitter<AllUsersScreenStates> emit,
  ) async {
    emit(CreatingChatRoomState());

    try {
      var res = await createChatRoomUsecase.createChatRoom(
        receiverUid: event.receiverUid,
        receiverUsername: event.receiverUsername,
        receiverEmail: event.receiverEmail,
      );

      if (res) {
        emit(CreatingChatRoomSuccessfulState());
      } else {
        emit(CreatingChatRoomFailedState());
      }
    } catch (error) {
      emit(CreatingChatRoomFailedState());
      debugPrint("Error while creating chat room --BLOC: $error");
    }
  }
}
