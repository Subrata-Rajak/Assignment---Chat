import 'package:flutter/material.dart';

/*
* All Colors used in polymetalz mobile app
*/

class AppColors {
  static AppColors instance = AppColors();

  final white = const Color(0xffffffff);
  final black = const Color(0xff2E3032);
  final grey = const Color(0xffAEAEAE);
  final red = const Color(0xffF76961);
  final linearTopOrLeft = const Color(0xff27C57A);
  final linerBottomOrRight = const Color(0xff0D2820);
  final pricePercentageIncreasedColor = const Color(0xff50CD89);
  final pricePercentageDecreasedColor = const Color(0xffE0144C);
  final yellow = const Color(0xffE5F64A);
  final green = const Color(0xff27C57A);

  final uspScreenInactiveDotColor = const Color(0xffD9D9D9);
  final uspScreenActiveDotColor = const Color(0xff27ABDF);
  final uspScreensDescriptionTextColor = const Color(0xff999999);
  final uspScreensHeadingTextColor = const Color(0xff1E232C);
  final uspScreenButtonColor = const Color(0xff27ABDF);

  final loginScreenTabIndicatorColor = const Color(0xff27ABDF);
  final loginScreenTabBackgroundColor = const Color(0xffD3EEF8);
  final loginScreenTabTextColor = const Color(0xff27ABDF);

  final MaterialColor primaryBlack = const MaterialColor(
    0xFF1E1E1E,
    <int, Color>{
      50: Color(0xFF1E1E1E),
      100: Color(0xFF1E1E1E),
      200: Color(0xFF1E1E1E),
      300: Color(0xFF1E1E1E),
      400: Color(0xFF1E1E1E),
      500: Color(0xFF1E1E1E),
      600: Color(0xFF1E1E1E),
      700: Color(0xFF1E1E1E),
      800: Color(0xFF1E1E1E),
      900: Color(0xFF1E1E1E),
    },
  );

  final MaterialColor primaryWhite = const MaterialColor(
    0xFFffffff,
    <int, Color>{
      50: Color(0xFFffffff),
      100: Color(0xFFffffff),
      200: Color(0xFFffffff),
      300: Color(0xFFffffff),
      400: Color(0xFFffffff),
      500: Color(0xFFffffff),
      600: Color(0xFFffffff),
      700: Color(0xFFffffff),
      800: Color(0xFFffffff),
      900: Color(0xFFffffff),
    },
  );
}
