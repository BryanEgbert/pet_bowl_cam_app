import 'package:flutter/material.dart';
import 'package:pet_bowl_cam_app/main.dart';
import 'package:pet_bowl_cam_app/model/mqtt_server.dart';
import 'package:pet_bowl_cam_app/model/server_url.dart';
import 'package:pet_bowl_cam_app/store/pet_bowl_cam_api_store.dart';

class EditServerUrlView extends StatelessWidget {
  const EditServerUrlView(
      {super.key, required this.initialInfo, required this.store});

  final Server initialInfo;
  final PetBowlCamAPIStore store;

  @override
  Widget build(BuildContext context) {
    final TextEditingController aiUrlEditController =
        TextEditingController(text: initialInfo.aiServer);
    final TextEditingController mqttHostEditController =
        TextEditingController(text: initialInfo.mqttServer.host);
    final TextEditingController mqttPortEditController =
        TextEditingController(text: initialInfo.mqttServer.port.toString());
    final TextEditingController mqttUsernameEditController =
        TextEditingController(text: initialInfo.mqttServer.username);
    final TextEditingController mqttPasswordEditController =
        TextEditingController(text: initialInfo.mqttServer.password);
    final TextEditingController mqttTopicEditController =
        TextEditingController(text: initialInfo.mqttServer.topic);

    return Scaffold(
      appBar: AppBar(
        title: const Text("PetBowlCam App"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Material(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: aiUrlEditController,
                  decoration: const InputDecoration(
                      labelText: "AI Server URL", hintText: "192.168.4.1"),
                ),
                const Divider(),
                TextField(
                  controller: mqttHostEditController,
                  decoration: const InputDecoration(
                      labelText: "MQTT Server Host", hintText: "127.0.0.1"),
                ),
                TextField(
                  controller: mqttPortEditController,
                  decoration: const InputDecoration(
                      labelText: "MQTT Server Host", hintText: "1883"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: mqttTopicEditController,
                  decoration: const InputDecoration(
                      labelText: "MQTT Topic", hintText: "topic/queue"),
                ),
                TextField(
                  controller: mqttUsernameEditController,
                  decoration: const InputDecoration(
                      labelText: "MQTT Username (Optional)"),
                ),
                TextField(
                  controller: mqttPasswordEditController,
                  decoration: const InputDecoration(
                      labelText: "MQTT Password (Optional)"),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        store.updateServerUrl(
                          Server(
                            aiServer: aiUrlEditController.value.text,
                            mqttServer: MqttServerProperty(
                                topic: mqttTopicEditController.value.text,
                                host: mqttHostEditController.value.text,
                                port: int.parse(
                                    mqttPortEditController.value.text),
                                username: mqttUsernameEditController
                                        .value.text.isEmpty
                                    ? null
                                    : mqttUsernameEditController.value.text,
                                password: mqttPasswordEditController
                                        .value.text.isEmpty
                                    ? null
                                    : mqttPasswordEditController.value.text),
                          ),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(
                              selectedIndex: 1,
                            ),
                          ),
                        );
                      },
                      child: const Text("Save"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
