class TimeServer {
  final String timeServer1;
  final String timeServer2;
  final String timeServer3;

  TimeServer(
      {this.timeServer1 = "", this.timeServer2 = "", this.timeServer3 = ""});

  factory TimeServer.fromJson(Map<String, dynamic> json) {
    return TimeServer(
      timeServer1: json['server1'],
      timeServer2: json['server2'],
      timeServer3: json['server3'],
    );
  }
}
