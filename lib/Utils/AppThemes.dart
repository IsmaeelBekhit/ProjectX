import 'package:flutter/material.dart';

import 'AppColors.dart';

class AppThemes {
  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.primaryColor,
    primaryColorDark: AppColors.primaryColorDark,
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Montserrat',
        ),
  );

  static final textTheme1 =
      lightTheme.copyWith(textSelectionTheme: textInputFieldTheme1);
  static final textTheme2 =
      lightTheme.copyWith(textSelectionTheme: textInputFieldTheme1);

  static final textInputFieldTheme1 = TextSelectionThemeData(
      selectionHandleColor: Colors.white,
      cursorColor: Colors.white.withOpacity(.7),
      selectionColor: Colors.white.withOpacity(.5));
  static final textInputFieldTheme2 = TextSelectionThemeData(
      selectionHandleColor: AppColors.primaryColor,
      cursorColor: AppColors.primaryColor.withOpacity(.7),
      selectionColor: AppColors.primaryColor.withOpacity(.5));
}
