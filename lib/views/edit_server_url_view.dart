import 'package:flutter/material.dart';
import 'package:pet_bowl_cam_app/main.dart';
import 'package:pet_bowl_cam_app/model/server_url.dart';
import 'package:pet_bowl_cam_app/store/pet_bowl_cam_api_store.dart';

class EditServerUrlView extends StatelessWidget {
  const EditServerUrlView(
      {super.key, required this.initialInfo, required this.store});

  final ServerUrl initialInfo;
  final PetBowlCamAPIStore store;

  @override
  Widget build(BuildContext context) {
    final TextEditingController aiUrlEditController =
        TextEditingController(text: initialInfo.aiServer);
    final TextEditingController mqttUrlEditController =
        TextEditingController(text: initialInfo.mqttServer);
    return Material(
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
              TextField(
                controller: mqttUrlEditController,
                decoration: const InputDecoration(
                    labelText: "MQTT Server URL", hintText: "192.168.4.1"),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      store.updateServerUrl(
                        ServerUrl(
                          aiServer: aiUrlEditController.value.text,
                          mqttServer: mqttUrlEditController.value.text,
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
    );
  }
}
