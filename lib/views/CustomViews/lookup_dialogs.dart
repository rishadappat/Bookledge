import 'package:bookledge/models/lookup_model/lookup.dart';
import 'package:bookledge/utility/app_theme.dart';
import 'package:flutter/material.dart';

import '../../utility/utility.dart';

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
                  mediumSelected(Utility().getLookupForMedium(1));
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
                  mediumSelected(Utility().getLookupForMedium(2));
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
                  mediumSelected(Utility().getLookupForMedium(3));
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
                  mediumSelected(Utility().getLookupForMedium(4));
                  Navigator.pop(rootContext);
                },
              ),
            ],
          ));
        });
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
                    leading: Utility().getNumberDigitIcon(index + 1),
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
