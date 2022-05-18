import 'dart:typed_data';

import 'ip_adapter_type.dart';
import 'ip_addr_string.dart';

/// The IP_ADAPTER_INFO structure contains information about
/// a particular network adapter on the local computer.
class IpAdapterInfo {
  /// Reserved.
  final int comboIndex;

  /// An ANSI character string of the name of the adapter.
  final String adapterName;

  /// An ANSI character string that contains the description of the adapter.
  final String description;

  /// The length, in bytes, of the hardware address for the adapter.
  final int addressLength;

  /// The hardware address for the adapter represented as a string.
  final Uint8List address;

  /// The adapter index.
  ///
  /// The adapter index may change when an adapter is disabled and then enabled,
  ///  or under other circumstances, and should not be considered persistent.
  final int index;

  /// The adapter type. Possible values for the adapter type are listed
  /// in the Ipifcons.h header file.
  ///
  /// The table below lists common values for the adapter type although
  /// other values are possible on Windows Vista and later.
  final IpAdapterType type;

  /// An option value that specifies whether the dynamic host configuration
  /// protocol (DHCP) is enabled for this adapter.
  final int dhcpEnabled;

  /// The list of IPv4 addresses associated with this adapter represented as
  /// a list of IP_ADDR_STRING structures.
  ///
  /// An adapter can have multiple IPv4 addresses assigned to it.
  final List<IpAddrString> ipAddressList;

  /// The IPv4 address of the gateway for this adapter represented as
  /// a linked list of IP_ADDR_STRING structures.
  ///
  /// An adapter can have multiple IPv4 gateway addresses assigned to it.
  /// This list usually contains a single entry for IPv4 address
  /// of the default gateway for this adapter.
  final List<IpAddrString> gatewayList;

  /// The IPv4 address of the DHCP server for this adapter represented as
  /// a linked list of IP_ADDR_STRING structures.
  ///
  /// This list contains a single entry for the IPv4 address of the DHCP server
  /// for this adapter.
  ///
  /// A value of 255.255.255.255 indicates the DHCP server could not be reached,
  ///  or is in the process of being reached.
  ///
  /// This member is only valid when the DhcpEnabled member is nonzero.
  final List<IpAddrString> dhcpServer;

  /// An option value that specifies whether this adapter uses
  /// the Windows Internet Name Service (WINS).
  final bool haveWins;

  /// The IPv4 address of the primary WINS server represented as
  /// a linked list of IP_ADDR_STRING structures.
  ///
  /// This list contains a single entry for the IPv4 address of
  /// the primary WINS server for this adapter.
  ///
  /// This member is only valid when the HaveWins member is TRUE.
  final List<IpAddrString> primaryWinsServer;

  /// The IPv4 address of the secondary WINS server represented as
  /// a linked list of IP_ADDR_STRING structures.
  ///
  /// An adapter can have multiple secondary WINS server addresses
  /// assigned to it.
  ///
  /// This member is only valid when the HaveWins member is TRUE.
  final List<IpAddrString> secondaryWinsServer;

  /// The time when the current DHCP lease was obtained.
  ///
  /// This member is only valid when the DhcpEnabled member is nonzero.
  final int leaseObtained;

  /// The time when the current DHCP lease expires.
  ///
  /// This member is only valid when the DhcpEnabled member is nonzero.
  final int leaseExpires;

  const IpAdapterInfo({
    required this.comboIndex,
    required this.adapterName,
    required this.description,
    required this.addressLength,
    required this.address,
    required this.index,
    required this.type,
    required this.dhcpEnabled,
    required this.ipAddressList,
    required this.gatewayList,
    required this.dhcpServer,
    required this.haveWins,
    required this.primaryWinsServer,
    required this.secondaryWinsServer,
    required this.leaseObtained,
    required this.leaseExpires,
  });

  factory IpAdapterInfo.fromMap(Map<String, dynamic> map) {
    return IpAdapterInfo(
      comboIndex: map['ComboIndex'] as int,
      adapterName: map['AdapterName'] as String,
      description: map['Description'] as String,
      addressLength: map['AddressLength'] as int,
      address: map['Address'] as Uint8List,
      index: map['Index'] as int,
      type: const <int, IpAdapterType>{
            1: IpAdapterType.MIB_IF_TYPE_OTHER,
            6: IpAdapterType.MIB_IF_TYPE_ETHERNET,
            9: IpAdapterType.IF_TYPE_ISO88025_TOKENRING,
            23: IpAdapterType.MIB_IF_TYPE_PPP,
            24: IpAdapterType.MIB_IF_TYPE_LOOPBACK,
            28: IpAdapterType.MIB_IF_TYPE_SLIP,
            71: IpAdapterType.IF_TYPE_IEEE80211,
          }[map['Type'] as int] ??
          IpAdapterType.MIB_IF_TYPE_OTHER,
      dhcpEnabled: map['DhcpEnabled'] as int,
      ipAddressList: (map['IpAddressList'] as List)
          .map((e) => IpAddrString.fromMap(Map<String, String>.from(e)))
          .toList(),
      gatewayList: (map['GatewayList'] as List)
          .map((e) => IpAddrString.fromMap(Map<String, String>.from(e)))
          .toList(),
      dhcpServer: (map['DhcpServer'] as List)
          .map((e) => IpAddrString.fromMap(Map<String, String>.from(e)))
          .toList(),
      haveWins: map['HaveWins'] as bool,
      primaryWinsServer: (map['PrimaryWinsServer'] as List)
          .map((e) => IpAddrString.fromMap(Map<String, String>.from(e)))
          .toList(),
      secondaryWinsServer: (map['SecondaryWinsServer'] as List)
          .map((e) => IpAddrString.fromMap(Map<String, String>.from(e)))
          .toList(),
      leaseObtained: map['LeaseObtained'] as int,
      leaseExpires: map['LeaseExpires'] as int,
    );
  }

  /// Returns the `dhcpEnabled` value to bool
  ///
  /// If true, `dhcpEnabled` is "NONZERO".
  bool get bDhcpEnabled => dhcpEnabled != 0;

  /// `address` to string
  String get macAddress => address
      .sublist(0, addressLength)
      .map((e) => e.toRadixString(16))
      .join(':');

  @override
  String toString() {
    return '{comboIndex: $comboIndex, adapterName: $adapterName, '
        'description: $description, addressLength: $addressLength, '
        'address: $address, index: $index, type: $type, '
        'dhcpEnabled: $dhcpEnabled, ipAddressList: $ipAddressList, '
        'gatewayList: $gatewayList, ${dhcpEnabled != 0 ? 'dhcpServer: $dhcpServer, ' : ''}'
        'haveWins: $haveWins, ${haveWins ? 'primaryWinsServer: $primaryWinsServer, '
            'secondaryWinsServer: $secondaryWinsServer, ' : ''}'
        'leaseObtained: $leaseObtained, leaseExpires: $leaseExpires}';
  }
}
