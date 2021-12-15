import 'package:flutter/material.dart';

// class AppTheme {
//   static ThemeData theme = ThemeData(
//       primarySwatch: primaryColor,
//       scaffoldBackgroundColor: const Color(0xff28293B));

//   static MaterialColor primaryColor = MaterialColor(
//     0xFF5855D5,
//     <int, Color>{
//       50: accentColor,
//       100: accentColor,
//       200: accentColor,
//       300: accentColor,
//       400: accentColor,
//       500: accentColor,
//       600: accentColor,
//       700: accentColor,
//       800: accentColor,
//       900: accentColor,
//     },
//   );

//   static Color loaderColor = const Color(0xff44CCFC);

//   static Color accentColor = const Color(0xFF5855D5);

//   static Color bgColor = const Color(0xff28293B);
// }

class AppTheme {
  static ThemeData theme =
      ThemeData(primarySwatch: primaryColor, scaffoldBackgroundColor: bgColor);

  static MaterialColor primaryColor = MaterialColor(
    0xFFe63946,
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

  static Color accentColor = const Color(0xFFe63946);

  static Color bgColor = const Color(0xff1d3557);

  static Color buttonColor = const Color(0xff385077);
}
