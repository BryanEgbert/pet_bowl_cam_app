import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:pet_bowl_cam_app/model/mqtt_server.dart';

class MqttService {
  final MqttServerProperty property;
  final String clientId;

  MqttService({required this.clientId, required this.property});

  MqttServerClient connect() {
    MqttServerClient client =
        MqttServerClient.withPort(property.host, clientId, property.port);
    client.logging(on: true);
    client.keepAlivePeriod = 60;
    client.autoReconnect = true;
    client.manuallyAcknowledgeQos1 = false;

    final message = MqttConnectMessage()
        .authenticateAs(property.username, property.password)
        .startClean();

    client.connectionMessage = message;

    return client;
  }

  Future<void> subscribe(MqttServerClient client) async {
    client.subscribe(property.topic, MqttQos.atLeastOnce);

    client.updates?.listen((event) {
      final message = event[0].payload as MqttPublishMessage;

      print(
          "${event[0].topic} - ${MqttPublishPayload.bytesToStringAsString(message.payload.message)}");
    });
  }
}
