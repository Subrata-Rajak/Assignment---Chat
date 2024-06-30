abstract class AllUsersScreenEvents {}

class GetAllUsersEvent extends AllUsersScreenEvents {}

class CreateChatRoomEvent extends AllUsersScreenEvents {
  final String receiverUid;
  final String receiverUsername;
  final String receiverEmail;

  CreateChatRoomEvent({
    required this.receiverEmail,
    required this.receiverUid,
    required this.receiverUsername,
  });
}
