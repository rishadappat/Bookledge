import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
      primarySwatch: navy, scaffoldBackgroundColor: const Color(0xff28293B));

  static const MaterialColor navy = MaterialColor(
    0xFF5855D5,
    <int, Color>{
      50: Color(0xFF5855D5),
      100: Color(0xFF5855D5),
      200: Color(0xFF5855D5),
      300: Color(0xFF5855D5),
      400: Color(0xFF5855D5),
      500: Color(0xFF5855D5),
      600: Color(0xFF5855D5),
      700: Color(0xFF5855D5),
      800: Color(0xFF5855D5),
      900: Color(0xFF5855D5),
    },
  );

  static Color loaderColor = const Color(0xff44CCFC);
}
