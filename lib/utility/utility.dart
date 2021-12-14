// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';

enum DeviceType { Phone, Tablet }

class Utility {
  DeviceType getDeviceType() {
    final data = MediaQueryData.fromWindow((WidgetsBinding.instance?.window)!);
    return data.size.shortestSide < 550 ? DeviceType.Phone : DeviceType.Tablet;
  }
}
