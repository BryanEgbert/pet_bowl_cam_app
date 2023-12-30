class WiFi {
  final String ssid;
  final String password;
  final String ipAddress;
  final String subnetMask;
  final String dns;
  final String mac;

  WiFi(
      {this.ssid = "",
      this.password = "",
      this.ipAddress = "",
      this.subnetMask = "",
      this.dns = "",
      this.mac = ""});

  factory WiFi.fromJson(Map<String, dynamic> json) {
    return WiFi(
        ssid: json['ssid'],
        password: json['password'],
        ipAddress: json['ipAddress'],
        subnetMask: json['subnetMask'],
        dns: json['dns'],
        mac: json['mac']);
  }
}
