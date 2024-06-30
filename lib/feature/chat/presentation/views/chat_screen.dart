import 'package:chat/core/routes/route_paths.dart';
import 'package:chat/src/values/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          // padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                width: size.width,
                // height: 20,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: const Text(
                  "Chats",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(AppStrings.instance.chatRoomCollection)
                      .where(
                        Filter.or(
                          Filter(
                            "userOne.uid",
                            isEqualTo: _auth.currentUser!.uid,
                          ),
                          Filter(
                            "userTwo.uid",
                            isEqualTo: _auth.currentUser!.uid,
                          ),
                        ),
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No chats found.'));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var userDoc = snapshot.data!.docs[index];
                        var username =
                            userDoc['userOne.uid'] == _auth.currentUser!.uid
                                ? userDoc['userTwo.username']
                                : userDoc['userOne.username'];
                        var email =
                            userDoc['userOne.uid'] == _auth.currentUser!.uid
                                ? userDoc['userTwo.email']
                                : userDoc['userOne.email'];

                        return GestureDetector(
                          onTap: () => context.push(
                            AppRoutePaths.instance.chatRoomScreenRoutePath,
                            extra: snapshot.data!.docs[index],
                          ),
                          child: ListTile(
                            title: Text(username),
                            subtitle: Text(email),
                            // You can add more widgets here to display additional user info
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () =>
                context.push(AppRoutePaths.instance.allsUsersRoutePath),
            child: const Icon(Icons.edit),
          ),
        ),
      ],
    );
  }
}
