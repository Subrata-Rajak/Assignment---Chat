import 'package:chat/core/common/blocs/internet_connectivity_bloc.dart';
import 'package:chat/core/common/widgets/basics.dart';
import 'package:chat/core/common/widgets/custom/no_internet.dart';
import 'package:chat/core/routes/route_paths.dart';
import 'package:chat/feature/chat/presentation/blocs/all_users_screen_bloc/all_users_screen_bloc.dart';
import 'package:chat/feature/chat/presentation/blocs/all_users_screen_bloc/all_users_screen_events.dart';
import 'package:chat/feature/chat/presentation/blocs/all_users_screen_bloc/all_users_screen_states.dart';
import 'package:chat/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/models/user_model.dart';
import '../../../../src/values/colors.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> with CommonWidgets {
  List<UserModel> allUsers = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start a chat"),
        centerTitle: false,
      ),
      body: BlocBuilder<InternetConnectivityCubit, InternetConnectivityState>(
        builder: (context, state) {
          if (state.status == ConnectivityStatus.connected) {
            return BlocProvider<AllUsersScreenBloc>(
              create: (context) => sl(),
              child: BlocConsumer<AllUsersScreenBloc, AllUsersScreenStates>(
                listener: (context, state) {
                  if (state is CreatingChatRoomSuccessfulState) {
                    context.replace(AppRoutePaths.instance.dashboardRoutePath);
                  }
                  if (state is CreatingChatRoomFailedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Chatroom already exist with this user",
                        ),
                      ),
                    );
                  }
                },
                builder: (blocContext, state) {
                  if (state is AllUsersScreenInitialState) {
                    blocContext
                        .read<AllUsersScreenBloc>()
                        .add(GetAllUsersEvent());
                  } else if (state is GettingAllUsersState) {
                    return const SafeArea(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is GettingAllUsersSuccessfulState ||
                      state is CreatingChatRoomFailedState) {
                    state is GettingAllUsersSuccessfulState
                        ? allUsers = state.allUsers
                        : null;
                    return SafeArea(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<AllUsersScreenBloc>()
                                  .add(CreateChatRoomEvent(
                                    receiverEmail: allUsers[index].email,
                                    receiverUid: allUsers[index].uid,
                                    receiverUsername: allUsers[index].userName,
                                  ));
                            },
                            child: ListTile(
                              title: Text(allUsers[index].userName),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return verticalSpace(height: 10);
                        },
                        itemCount: allUsers.length,
                      ),
                    );
                  } else if (state is GettingAllUsersFailedState) {
                    return SafeArea(
                      child: SizedBox(
                        width: size.width,
                        height: size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Failed to load data"),
                            verticalSpace(height: 20),
                            ElevatedButton(
                              onPressed: () => blocContext
                                  .read<AllUsersScreenBloc>()
                                  .add(GetAllUsersEvent()),
                              child: const Text("Try again"),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is CreatingChatRoomState) {
                    return SafeArea(
                      child: Stack(
                        children: [
                          Container(
                            width: size.width,
                            height: size.height,
                            decoration: BoxDecoration(
                              color: AppColors.instance.black.withOpacity(0.3),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ListView.separated(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<AllUsersScreenBloc>()
                                      .add(CreateChatRoomEvent(
                                        receiverEmail: allUsers[index].email,
                                        receiverUid: allUsers[index].uid,
                                        receiverUsername:
                                            allUsers[index].userName,
                                      ));
                                },
                                child: ListTile(
                                  title: Text(allUsers[index].userName),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return verticalSpace(height: 10);
                            },
                            itemCount: allUsers.length,
                          ),
                        ],
                      ),
                    );
                  }
                  return emptyContainer();
                },
              ),
            );
          } else {
            return const NoInterNet();
          }
        },
      ),
    );
  }
}
