import 'package:chat/core/common/widgets/basics.dart';
import 'package:chat/core/common/widgets/custom/no_internet.dart';
import 'package:chat/core/routes/route_paths.dart';
import 'package:chat/feature/auth/presentation/blocs/signup_screen_bloc/signup_screen_bloc.dart';
import 'package:chat/feature/auth/presentation/blocs/signup_screen_bloc/signup_screen_events.dart';
import 'package:chat/feature/auth/presentation/blocs/signup_screen_bloc/signup_screen_states.dart';
import 'package:chat/injection_container.dart';
import 'package:chat/src/values/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/common/blocs/internet_connectivity_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with CommonWidgets {
  late InternetConnectivityCubit internetConnectivityCubit;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

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
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<InternetConnectivityCubit, InternetConnectivityState>(
        builder: (context, state) {
          if (state.status == ConnectivityStatus.connected) {
            return BlocProvider<SignupScreenBloc>(
              create: (context) => sl(),
              child: BlocConsumer<SignupScreenBloc, SignupScreenStates>(
                listener: (context, state) {
                  if (state is SigninUpUserSuccessfulState) {
                    context
                        .replace(AppRoutePaths.instance.loginScreenRoutePath);
                  }
                },
                builder: (blocContext, state) {
                  if (state is SigningUpUserState) {
                    return Stack(
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
                        buildBody(size: size, context: blocContext),
                      ],
                    );
                  }
                  return buildBody(size: size, context: blocContext);
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

  buildBody({
    required Size size,
    required BuildContext context,
  }) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              verticalSpace(height: 40),
              const Text(
                "Chat",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              verticalSpace(height: 30),
              buildLoginForm(),
              verticalSpace(height: 30),
              buildLoginButton(size, context),
              verticalSpace(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  horizontalSpace(width: 5),
                  GestureDetector(
                    onTap: () => context
                        .replace(AppRoutePaths.instance.loginScreenRoutePath),
                    child: const Text(
                      "Login Now",
                      style: TextStyle(
                        color: Color(0xff27ABDF),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildLoginButton(Size size, BuildContext context) {
    return SizedBox(
      height: 56,
      width: size.width,
      child: ElevatedButton(
        onPressed: () async {
          if (_loginFormKey.currentState!.validate()) {
            context.read<SignupScreenBloc>().add(
                  SignUpUserEvent(
                    confirmPassword: confirmPasswordController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    username: usernameController.text,
                  ),
                );
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: AppColors.instance.uspScreenButtonColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        child: Text(
          'Register',
          style: GoogleFonts.urbanist(
            color: AppColors.instance.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Form buildLoginForm() {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Username',
            style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          verticalSpace(height: 10),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.instance.grey,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff27ABDF),
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              hintText: 'Enter your email address',
              hintStyle: TextStyle(
                fontSize: 14,
                color: const Color(0xff555566).withOpacity(0.4),
              ),
            ),
          ),
          verticalSpace(height: 10),
          Text(
            'Email',
            style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          verticalSpace(height: 10),
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your email';
              } else if (!EmailValidator.validate(value)) {
                return 'Enter a valid email';
              }

              return null;
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.instance.grey,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff27ABDF),
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              hintText: 'Enter your email address',
              hintStyle: TextStyle(
                fontSize: 14,
                color: const Color(0xff555566).withOpacity(0.4),
              ),
            ),
          ),
          verticalSpace(height: 10),
          Text(
            'Password',
            style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          verticalSpace(height: 10),
          TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your password';
              } else if (value.length < 8) {
                return 'Enter a password of at least length 8';
              }

              return null;
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.instance.grey,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff27ABDF),
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              hintText: 'Enter your password',
              hintStyle: TextStyle(
                fontSize: 14,
                color: const Color(0xff555566).withOpacity(0.4),
              ),
            ),
          ),
          verticalSpace(height: 10),
          Text(
            'Confirm Password',
            style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          verticalSpace(height: 10),
          TextFormField(
            controller: confirmPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your password';
              } else if (value.length < 8) {
                return 'Enter a password of at least length 8';
              } else if (value != passwordController.text) {
                return 'Not matching with password';
              }

              return null;
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.instance.grey,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff27ABDF),
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              hintText: 'Enter your password',
              hintStyle: TextStyle(
                fontSize: 14,
                color: const Color(0xff555566).withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
