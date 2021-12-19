import 'package:bookledge/models/lookup_model/lookup.dart';
import 'package:bookledge/utility/app_theme.dart';
import 'package:flutter/material.dart';

class LookupDialogs {
  void openMediumDialog(BuildContext rootContext,
      {required Function(Lookup) mediumSelected}) {
    showModalBottomSheet(
        isScrollControlled: false,
        context: rootContext,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (context) {
          return SafeArea(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.remove,
                color: Colors.grey[600],
              ),
              Container(
                margin: const EdgeInsets.all(10),
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
                  mediumSelected(Lookup(
                      name: 'Malayalam', id: 1, logo: "lib/assets/mal.png"));
                  Navigator.pop(rootContext);
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
                  mediumSelected(Lookup(
                      name: 'English', id: 2, logo: "lib/assets/en.png"));
                  Navigator.pop(rootContext);
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
                  mediumSelected(
                      Lookup(name: 'Tamil', id: 3, logo: "lib/assets/tam.png"));
                  Navigator.pop(rootContext);
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
                  mediumSelected(Lookup(
                      name: 'Kannada', id: 4, logo: "lib/assets/kan.png"));
                  Navigator.pop(rootContext);
                },
              ),
            ],
          ));
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

  void openClassDialog(BuildContext rootContext,
      {required Function(Lookup) classSelected}) {
    showModalBottomSheet(
      context: rootContext,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        expand: false,
        builder: (_, controller) => Column(
          children: [
            Icon(
              Icons.remove,
              color: Colors.grey[600],
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: const Text("Standard",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: 12,
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: getNumberDigitIcon(index + 1),
                    title: Text("Standard ${index + 1}",
                        style: const TextStyle(
                          color: Colors.black,
                        )),
                    onTap: () {
                      Navigator.pop(rootContext);
                      classSelected(Lookup(
                          name: "Standard ${index + 1}",
                          id: index + 1,
                          logo: ""));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
