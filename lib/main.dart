import 'package:bookledge/utility/app_theme.dart';
import 'package:bookledge/utility/preferences.dart';
import 'package:bookledge/views/home/home_page.dart';
import 'package:bookledge/views/intro_screen/intro_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Preferences prefs = await Preferences.instance();
  bool mediumExists = await prefs.hasMedium();
  bool stdExists = await prefs.hasStd();
  valueExists = mediumExists && stdExists;
  runApp(const MyApp());
}

bool valueExists = false;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookLedge',
      theme: AppTheme.theme,
      home: getPrimaryScreen(),
    );
  }

  Widget getPrimaryScreen() {
    if (valueExists) {
      return const HomePage();
    } else {
      return const IntroScreen();
    }
  }
}
