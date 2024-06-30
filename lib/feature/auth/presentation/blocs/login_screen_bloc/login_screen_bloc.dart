import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/login_user_usecase.dart';
import 'login_screen_events.dart';
import 'login_screen_states.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvents, LoginScreenStates> {
  final LoginUserUsecase loginUserUsecase;

  LoginScreenBloc({
    required this.loginUserUsecase,
  }) : super(LoginScreenInitialState()) {
    on<LoginUserEvent>(signUpUser);
  }

  FutureOr<void> signUpUser(
    LoginUserEvent event,
    Emitter<LoginScreenStates> emit,
  ) async {
    try {
      emit(LoggingInUserState());

      var res = await loginUserUsecase.loginUser(
        email: event.email,
        password: event.password,
      );

      if (res) {
        emit(LoggingInUserSuccessfulState());
      } else {
        emit(LoggingInUserFailedState());
      }
    } catch (error) {
      debugPrint("Error while logging user in: $error");
      emit(LoggingInUserFailedState());
    }
  }
}
