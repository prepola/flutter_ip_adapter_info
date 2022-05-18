/// The IP_ADDR_STRING structure represents a node in
/// a linked-list of IPv4 addresses.
class IpAddrString {
  /// A value that specifies a structure type with a single member, String.
  ///
  /// The String member is a char array of size 16. This array holds
  /// an IPv4 address in dotted decimal notation.
  final String ipAddress;

  /// A value that specifies a structure type with a single member, String.
  ///
  /// The String member is a char array of size 16. This array holds
  /// the IPv4 subnet mask in dotted decimal notation.
  final String ipMask;

  const IpAddrString({
    required this.ipAddress,
    required this.ipMask,
  });

  factory IpAddrString.fromMap(Map<String, String> map) {
    return IpAddrString(
      ipAddress: map['IpAddress'] as String,
      ipMask: map['IpMask'] as String,
    );
  }

  @override
  String toString() {
    return '{IpAddress: $ipAddress, IpMask: $ipMask}';
  }
}
