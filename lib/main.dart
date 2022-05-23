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
  var valueExists = mediumExists && stdExists;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(valueExists: valueExists));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.valueExists}) : super(key: key);

  final bool valueExists;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState();

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
    if (widget.valueExists) {
      return const HomePage();
    } else {
      return const IntroScreen();
    }
  }
}
