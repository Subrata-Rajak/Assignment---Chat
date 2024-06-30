import 'package:chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'core/common/blocs/internet_connectivity_bloc.dart';
import 'core/common/blocs/theme_bloc.dart';
import 'core/common/widgets/basics.dart';
import 'core/routes/routes.dart';
import 'injection_container.dart';
import 'src/themes/dark.dart';
import 'src/themes/light.dart';

/* 
* This is the file from where the execution of the codebase starts
* The main function is responsible to run the app
* Then we have a MyApp stateless widget which basically behaves as a container for the whole material app
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(
      fileName:
          ".env"); // * load all environment variables before running the app
  Stripe.publishableKey = dotenv.env["STRIPE_PUBLISH_KEY"]!;
  await Stripe.instance.applySettings();
  await initDep(); // * initializing the dependency injection container
  runApp(const MyApp()); // * running the app with runApp() function
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with CommonWidgets {
  /*
  * This is the flow of the main container of the whole app which is returned from the build function
  * Theme bloc provider -> Material App -> initial location
  * Theme bloc provider has 2 states ->
          * a. ThemeInitialState, in which we recollect the previous state form local storage
          * b. UpdateThemeState, in which we update the theme according to the user interaction
  */

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InternetConnectivityCubit>(
      create: (context) => InternetConnectivityCubit(),
      child: BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeStates>(
          builder: (context, themeState) {
            if (themeState is ThemeInitialState) {
              context.read<ThemeBloc>().add(LoadInitialTheme());
            } else if (themeState is UpdatedThemeState) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Chat',
                theme:
                    appLightTheme, // * The light theme we specified and importing from the file "package:polymetalz/src/themes/light.dart"
                darkTheme:
                    appDarkTheme, // * The dark theme we specified and importing from the file "package:polymetalz/src/themes/dark.dart"
                routerConfig: AppRoutes.instance.router,
                themeMode: themeState.isDark
                    ? ThemeMode.dark
                    : ThemeMode.light, // * switching the theme modes
              );
            }
            return emptyContainer();
          },
        ),
      ),
    );
  }
}
