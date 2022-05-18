// ignore_for_file: constant_identifier_names

/// The adapter type. Possible values for the adapter type are listed
/// in the Ipifcons.h header file.
///
/// The table below lists common values for the adapter type although
/// other values are possible on Windows Vista and later.
enum IpAdapterType {
  /// Some other type of network interface.
  MIB_IF_TYPE_OTHER,

  /// An Ethernet network interface.
  MIB_IF_TYPE_ETHERNET,

  /// MIB_IF_TYPE_TOKENRING
  IF_TYPE_ISO88025_TOKENRING,

  /// A PPP network interface.
  MIB_IF_TYPE_PPP,

  /// A software loopback network interface.
  MIB_IF_TYPE_LOOPBACK,

  /// An ATM network interface.
  MIB_IF_TYPE_SLIP,

  /// An IEEE 802.11 wireless network interface.
  ///
  /// Note. This adapter type is returned on Windows Vista and later.
  /// On Windows Server 2003 and Windows XP , an IEEE 802.11 wireless network
  /// interface returns an adapter type of MIB_IF_TYPE_ETHERNET.
  IF_TYPE_IEEE80211,
}
