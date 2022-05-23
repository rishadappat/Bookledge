// ignore_for_file: constant_identifier_names

import 'package:bookledge/models/lookup_model/lookup.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

enum DeviceType { Phone, Tablet }

class Utility {
  DeviceType getDeviceType() {
    final data = MediaQueryData.fromWindow((WidgetsBinding.instance.window));
    return data.size.shortestSide < 550 ? DeviceType.Phone : DeviceType.Tablet;
  }

  double deviceWidth() {
    final data = MediaQueryData.fromWindow((WidgetsBinding.instance.window));
    return data.size.width;
  }

  Widget getNumberDigitIcon(int number) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppTheme.primaryColor),
      child: Text(
        "$number",
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Lookup getLookupForMedium(int id) {
    var medium = ["Malayalam", "English", "Tamil", "Kannada"];
    var icons = [
      "lib/assets/mal.png",
      "lib/assets/en.png",
      "lib/assets/tam.png",
      "lib/assets/kan.png"
    ];
    if (id != 0) {
      return Lookup(name: medium[id - 1], id: id, logo: icons[id - 1]);
    } else {
      return Lookup(name: "", id: id, logo: "");
    }
  }
}
