import 'package:chat/core/common/widgets/basics.dart';
import 'package:chat/feature/chat/static/send_message_service.dart';
import 'package:chat/src/values/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ChatRoomScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> chatRoomModel;
  const ChatRoomScreen({
    super.key,
    required this.chatRoomModel,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> with CommonWidgets {
  List<dynamic> chats = [];
  final TextEditingController messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              verticalSpace(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 25,
                      ),
                    ),
                    horizontalSpace(width: 10),
                    Text(
                      "${widget.chatRoomModel['userTwo.username']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(AppStrings.instance.chatRoomCollection)
                      .where('userTwo.uid',
                          isEqualTo: widget.chatRoomModel['userTwo.uid'])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return chats.isEmpty
                          ? const Center(
                              child: Text("No Chats"),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: ListView.builder(
                                itemCount:
                                    snapshot.data!.docs[0]['chats'].length,
                                itemBuilder: (context, index) {
                                  var chatDoc =
                                      snapshot.data!.docs[0]['chats'][index];

                                  return Row(
                                    mainAxisAlignment: chatDoc['userId'] ==
                                            _auth.currentUser!.uid
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: size.width * 0.5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.3),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              chatDoc['text'],
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            verticalSpace(height: 10),
                                            Text(
                                              DateFormat('hh:mm a').format(
                                                  DateTime.parse(
                                                      chatDoc['timeStamp'])),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                    }

                    if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No chats found.'));
                    }

                    chats = snapshot.data!.docs[0]['chats'];

                    return chats.isEmpty
                        ? const Center(
                            child: Text("No Chats"),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return verticalSpace(height: 10);
                              },
                              itemCount: snapshot.data!.docs[0]['chats'].length,
                              itemBuilder: (context, index) {
                                var chatDoc =
                                    snapshot.data!.docs[0]['chats'][index];

                                return Row(
                                  mainAxisAlignment: chatDoc['userId'] ==
                                          _auth.currentUser!.uid
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: size.width * 0.5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.3),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            chatDoc['text'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          verticalSpace(height: 10),
                                          Text(
                                            DateFormat('hh:mm a').format(
                                                DateTime.parse(
                                                    chatDoc['timeStamp'])),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                  },
                ),
              ),
              Container(
                width: size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * 0.75,
                      child: TextFormField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          hintText: 'Enter your message',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (messageController.text.isNotEmpty) {
                          await SendMessageService.instance.sendMessage(
                            message: messageController.text,
                            receiverUid: widget.chatRoomModel['userTwo.uid'],
                          );

                          messageController.clear();
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              verticalSpace(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
