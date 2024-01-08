import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pet_bowl_cam_mqtt_store.g.dart';

class PetBowlCamMqttStore = _PetBowlCamMqttStore with _$PetBowlCamMqttStore;

abstract class _PetBowlCamMqttStore with Store {
  final StreamController<List<MqttReceivedMessage<MqttMessage>>>
      _streamController =
      StreamController<List<MqttReceivedMessage<MqttMessage>>>();

  @observable
  ObservableStream<List<MqttReceivedMessage<MqttMessage>>>? mqttStream;

  @observable
  MqttServerClient? mqttClient;

  @observable
  ObservableFuture<MqttClientConnectionStatus?> connStatusFuture =
      ObservableFuture.value(null);

  Future<MqttServerClient> initClient() async {
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

    mqttClient = client;

    return mqttClient!;
  }

  @action
  Future<MqttClientConnectionStatus?> connect() async {
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
    connStatusFuture = ObservableFuture(client.connect());

    mqttClient = client;

    return connStatusFuture;
  }

  void listen() async {
    final prefs = await SharedPreferences.getInstance();

    mqttClient!.subscribe(
        prefs.getString("mqttTopic") ?? "topic/queue", MqttQos.atLeastOnce);

    _streamController.addStream(mqttClient!.updates!);
    mqttStream = ObservableStream(_streamController.stream);
  }

  void dispose() async {
    final prefs = await SharedPreferences.getInstance();

    await _streamController.close();
    mqttClient!.unsubscribe(prefs.getString("mqttTopic") ?? "topic/queue");
    mqttClient!.disconnect();
  }
}
