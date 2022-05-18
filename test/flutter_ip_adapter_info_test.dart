import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ip_adapter_info/flutter_ip_adapter_info.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('getPlatformVersion', () async {
    debugPrint((await FlutterIpAdapterInfo.getIpAdapterInfo()).toString());
  });
}
