import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../src/values/colors.dart';

mixin CommonWidgets {
  SizedBox verticalSpace({required double height}) {
    return SizedBox(
      height: height,
      width: 0,
    );
  }

  SizedBox horizontalSpace({required double width}) {
    return SizedBox(
      height: 0,
      width: width,
    );
  }

  SizedBox emptyContainer() {
    return const SizedBox(
      height: 0,
      width: 0,
    );
  }

  GestureDetector expandedButton({
    required String buttonText,
    required double width,
    required double height,
    required BuildContext context,
    required AlignmentGeometry begin,
    required AlignmentGeometry end,
    required void Function()? onTapFun,
  }) {
    return GestureDetector(
      onTap: onTapFun,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          gradient: LinearGradient(
            colors: [
              AppColors.instance.linearTopOrLeft,
              AppColors.instance.linerBottomOrRight,
            ],
            begin: begin,
            end: end,
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.instance.white,
            ),
          ),
        ),
      ),
    );
  }
}
