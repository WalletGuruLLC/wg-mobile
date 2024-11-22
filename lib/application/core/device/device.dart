import 'dart:io';

enum DeviceType {
  ios,
  android,
  unknown,
}

DeviceType getDeviceType() {
  if (Platform.isIOS) {
    return DeviceType.ios;
  } else if (Platform.isAndroid) {
    return DeviceType.android;
  } else {
    return DeviceType.unknown;
  }
}
