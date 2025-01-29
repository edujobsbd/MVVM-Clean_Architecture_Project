import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

import '../domain/model/model.dart';

Future<DeviceInfo> getDeviceInfo() async {
  String name = 'Unknown';
  String version = 'Unknown';
  String identifier = 'Unknown';

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      name = build.brand + ' ' + build.model;
      version = build.version.codename;
      identifier = build.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      name = iosInfo.name + ' ' + iosInfo.model;
      version = iosInfo.systemVersion;
      identifier = iosInfo.identifierForVendor;
    }
  } on PlatformException {
    return DeviceInfo(
      name,
      version,
      identifier,
    );
  }
  return DeviceInfo(name, version, identifier);
}
