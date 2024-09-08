import 'package:blog_app/core/constants/app_pallete.dart';
import 'package:flutter/material.dart';

import '../../constants/app_consts.dart';

class AppTheme {
  static OutlineInputBorder _border({Color color = AppPallete.borderColor}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConsts.authFieldBorderRadius),
        borderSide:
            BorderSide(color: color, width: AppConsts.authFieldBorderWidth),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppConsts.authFieldContentPadding),
      border: _border(),
      enabledBorder: _border(),
      disabledBorder: _border(),
      focusedErrorBorder: _border(),
      focusedBorder: _border(color: AppPallete.gradient2),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppPallete.backgroundColor,
        iconTheme: IconThemeData(color: AppPallete.whiteColor)),
    chipTheme: ChipThemeData(
        color: WidgetStateProperty.all(AppPallete.backgroundColor),
        side: BorderSide.none),
  );
}
