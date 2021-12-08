import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
      primarySwatch: navy, scaffoldBackgroundColor: const Color(0xff28293B));

  static MaterialColor navy = MaterialColor(
    0xFF5855D5,
    <int, Color>{
      50: accentColor,
      100: accentColor,
      200: accentColor,
      300: accentColor,
      400: accentColor,
      500: accentColor,
      600: accentColor,
      700: accentColor,
      800: accentColor,
      900: accentColor,
    },
  );

  static Color loaderColor = const Color(0xff44CCFC);

  static Color accentColor = const Color(0xFF5855D5);

  static Color bgColor = const Color(0xff28293B);
}
