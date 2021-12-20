import 'package:bookledge/utility/app_theme.dart';
import 'package:bookledge/utility/preferences.dart';
import 'package:bookledge/views/CustomViews/lookup_dialogs.dart';
import 'package:bookledge/views/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late final AnimationController _controller;
  Preferences? prefs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    getPreferences();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: PageView(
        // physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          getIntroScreen('lib/assets/language_anim.json', "Select Medium",
              buttonClicked: () {
            LookupDialogs().openMediumDialog(context, mediumSelected: (medium) {
              prefs?.saveMedium(medium.id);
              gotoNextScreen();
            });
          }),
          getIntroScreen('lib/assets/class_anim.json', "Select Standard",
              buttonClicked: () {
            LookupDialogs().openClassDialog(context, classSelected: (std) {
              prefs?.saveStandard(std.id);
              gotoHomeScreen(context);
            });
          })
        ],
      ),
    );
  }

  void getPreferences() async {
    prefs = await Preferences.instance();
  }

  Widget getIntroScreen(String animName, String buttonText,
      {required Function() buttonClicked}) {
    return SafeArea(
      child: Column(children: [
        Expanded(
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: SizedBox(
            width: double.infinity,
            height: 300,
            child: Lottie.asset(
              animName,
              repeat: true,
              reverse: true,
              animate: true,
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Container(
          width: 200,
          height: 50,
          margin: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                primary: AppTheme.accentColor,
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onPressed: () {
              buttonClicked();
            },
            child: Text(buttonText),
          ),
        ),
      ]),
    );
  }

  void gotoNextScreen() {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void gotoHomeScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute<dynamic>(
          builder: (_) => const HomePage(),
        ),
        (route) => false);
  }
}
