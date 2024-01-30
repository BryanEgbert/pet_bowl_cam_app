import 'dart:async';
import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pet_bowl_cam_mqtt_store.g.dart';

class PetBowlCamMqttStore = _PetBowlCamMqttStore with _$PetBowlCamMqttStore;

abstract class _PetBowlCamMqttStore with Store {
  @observable
  ObservableList<MqttReceivedMessage<MqttMessage>>? messages = ObservableList();

  @observable
  MqttServerClient? mqttClient;

  @action
  Future<void> connect() async {
    final prefs = await SharedPreferences.getInstance();

    MqttServerClient client = MqttServerClient.withPort(
        prefs.getString("mqttHost") ?? "127.0.0.1",
        DateTime.now().millisecondsSinceEpoch.toString(),
        prefs.getInt("mqttPort") ?? 1883);

    client.logging(on: true);
    client.keepAlivePeriod = 60;
    client.autoReconnect = true;
    client.manuallyAcknowledgeQos1 = false;

    final message = MqttConnectMessage()
        .authenticateAs(
            prefs.getString("mqttUsername"), prefs.getString("mqttPassword"))
        .startClean();

    client.connectionMessage = message;
    final connStatus = await client.connect();

    mqttClient = client;

    if (connStatus?.state == MqttConnectionState.connected) {
      client.subscribe(
          prefs.getString("mqttTopic") ?? "topic/queue", MqttQos.atLeastOnce);

      await for (final val in client.updates!) {
        messages!.addAll(val);
      }
    }
  }

  Map mqttMessageToListTile(String jsonString) {
    var jsonMessage = json.decode(jsonString);

    switch (jsonMessage["type"]) {
      case "lastWill":
        return {
          "title": "Hardware Disconnected Unexpectedly",
          "subtitle": DateTime.now().toString()
        };
      case "deviceResetNotification":
        return {"title": "Hardware Got Reset", "subtitle": jsonMessage["id"]};
      case "getLocalTIme":
        return {
          "title": jsonMessage["error"] == true
              ? "Failed Fetching Local Time"
              : "Successfully Fetched Local Time",
          "subtitle": jsonMessage["id"]
        };
      case "serverResponse":
        return {
          "title": 'AI Top Prediction: ${jsonMessage["data"]["top"]}',
          "subtitle": jsonMessage["data"]["prediction"]
        };
      default:
        return {
          "title": "Unknown Error",
          "subtitle": "An unknown error has occured"
        };
    }
  }

  void dispose() async {
    final prefs = await SharedPreferences.getInstance();

    mqttClient!.unsubscribe(prefs.getString("mqttTopic") ?? "topic/queue");
    mqttClient!.disconnect();
  }
}
