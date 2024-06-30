import 'package:chat/core/common/models/user_model.dart';

abstract class AllUsersScreenStates {}

class AllUsersScreenInitialState extends AllUsersScreenStates {}

class GettingAllUsersState extends AllUsersScreenStates {}

class GettingAllUsersSuccessfulState extends AllUsersScreenStates {
  final List<UserModel> allUsers;

  GettingAllUsersSuccessfulState({required this.allUsers});
}

class GettingAllUsersFailedState extends AllUsersScreenStates {}

class CreatingChatRoomState extends AllUsersScreenStates {}

class CreatingChatRoomSuccessfulState extends AllUsersScreenStates {}

class CreatingChatRoomFailedState extends AllUsersScreenStates {}
