import 'dart:async';

import 'package:chat/feature/auth/domain/usecases/signup_user_usecase.dart';
import 'package:chat/feature/auth/presentation/blocs/signup_screen_bloc/signup_screen_events.dart';
import 'package:chat/feature/auth/presentation/blocs/signup_screen_bloc/signup_screen_states.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreenBloc extends Bloc<SignUpScreenEvents, SignupScreenStates> {
  final SignUpUserUsecase signUpUserUsecase;

  SignupScreenBloc({
    required this.signUpUserUsecase,
  }) : super(SignUpScreenInitialState()) {
    on<SignUpUserEvent>(signUpUser);
  }

  FutureOr<void> signUpUser(
    SignUpUserEvent event,
    Emitter<SignupScreenStates> emit,
  ) async {
    try {
      emit(SigningUpUserState());

      var res = await signUpUserUsecase.registerUser(
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
        userName: event.username,
      );

      if (res) {
        emit(SigninUpUserSuccessfulState());
      } else {
        emit(SigningUpUserFailedState());
      }
    } catch (error) {
      debugPrint("Error while registering user: $error");
      emit(SigningUpUserFailedState());
    }
  }
}
