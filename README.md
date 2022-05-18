# flutter_ip_adapter_info

Flutter plugin for getting `IP_ADAPTER_INFO` in windows.

Please refer to the [IP_ADAPTER_INFO](https://docs.microsoft.com/en-us/windows/win32/api/iptypes/ns-iptypes-ip_adapter_info) for details.

## Usage
```dart
import 'package:flutter_ip_adapter_info/flutter_ip_adapter_info.dart';

Future<List<IpAdapterInfo>> getIpAdapterInfo() async {
    final List<IpAdapterInfo> adapterInfoList =
        await FlutterIpAdapterInfo.getIpAdapterInfo();
    for (IpAdapterInfo ipAdapterInfo in adapterInfoList) {
        ipAdapterInfo.comboIndex; // Example: 7
        ipAdapterInfo.adapterName; // Example: {60E395DE-692F-4442-9068-B99472CFC104}
        ipAdapterInfo.description; // Example: Intel(R) Wi-Fi 6 AX200 160MHz
        ipAdapterInfo.addressLength; // Example: 6
        ipAdapterInfo.address; // Example: [176, 164, 96, 148, 131, 151, 0, 0]
        ipAdapterInfo.index; // Example: IpAdapterType.IF_TYPE_IEEE80211
        ipAdapterInfo.dhcpEnabled; // Example: 1
        ipAdapterInfo.ipAddressList; // Example: [{IpAddress: 192.168.0.4, IpMask: 255.255.255.0}]
        ipAdapterInfo.gatewayList; // Example: [{IpAddress: 192.168.0.1, IpMask: 255.255.255.255}]
        ipAdapterInfo.dhcpServer; // Example: [{IpAddress: 192.168.0.1, IpMask: 255.255.255.255}]
        ipAdapterInfo.haveWins; // Example: false
        ipAdapterInfo.primaryWinsServer; // Example: [{IpAddress: , IpMask: }]
        ipAdapterInfo.secondaryWinsServer; // Example: [{IpAddress: , IpMask: }]
        ipAdapterInfo.leaseObtained; // Example: 1652839476
        ipAdapterInfo.leaseExpires; // Example: 1652846676
        ipAdapterInfo.bDhcpEnabled; // Example: true
        ipAdapterInfo.macAddress; // Example: b0:a4:60:94:83:97
    }
    return adapterInfoList;
}
```
