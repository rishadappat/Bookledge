import 'package:bookledge/utility/app_theme.dart';
import 'package:flutter/material.dart';

class BackLayer {
  const BackLayer({required this.context}) : super();
  final BuildContext context;
  Widget getView() {
    return SizedBox(
        height: 300.0,
        child: Center(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: const Text("Choose",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold))),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  child: TextField(
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                        backgroundColor: Colors.white,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      suffixIconColor: Colors.black,
                      hintText: "Select Medium",
                      border: InputBorder.none,
                    ),
                    onTap: () => mediumSelected(),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  child: TextField(
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                        backgroundColor: Colors.white,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      suffixIconColor: Colors.black,
                      hintText: "Select Class",
                      border: InputBorder.none,
                    ),
                    onTap: () => classSelected(),
                  ),
                )
              ],
            ),
          ),
        ])));
  }

  void mediumSelected() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text("Medium",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
              ),
              ListTile(
                leading: ImageIcon(
                  const AssetImage("lib/assets/mal.png"),
                  color: AppTheme.accentColor,
                ),
                title: const Text('Malayalam',
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: ImageIcon(
                  const AssetImage("lib/assets/en.png"),
                  color: AppTheme.accentColor,
                ),
                title: const Text('English',
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: ImageIcon(
                  const AssetImage("lib/assets/tam.png"),
                  color: AppTheme.accentColor,
                ),
                title:
                    const Text('Tamil', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: ImageIcon(
                  const AssetImage("lib/assets/kan.png"),
                  color: AppTheme.accentColor,
                ),
                title: const Text('Kannada',
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void classSelected() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text("Standard",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
              ),
              ListTile(
                leading: getNumberDigitIcon(1),
                title: const Text('Standard 1',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: getNumberDigitIcon(2),
                title: const Text('Standard 2',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: getNumberDigitIcon(3),
                title: const Text('Standard 3',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: getNumberDigitIcon(4),
                title: const Text('Standard 4',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: getNumberDigitIcon(5),
                title: const Text('Standard 5',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: getNumberDigitIcon(6),
                title: const Text('Standard 6',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: getNumberDigitIcon(7),
                title: const Text('Standard 7',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: getNumberDigitIcon(8),
                title: const Text('Standard 8',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: getNumberDigitIcon(9),
                title: const Text('Standard 9',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: getNumberDigitIcon(10),
                title: const Text('Standard 10',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: getNumberDigitIcon(11),
                title: const Text('Standard 11',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: getNumberDigitIcon(12),
                title: const Text('Standard 12',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Widget getNumberDigitIcon(int number) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppTheme.primaryColor),
      margin: const EdgeInsets.only(top: 5),
      child: Text(
        "$number",
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  void showBottomSheetList() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => FractionallySizedBox(
          heightFactor: 0.8,
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) => ListTile(
              leading: ImageIcon(
                const AssetImage("lib/assets/mal.png"),
                color: AppTheme.accentColor,
              ),
              title: const Text('Malayalam',
                  style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          )),
    );
  }
}
