import 'package:flutter/material.dart';
import 'package:socialapp/theme/pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
        AppPallete.backgroundColor,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.errorColor),
    ),
  );

  // reddit

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.blackColor,
    cardColor: AppPallete.greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.drawerColor,
      iconTheme: IconThemeData(
        color: AppPallete.whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppPallete.drawerColor,
    ),
    primaryColor: AppPallete.redColor,
    // AppPallete.backgroundColor: AppPallete.drawerColor, // will be used as alternative background color
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.whiteColor,
    cardColor: AppPallete.greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppPallete.blackColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppPallete.whiteColor,
    ),
    primaryColor: AppPallete.redColor,
    // AppPallete.backgroundColor: AppPallete.whiteColor,
  );
}
