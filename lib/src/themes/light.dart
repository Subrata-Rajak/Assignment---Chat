import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/colors.dart';

/*
* Light mode theme of polymetalz
*/

final appLightTheme = ThemeData(
  scaffoldBackgroundColor:
      AppColors.instance.white, //? Scaffold background color
  useMaterial3: true,
  primarySwatch: AppColors.instance.primaryWhite, //? status bar color

  //? TextTheme
  textTheme: TextTheme(
    //? Large Headline font style
    headlineLarge: GoogleFonts.manrope(
      fontSize: 28,
      color: AppColors.instance.black,
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
      color: AppColors.instance.black,
    ),

    //? Large display font style
    displayLarge: GoogleFonts.manrope(
      fontSize: 24,
      fontWeight: FontWeight.w900,
      color: AppColors.instance.black,
    ),

    //? Small display font style
    displaySmall: GoogleFonts.manrope(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: AppColors.instance.black,
    ),
  ),
);
