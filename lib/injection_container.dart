import 'package:chat/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat/feature/auth/data/sources/auth_services.dart';
import 'package:chat/feature/auth/domain/repositories/auth_repository.dart';
import 'package:chat/feature/auth/domain/usecases/log_out_user_usecase.dart';
import 'package:chat/feature/auth/domain/usecases/login_user_usecase.dart';
import 'package:chat/feature/auth/domain/usecases/signup_user_usecase.dart';
import 'package:chat/feature/auth/presentation/blocs/login_screen_bloc/login_screen_bloc.dart';
import 'package:chat/feature/auth/presentation/blocs/signup_screen_bloc/signup_screen_bloc.dart';
import 'package:chat/feature/chat/data/repositories/chat_repository_impl.dart';
import 'package:chat/feature/chat/data/sources/chat_services.dart';
import 'package:chat/feature/chat/domain/repositories/chat_repository.dart';
import 'package:chat/feature/chat/domain/usecases/create_chat_room_usecase.dart';
import 'package:chat/feature/chat/domain/usecases/get_all_users_data_usecase.dart';
import 'package:chat/feature/chat/presentation/blocs/all_users_screen_bloc/all_users_screen_bloc.dart';
import 'package:get_it/get_it.dart';
/*
* All the dependencies were injected/initialized here.
* We are using "GetIt" package to perform the dependency injection easily
* Go through the package documentation to know it in more depth - https://pub.dev/packages/get_it

* Here we injected dependencies of blocs, repositories, usecases and services
*/

final sl = GetIt
    .instance; // * "sl" is just a name of the variable which holds the instance of the GetIt class

Future<void> initDep() async {
  //? blocs
  sl.registerFactory<SignupScreenBloc>(
    () => SignupScreenBloc(
      signUpUserUsecase: sl.call(),
    ),
  );

  sl.registerFactory<LoginScreenBloc>(
    () => LoginScreenBloc(
      loginUserUsecase: sl.call(),
    ),
  );

  sl.registerFactory<AllUsersScreenBloc>(
    () => AllUsersScreenBloc(
      getAllUsersDataUsecase: sl.call(),
      createChatRoomUsecase: sl.call(),
    ),
  );

  //? services
  sl.registerSingleton<AuthServices>(AuthServices());
  sl.registerSingleton<ChatServices>(ChatServices());

  //? repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      authServices: sl.call(),
    ),
  );

  sl.registerSingleton<ChatRepository>(
    ChatRepositoryImpl(
      chatServices: sl.call(),
    ),
  );

  //? usecases
  sl.registerSingleton<SignUpUserUsecase>(
    SignUpUserUsecase(
      authRepository: sl.call(),
    ),
  );

  sl.registerSingleton<LoginUserUsecase>(
    LoginUserUsecase(
      authRepository: sl.call(),
    ),
  );

  sl.registerSingleton<LogOutUserUsecase>(
    LogOutUserUsecase(
      authRepository: sl.call(),
    ),
  );

  sl.registerSingleton<GetAllUsersDataUsecase>(
    GetAllUsersDataUsecase(
      chatRepository: sl.call(),
    ),
  );

  sl.registerSingleton(
    CreateChatRoomUsecase(
      chatRepository: sl.call(),
    ),
  );
}
