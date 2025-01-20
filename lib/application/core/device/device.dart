import 'dart:io';

import 'package:flutter/foundation.dart';

enum DeviceType {
  ios,
  android,
  web,
  unknown,
}

DeviceType getDeviceType() {
  if (kIsWeb){
    return DeviceType.web;
  }
  else if (Platform.isIOS) {
    return DeviceType.ios;
  } else if (Platform.isAndroid) {
    return DeviceType.android;
  } else {
    return DeviceType.unknown;
  }
}
