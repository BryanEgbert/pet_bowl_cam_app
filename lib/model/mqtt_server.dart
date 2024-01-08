class MqttServerProperty {
  final String host;
  final int port;
  final String topic;
  final String? username;
  final String? password;

  MqttServerProperty({
    this.host = "127.0.0.1",
    this.port = 1883,
    required this.topic,
    this.username,
    this.password,
  });
}
