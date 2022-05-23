import 'package:flutter/material.dart';

abstract class ListItem {
  Widget buildTitle(BuildContext context);

  Widget buildSubtitle(BuildContext context);

  Widget buildIcon(BuildContext context);
}

class HeadingItem implements ListItem {
  final String title;

  HeadingItem(this.title);

  @override
  Widget buildTitle(BuildContext context) {
    if (title == "") {
      return const SizedBox.shrink();
    } else {
      return Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();

  @override
  Widget buildIcon(BuildContext context) => const SizedBox.shrink();
}

class AboutItem implements ListItem {
  final String title;
  final String subTitle;
  final IconData icon;

  AboutItem(this.title, this.subTitle, this.icon);

  @override
  Widget buildTitle(BuildContext context) => Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      );

  @override
  Widget buildSubtitle(BuildContext context) => Text(
        subTitle,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      );

  @override
  Widget buildIcon(BuildContext context) {
    return Icon(
      icon,
      color: Colors.white,
    );
  }
}
