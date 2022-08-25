import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../utility/app_theme.dart';
import '../CustomViews/listviews/list_item.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('About'),
        ),
        body: Column(children: [
          Container(
            padding:
                const EdgeInsets.only(top: 15, left: 12, right: 12, bottom: 10),
            child: FutureBuilder(
              future: getItems(),
              builder: (context, AsyncSnapshot snapshot) {
                var items = snapshot.data;
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      var radius = const BorderRadius.all(Radius.circular(0));
                      if (index == 0 || items[index - 1] is HeadingItem) {
                        radius = const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10));
                      } else if (index == items.length - 1 ||
                          items[index - 1] is HeadingItem) {
                        radius = const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10));
                      } else if (items[index - 1] is HeadingItem) {
                        radius = const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10));
                      } else if (items[index + 1] is HeadingItem) {
                        radius = const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10));
                      }
                      return item is HeadingItem
                          ? item.title == ""
                              ? const SizedBox(
                                  height: 15,
                                )
                              : ListTile(
                                  title: item.buildTitle(context),
                                  dense: true,
                                )
                          : Card(
                              margin: EdgeInsets.zero,
                              shadowColor: AppTheme.secondaryColor,
                              color: AppTheme.secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: radius,
                              ),
                              elevation: 15,
                              child: ListTile(
                                dense: true,
                                title: item.buildTitle(context),
                                subtitle: item.buildSubtitle(context),
                                leading: SizedBox(
                                    height: double.infinity,
                                    child: item.buildIcon(context)),
                              ),
                            );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ]));
  }
}

Future<List<ListItem>> getItems() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  List<ListItem> items = [];
  items.add(AboutItem(
      "Package Name", packageInfo.packageName, Icons.android_outlined));
  items.add(AboutItem("Version", packageInfo.version, Icons.info_outline));
  items.add(AboutItem("Data Source", "https://samagra.kite.kerala.gov.in",
      Icons.cloud_download_outlined));
  items.add(HeadingItem("Developer"));

  items.add(AboutItem("LinkedIn", "https://www.linkedin.com/in/rishadappat",
      Icons.link_outlined));
  items.add(AboutItem(
      "Github", "https://github.com/rishadappat", Icons.source_outlined));
  items.add(AboutItem(
      "Twitter", "https://twitter.com/rishadappat", Icons.tab_outlined));
  return items;
}
