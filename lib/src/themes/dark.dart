import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/colors.dart';

/*
* Dark mode theme of polymetalz
*/

final appDarkTheme = ThemeData(
  scaffoldBackgroundColor:
      const Color(0xFF1E1E1E), //? Scaffold background color
  useMaterial3: true,
  primarySwatch: AppColors.instance.primaryBlack, //? status bar color

  //? Text theme
  textTheme: TextTheme(
    //? Large Headline font style
    headlineLarge: GoogleFonts.manrope(
      fontSize: 28,
      color: AppColors.instance.white,
      fontWeight: FontWeight.w900,
    ),

    //? Small Headline font style
    headlineSmall: GoogleFonts.manrope(
      fontSize: 14,
      color: AppColors.instance.grey,
      fontWeight: FontWeight.w600,
    ),

    //? Medium display font style
    displayMedium: GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.instance.white,
    ),

    //? Large display font style
    displayLarge: GoogleFonts.manrope(
      fontSize: 24,
      fontWeight: FontWeight.w900,
      color: AppColors.instance.white,
    ),

    //? Small display font style
    displaySmall: GoogleFonts.manrope(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: AppColors.instance.white,
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: AppColors.instance.black,
  ), //? bottomAppBar theme used as bottomNavigation bar
);
