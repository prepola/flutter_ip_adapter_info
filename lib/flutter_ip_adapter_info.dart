// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_ip_adapter_info/src/ip_adapter_info.dart';

export 'package:flutter_ip_adapter_info/src/ip_adapter_info.dart'
    show IpAdapterInfo;
export 'package:flutter_ip_adapter_info/src/ip_adapter_type.dart'
    show IpAdapterType;
export 'package:flutter_ip_adapter_info/src/ip_addr_string.dart'
    show IpAddrString;

class FlutterIpAdapterInfo {
  static const MethodChannel _channel =
      MethodChannel('prepola.dev/flutter_ip_adapter_info');

  /// Return `IP_ADAPTER_INFO` List
  ///
  /// if the platform is not supported, Returns an empty list.
  static Future<List<IpAdapterInfo>> getIpAdapterInfo() async {
    if (!kIsWeb && !Platform.isWindows) {
      print('not support platforms');
      return [];
    }
    final List? ipAdapterInfoMap =
        await _channel.invokeMethod('getIpAdapterInfo');
    if (ipAdapterInfoMap == null) return [];
    return ipAdapterInfoMap
        .map((e) => IpAdapterInfo.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }
}
