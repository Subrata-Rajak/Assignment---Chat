import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/blocs/internet_connectivity_bloc.dart';
import '../../../../core/common/widgets/custom/no_internet.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/shared_preferences/local_storage.dart';
import '../../../../core/shared_preferences/local_storage_keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late InternetConnectivityCubit internetConnectivityCubit;

  @override
  void initState() {
    super.initState();
    internetConnectivityCubit = context.read<InternetConnectivityCubit>();
    internetConnectivityCubit.checkConnectivity();
    internetConnectivityCubit.trackConnectivityChange();
  }

  @override
  void dispose() {
    internetConnectivityCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 2000),
      () async {
        final isLoggedIn = await LocalStorage.instance
            .readBoolFromLocalDb(key: LocalStorageKeys.instance.isLoggedIn);

        if (context.mounted) {
          context.replace(isLoggedIn == null || !isLoggedIn
              ? AppRoutePaths.instance.loginScreenRoutePath
              : AppRoutePaths.instance.dashboardRoutePath);
        }
      },
    );
    return Scaffold(
      body: BlocBuilder<InternetConnectivityCubit, InternetConnectivityState>(
        builder: (context, state) {
          if (state.status == ConnectivityStatus.connected) {
            return const SafeArea(
              child: Center(
                child: Text(
                  "Chat",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
