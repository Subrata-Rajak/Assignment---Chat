import 'package:chat/core/routes/route_names.dart';
import 'package:chat/feature/chat/presentation/views/all_users_screen.dart';
import 'package:chat/feature/chat/presentation/views/chat_room_screen.dart';
import 'package:chat/feature/dashboard/presentation/views/dashboard.dart';
import 'package:chat/feature/splash/presentation/views/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

import '../../feature/auth/presentation/views/login_screen.dart';
import '../../feature/auth/presentation/views/signup_screen.dart';
import 'route_paths.dart';

class AppRoutes {
  static AppRoutes instance = AppRoutes();

  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutePaths.instance.splashScreenRoutePath,
        name: AppRouteNames.instance.splashScreenRouteName,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.instance.loginScreenRoutePath,
        name: AppRouteNames.instance.loginScreenRouteName,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.instance.signUpScreenRoutePath,
        name: AppRouteNames.instance.signUpScreenRouteName,
        builder: (context, state) {
          return const SignUpScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.instance.chatRoomScreenRoutePath,
        name: AppRouteNames.instance.chatRoomScreenRouteName,
        builder: (context, state) {
          return ChatRoomScreen(
            chatRoomModel: state.extra as QueryDocumentSnapshot<Object?>,
          );
        },
      ),
      GoRoute(
        path: AppRoutePaths.instance.dashboardRoutePath,
        name: AppRouteNames.instance.dashboardRouteName,
        builder: (context, state) {
          return const Dashboard();
        },
      ),
      GoRoute(
        path: AppRoutePaths.instance.allsUsersRoutePath,
        name: AppRouteNames.instance.allUsersRouteName,
        builder: (context, state) {
          return const AllUsersScreen();
        },
      ),
    ],
    initialLocation: AppRoutePaths.instance.splashScreenRoutePath,
  );
}
