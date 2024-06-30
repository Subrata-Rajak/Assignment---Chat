import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared_preferences/local_storage.dart';
import '../../shared_preferences/local_storage_keys.dart';

/*
* This is the theme bloc used to switch bloc in the app
*/

abstract class ThemeEvent {}

class LoadInitialTheme
    extends ThemeEvent {} //? event to load the initial or previous theme

class ToggleTheme extends ThemeEvent {} //? event to change or toggle the theme

abstract class ThemeStates {}

class ThemeInitialState
    extends ThemeStates {} //? initial state to load the current theme

/*
* Update theme state is the state which is used to update the theme in the app
* It requires a bool variable which is responsible to toggle or change the theme in the app
*/
class UpdatedThemeState extends ThemeStates {
  final bool isDark; //? variable responsible for changing the theme in the app

  UpdatedThemeState({required this.isDark});
}

// ThemeBloc to manage theme changes
class ThemeBloc extends Bloc<ThemeEvent, ThemeStates> {
  ThemeBloc() : super(ThemeInitialState()) {
    on<LoadInitialTheme>(
        loadInitialTheme); //? function to load the current theme of the app has
    on<ToggleTheme>(toggleTheme);
  }

  Future<void> toggleTheme(
    ToggleTheme event,
    Emitter<ThemeStates> emit,
  ) async {
    final currentState =
        state as UpdatedThemeState; //? fetching the current state
    final bool newIsDark =
        !currentState.isDark; //? changing or toggling the current theme
    await persistTheme(
      newIsDark,
    ); //? Save the theme mode to shared preferences to persist the theme
    emit(
      UpdatedThemeState(isDark: newIsDark),
    ); //? emitting a state with updated theme
  }

  /*
  * persistTheme is the function to persist the theme in the app
  * using shared preferences to save the current theme as a bool variable in the local storage
  * if isDark is true -> dark theme else -> light theme
  */
  Future<void> persistTheme(bool isDark) async {
    await LocalStorage.instance.writeBoolToLocalDb(
      key: LocalStorageKeys.instance.currentTheme,
      value: isDark,
    );
  }

  /*
  * in this below function doing this actions sequentially
  * 1. getting the current theme from the local storage with the help of shared preferences
  * 2. emitting state with the theme according to the result got from local storage
  */
  FutureOr<void> loadInitialTheme(
    LoadInitialTheme event,
    Emitter<ThemeStates> emit,
  ) async {
    final res = await LocalStorage.instance
        .readBoolFromLocalDb(key: LocalStorageKeys.instance.currentTheme);
    if (res != null) {
      emit(
        UpdatedThemeState(
          isDark: res,
        ),
      ); //? is result is not null that means the user changed theme in past that why it is preserved in the local storage
    } else {
      /*
      * if res is not null that means the user never changed the theme
      * in that case emitting light theme (default theme of the app)
      */
      emit(UpdatedThemeState(isDark: false));
    }
  }
}
