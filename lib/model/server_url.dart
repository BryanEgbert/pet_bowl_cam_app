import 'package:pet_bowl_cam_app/model/mqtt_server.dart';

class Server {
  final String aiServer;
  final MqttServerProperty mqttServer;

  Server(
      {this.aiServer = "192.168.4.1",
      required this.mqttServer,
      String? password});
}
