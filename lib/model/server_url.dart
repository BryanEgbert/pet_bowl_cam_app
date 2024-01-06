class ServerUrl {
  final String aiServer;
  final String mqttServer;

  ServerUrl({this.aiServer = "192.168.4.1", this.mqttServer = "127.0.0.1"});

  Map<String, dynamic> toMap() {
    return {
      'aiServer': aiServer,
      'mqttServer': mqttServer,
    };
  }
}
