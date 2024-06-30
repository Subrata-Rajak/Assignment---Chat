import 'package:chat/core/common/widgets/basics.dart';
import 'package:chat/core/common/widgets/custom/no_internet.dart';
import 'package:chat/feature/chat/presentation/views/chat_screen.dart';
import 'package:chat/feature/payments/presentation/views/payments_screen.dart';
import 'package:chat/src/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/common/blocs/internet_connectivity_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with CommonWidgets {
  var _currentScreenIndex = 0;

  var bottomNavTabs = [
    BottomNavTab(
      icon: Icons.chat,
      label: "Chats",
      screenIndex: 0,
      screen: const ChatScreen(),
    ),
    BottomNavTab(
      icon: Icons.payment,
      label: "Payments",
      screenIndex: 1,
      screen: const PaymentsScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: bottomNavTabs
                .map(
                  (tab) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentScreenIndex = tab.screenIndex;
                      });
                    },
                    child: Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(
                                _currentScreenIndex == tab.screenIndex ? 8 : 0),
                            decoration: _currentScreenIndex != tab.screenIndex
                                ? null
                                : const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Color(0xff27ABDF),
                                  ),
                            child: Icon(
                              tab.icon,
                              color: _currentScreenIndex == tab.screenIndex
                                  ? Colors.white
                                  : null,
                            ),
                          ),
                          verticalSpace(height: 5),
                          _currentScreenIndex != tab.screenIndex
                              ? Text(
                                  tab.label,
                                  style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: AppColors.instance.grey,
                                  ),
                                )
                              : emptyContainer(),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      body: BlocBuilder<InternetConnectivityCubit, InternetConnectivityState>(
        builder: (context, state) {
          if (state.status == ConnectivityStatus.connected) {
            return SafeArea(
              child: bottomNavTabs
                  .where(
                    (element) => element.screenIndex == _currentScreenIndex,
                  )
                  .toList()[0]
                  .screen,
            );
          } else {
            return const NoInterNet();
          }
        },
      ),
    );
  }
}

class BottomNavTab {
  final IconData icon;
  final String label;
  final int screenIndex;
  final Widget screen;

  BottomNavTab({
    required this.icon,
    required this.label,
    required this.screenIndex,
    required this.screen,
  });
}
